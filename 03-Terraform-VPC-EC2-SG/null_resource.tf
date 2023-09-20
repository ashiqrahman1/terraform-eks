resource "null_resource" "test" {
  depends_on = [ module.ec2_instance ]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("/home/ashiq/.ssh/terraform")
      host = module.ec2_instance.public_ip
    }

    provisioner "file" {
      source = "/home/ashiq/.ssh/terraform"
      destination = "/home/ec2-user/.ssh/terraform"
    }

    provisioner "remote-exec" {
        inline = [ "chmod 400 /home/ec2-user/.ssh/terraform" ]
    }
}