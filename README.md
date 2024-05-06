# gcp-gke-infra
Infrastructure project for deploying GKE cluster. Linked with `recipe-app` and `recipe-app-manifests` projects.

Full project diagram below:
![full_infra drawio](https://github.com/tomek-skrond/gcp-gke-infra/assets/58492207/d829c921-b9f4-43b1-a6be-4ed9034f7080)

### Project status
- `gcp-gke-infra` is working, needs a few minor adjustments, overall stable
- `recipe-app` is done and working properly
- `recipe-app-manifests` lacks ArgoCD configurations, application is built by Github Workflow instead of Argo CD

### Quick Guide
Before any configurations, be sure to set all required variables and secrets in repo. <br>
Use `kickstart` folder to create backend buckets.<br>
Variables needed to create backend buckets:
```
variable "credential_file" {
    type = string
    sensitive = true
}
variable "project_id" {}
variable "region" {}
variable "bucket_name" {}
```

After provisioning a backend bucket, create these variables in Github Actions: <br>
Variables needed to deploy a GKE cluster:
```
variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}
variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type      = string
  sensitive = true
}
variable "credential_file" {
  type      = string
  sensitive = true
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  # sensitive   = true
}

variable "cluster_name" {
  description = "Cluster name"
}

variable "cluster_static_ip" {
  description = "Static IP resource name for Cluster's Ingress Controller"
}
```
Github Workflow takes care of variables validation, after validating, you can start workflow manually (terraform apply/destroy `workflow_dispatch`). After provisioning cluster, start workflow `Trigger Target Workflow` to trigger deployment in `recipe-app-manifests` project.
