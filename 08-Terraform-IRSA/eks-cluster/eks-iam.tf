data "tls_certificate" "ocid" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "ocid" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [ data.tls_certificate.ocid.certificates[0].sha1_fingerprint ]
}

# resource "aws_iam_role" "eksaccessrole" {
#   name = "eksroletest"
#   assume_role_policy = jsonencode({
# 	"Version": "2012-10-17",
# 	"Statement": [
# 		{
# 			"Effect": "Allow",
# 			"Principal": {
# 				"Federated": "${aws_iam_openid_connect_provider.ocid.arn}"
# 			},
# 			"Action": "sts:AssumeRoleWithWebIdentity",
# 			"Condition": {
# 				"StringEquals": {
# 					"${aws_iam_openid_connect_provider.ocid.arn}:aud": "sts.amazonaws.com",
# 					"${aws_iam_openid_connect_provider.ocid.arn}:sub": "system:serviceaccount:default:s3access"
# 				}
# 			}
# 		}
# 	]
# })
# }