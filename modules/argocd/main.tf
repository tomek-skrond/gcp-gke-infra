provider "google" {
  credentials = var.credential_file
  project     = var.project_id
  region      = var.region
  # zone        = var.zone
}

data "google_client_config" "default" {
  provider = google
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.cluster_endpoint}"
    token                  = var.token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}


resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.9.7"
  create_namespace = true

  values = [
    file("argo-config/application.yaml")
  ]
}