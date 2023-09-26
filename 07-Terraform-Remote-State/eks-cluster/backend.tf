terraform {
  backend "s3" {
    bucket = "terraform-remote-state-881999198226"
    key = "dev/cluster-info/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}