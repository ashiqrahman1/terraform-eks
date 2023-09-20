# Bastion Host
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.name}-Bastion"

  instance_type          = var.instance_type
  key_name               = aws_key_pair.mykey.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = local.common_tags
}

resource "aws_key_pair" "mykey" {
  key_name = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxAy3vh7ZDnsvqac9joLTdZS23eyMaRJyxPZwUodxBiuBVaB7I9MoumI6BH1BAa3J8SLOoocililnDdoS9jIeAEkTukZnCIo/tvFPC+1dGxogcEn7dfYoKTJHmSt2AlQxR5Gc/pB4DgYKvfv/0K2El9IgCO72BRioDYGZgas7r61lwenMUD0fcCtUQFNH0dOuTeH6Ofy3U0YKDGnQCILmPHmshg1EEY/ILY3RUlwv5LrcvVatYxK5z/WxK9e8UXNQW771Mu35yFgC/ZukvEEbfWT7Jeg8V1bT45LcsCTY0IsyHzlMZKjwwSZqOpJpJH7Pd9thV8gvLgExSkUR2BfKzTMr1s5vijsqlbRjS+a3Z7iRFnxMEPxcnjQeC3Wr86cPRpBwsg8ZOknKuC4naQbZsu9X9iJqJNe63wgZKCe6xFbMRnRhUiGXS1YJlKB9H2VWbxBYGFZC8fH4DvvV04NkQn9pt3QI/PfRq8yO/kCeb+2ZcCs/BTJhyLyP3TO2FtPE= ashiq@ashiq-ThinkPad-T460"
}