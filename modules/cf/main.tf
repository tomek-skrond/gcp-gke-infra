terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
    api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "default" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = var.ip_address
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "recipes" {
  zone_id = var.cloudflare_zone_id
  name    = "recipes"
  target  = "@"
  type    = "CNAME"
  proxied = false
}
