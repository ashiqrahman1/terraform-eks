resource "aws_iam_role" "eksaccessrole" {
  name = "eksroletest"
  assume_role_policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Federated": "${data.terraform_remote_state.eks.outputs.eks_ocid}"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringEquals": {
					"${local.ocid_extract}:aud": "sts.amazonaws.com",
					"${local.ocid_extract}:sub": "system:serviceaccount:${var.namespace}:${var.serviceaccount}"
				}
			}
		}
	]
})
}

resource "aws_iam_role_policy_attachment" "s3read" {
  role = aws_iam_role.eksaccessrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}