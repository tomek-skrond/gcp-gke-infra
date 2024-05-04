# variable "cloudflare_api_token" {
#   type      = string
#   sensitive = true
# }
# variable "cloudflare_zone_id" {
#   type      = string
#   sensitive = true
# }
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