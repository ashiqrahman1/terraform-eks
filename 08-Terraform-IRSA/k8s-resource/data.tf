data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-348190712607"
    key = "dev/cluster-info/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}