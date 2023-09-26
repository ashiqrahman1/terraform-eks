terraform {
  backend "s3" {
    bucket = "terraform-remote-state-881999198226"
    key = "dev/k8s-resource/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host = data.terraform_remote_state.eks.outputs.eks_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.eks_cluster_certificate_authority)
  token = data.aws_eks_cluster_auth.eks.token
}