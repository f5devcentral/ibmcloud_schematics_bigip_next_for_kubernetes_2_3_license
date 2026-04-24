# ============================================================
# Root Terraform Configuration
# F5 BNK Orchestrator — deploys to an existing ROKS cluster
# Modules: cert-manager → flo → cneinstance → license
# ============================================================

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
    http = {
      source  = "hashicorp/http"
      version = ">= 3.0.0"
    }
  }
}

# ============================================================
# Module: license
# ============================================================

module "license" {
  source = "./modules/license"

  providers = {
    ibm        = ibm
    kubernetes = kubernetes
    http       = http
  }

  enabled = true

  use_cos_bucket = true
  jwt_token = ""

  ibmcloud_api_key              = var.ibmcloud_api_key
  ibmcloud_cos_bucket_region    = var.ibmcloud_cos_bucket_region
  ibmcloud_resource_group       = var.ibmcloud_resource_group
  ibmcloud_cos_instance_name    = var.ibmcloud_cos_instance_name
  ibmcloud_resources_cos_bucket = var.ibmcloud_resources_cos_bucket

  utils_namespace = var.flo_utils_namespace
  f5_cne_subscription_jwt_file  = var.license_f5_cne_subscription_jwt_file
  license_mode    = var.license_mode

}
