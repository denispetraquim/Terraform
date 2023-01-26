terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "dop_v1_36049ee371db80edea5c295b41d5d588f66d2ea6b789120159586f16fba27f1b"
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "jenkins" {
  image    = "ubuntu-22-04-x64"
  name     = "jujulinda"
  region   = "nyc1"
  size     = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.example.id]
}
# Create a new SSH key
data "digitalocean_ssh_key" "example" {
  name = "Jornada"
}

resource "digitalocean_kubernetes_cluster" "foo" {
  name   = "foo"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.22.8-do.1"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3
  }
}