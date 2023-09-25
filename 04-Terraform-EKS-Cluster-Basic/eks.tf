resource "aws_eks_cluster" "eks" {
  name = "Terraform_eks"
  role_arn = aws_iam_role.cluster_role.arn
  vpc_config {
    subnet_ids = module.vpc.public_subnets
    endpoint_public_access = true
  }
  version = "1.27"
}