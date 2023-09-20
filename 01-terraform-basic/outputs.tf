output public_ip {
  value       = aws_instance.instance.public_ip
  description = "description"
  depends_on  = []
}
