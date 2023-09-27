output "eks_cluster_name" {
  value = aws_eks_cluster.eks.id
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}


output "eks_ocid" {
  value = aws_iam_openid_connect_provider.ocid.arn
}

output "node_group_name" {
  value = aws_eks_node_group.eksnodegroup.node_group_name
}