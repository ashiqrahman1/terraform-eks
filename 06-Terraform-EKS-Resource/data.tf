data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "../04-Terraform-EKS-Cluster-Basic/terraform.tfstate"
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}