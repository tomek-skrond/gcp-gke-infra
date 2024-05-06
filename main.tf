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
    helm = {
      source = "hashicorp/helm"
    }
  }
  backend "gcs" {}
}


module "cluster" {
  source = "./modules/gke/"

  # cloudflare_api_token           = var.cloudflare_api_token
  # cloudflare_zone_id             = var.cloudflare_zone_id
  cluster_name                   = var.cluster_name
  domain_name                    = var.domain_name
  credential_file                = var.credential_file
  project_id                     = var.project_id
  region                         = var.region
  network                        = var.network
  subnetwork                     = var.subnetwork
  ip_range_pods                  = var.ip_range_pods
  ip_range_services              = var.ip_range_services
  compute_engine_service_account = var.compute_engine_service_account
  cluster_static_ip              = var.cluster_static_ip
}

# module "cf" {
#   source = "./modules/cf"

#   cloudflare_zone_id = var.cloudflare_zone_id
#   cloudflare_api_token = var.cloudflare_api_token
#   ip_address = module.cluster.cluster_ip_address

# }
# module "argocd" {
#   source                 = "./modules/argocd/"
#   credential_file        = var.credential_file
#   project_id             = var.project_id
#   region                 = var.region
#   cluster_ca_certificate = module.cluster.ca_certificate
#   cluster_endpoint       = module.cluster.kubernetes_endpoint
#   token                  = module.cluster.client_token
#   cluster_name = module.cluster.cluster_name
#   argo_depends_on = [module.cluster]
# }