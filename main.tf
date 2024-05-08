module "hetzner" {
    source = "./hetzner"
    token = var.hetzner_token
    volume_size = var.volume_size
    volume_enabled = var.volume_enabled
    server_type = var.server_type
    name = var.name
    location = var.location
    ipv4_enabled = var.ipv4_enabled
    image = var.image
}