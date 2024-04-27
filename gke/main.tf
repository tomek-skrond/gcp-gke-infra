terraform {
  required_version = ">= 0.13"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    google = {
      source = "hashicorp/google"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  backend "gcs" {}
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

### cluster
locals {
  cluster_type = "stub-domains"
}

provider "google" {
  credentials = var.credential_file
  project     = var.project_id
  region      = var.region
  # zone        = var.zone
}

data "google_client_config" "default" {
  provider = google
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 30.0"

  project_id             = var.project_id
  name                   = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  region                 = var.region
  network                = module.gcp-network.network_name
  subnetwork             = module.gcp-network.subnets_names[0]
  ip_range_pods          = var.ip_range_pods
  ip_range_services      = var.ip_range_services
  service_account        = var.compute_engine_service_account
  create_service_account = false
  deletion_protection    = false

  configure_ip_masq = true

  stub_domains = {
    "*.${var.domain_name}" = [
      "1.1.1.1",
      "raegan.ns.cloudflare.com",
      "tim.ns.cloudflare.com"
    ]
  }
}