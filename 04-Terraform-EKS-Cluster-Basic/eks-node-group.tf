resource "aws_eks_node_group" "eksnodegroup" {
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = "terraform-node-group"
  node_role_arn = aws_iam_role.node_role.arn
  subnet_ids = module.vpc.public_subnets
  ami_type = "AL2_x86_64"
  instance_types = ["t2.micro"]
  capacity_type = "ON_DEMAND"
  disk_size = 20

  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 2
  }

  update_config {
    max_unavailable = 1
  }
}