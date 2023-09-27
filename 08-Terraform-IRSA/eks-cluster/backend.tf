terraform {
  backend "s3" {
    bucket = "terraform-348190712607"
    key = "dev/cluster-info/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "terraform-state-lock"
  }
}