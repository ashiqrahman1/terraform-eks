variable instance_type {
  type        = string
  default     = "t2.micro"
  description = "description"
}

variable egress_rule {
  type        = string
  default     = "0.0.0.0/0"
  description = "default egress rule"
}

variable http_sg {
  type        = number
  default     = 80
  description = "allow port 80"
}

variable ssh_sg {
  type        = number
  default     = 22
  description = "allow port 22"
}


