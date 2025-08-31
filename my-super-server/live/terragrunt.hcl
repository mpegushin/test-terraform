locals {
  state_root = "${get_terragrunt_dir()}/../.terraform-state"
}

remote_state {
  backend = "local"
  config  = { path = "${local.state_root}/${path_relative_to_include()}/terraform.tfstate" }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    terraform {
      backend "local" {}
    }
  EOF
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    terraform {
      required_version = ">= 1.3"
      required_providers {
        twc = { source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud" }
        aws = { source = "hashicorp/aws", version = ">= 5.0" }
      }
    }

    provider "twc" {
      token = "${get_env("TWC_TOKEN", "")}"
    }

    provider "aws" {
      region = "${get_env("AWS_REGION", "eu-central-1")}"
    }
  EOF
}
