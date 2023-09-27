locals {
  ocid_extract = element(split("oidc-provider/",data.terraform_remote_state.eks.outputs.eks_ocid), 1)
}