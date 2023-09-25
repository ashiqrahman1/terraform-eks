resource "aws_iam_role" "cluster_role" {
  #Terraform EKS cluster Policy
  name = "eksnoderoleterraform"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Add ClusterPolicy to Cluster Role

resource "aws_iam_role_policy_attachment" "ClusterPolicy" {
#   name       = "ClusterPolicy"
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

