data "hcloud_ssh_key" "ssh_key_1" {
    name = "ssh_key_1"
}

data "local_file" "ssh_key_1" {
    filename = ".keys/ssh_key_1"
}