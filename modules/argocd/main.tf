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
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["container", "clusters", "get-credentials", var.cluster_name, "--region", var.region, "--project", var.project_id]
      command     = "gcloud"
    }
  }
}

variable "argo_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}
# resource "null_resource" "module_depends_on" {
#   triggers = {
#     value = "${length(var.module_depends_on)}"
#   }
# }


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

  depends_on = [var.argo_depends_on]
}