# this provider is to workaround a bug for kubectl provider - https://github.com/gavinbunney/terraform-provider-kubectl/issues/226
terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }
  }
}

