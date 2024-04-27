locals {
  bucket_name = "gke-state-bucket"
}

resource "google_storage_bucket" "gkestate" {
  name          = local.bucket_name
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}

output "bucket_name" {
  value = local.bucket_name
}