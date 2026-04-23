terraform {
  required_version = ">= 1.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.60.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
  }
}

module "license" {
  source = "./modules/license"

  depends_on = [data.ibm_container_cluster_config.cluster_config]

  providers = {
    kubernetes = kubernetes
  }

  enabled         = true
  utils_namespace = var.utils_namespace
  jwt_token       = var.jwt_token
  license_mode    = var.license_mode
}
