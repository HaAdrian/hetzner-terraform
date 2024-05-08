variable "token" {
    type = string
    description = "Hetzner-Cloud token"
    sensitive = true
}

variable "name" {
    type = string
    description = "Server name"
}

variable "image" {
    type = string
    description = "Server image"
}

variable "server_type" {
    type = string
    description = "Server type"
}

variable "ipv4_enabled" {
  type = string
  description = "IPv4 enabled"
}

variable "location" {
  type = string
  description = "Server location"
}

variable "volume_size" {
  type = number
  description = "Volume size"
}

variable "volume_enabled" {
  type = bool
  description = "Volume enabled"
}