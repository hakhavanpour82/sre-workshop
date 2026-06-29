terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.52.0"
    }
  }
}

# This documents your target Hetzner architecture node
data "hcloud_server" "existing_server" {
  with_selector = "app=sre-workshop"
}

