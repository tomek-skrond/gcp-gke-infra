resource "google_compute_address" "default" {
  name = var.cluster_static_ip
}