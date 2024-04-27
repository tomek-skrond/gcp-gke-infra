variable "credential_file" {
  type      = string
  sensitive = true
}
variable "region" {
  description = "The region to host the cluster in"
}
variable "project_id" {
  description = "The project ID to host the cluster in"
}
variable "cluster_ca_certificate" {
    description = "Cluster CA Certificate"
}
variable "cluster_endpoint" {
    description = "Cluster Endpoint"
}
variable "token" {
    
}