resource "hcloud_server" "master" {
    name = var.name
    image = var.image
    server_type = var.server_type
    location = var.location
    ssh_keys = [ data.hcloud_ssh_key.ssh_key_1.id ]
    public_net {
      ipv4_enabled = var.ipv4_enabled
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'Waiting for cloud-init to complete...'",
            "cloud-init status --wait > /dev/null",
            "echo 'Completed cloud-init!'",
        ]

        connection {
            type        = "ssh"
            host        = self.ipv4_address
            user        = "root"
            private_key = data.local_file.ssh_key_1.content
        }
    }
}

resource "hcloud_volume" "master" {
    count      = var.volume_enabled ? 1 : 0
    name       = var.name
    size       = var.volume_size
    server_id  = hcloud_server.master.id
    automount  = false
    depends_on = [ hcloud_server.master ]
}

resource "null_resource" "mount_volume" {
    count      = var.volume_enabled ? 1 : 0
    provisioner "remote-exec" {
        inline = [
            "mkfs.ext4 /dev/disk/by-id/scsi-SHC_Volume_${hcloud_volume.master[count.index].id}",
            "mkdir -p /opt/",
            "echo '/dev/disk/by-id/scsi-SHC_Volume_${hcloud_volume.master[count.index].id} /opt/ ext4 discard,defaults 0 0' >> /etc/fstab",
            "mount -a",
        ]
    }

    connection {
        host        = hcloud_server.master.ipv4_address
        user        = "root"
        type        = "ssh"
        private_key = data.local_file.ssh_key_1.content
    }
    depends_on = [ hcloud_volume.master ]
}