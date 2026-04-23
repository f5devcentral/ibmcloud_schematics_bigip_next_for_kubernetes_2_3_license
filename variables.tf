variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
  sensitive   = true
}

variable "ibmcloud_cluster_region" {
  description = "IBM Cloud region where the cluster resides"
  type        = string
  default     = "ca-tor"
}

variable "ibmcloud_resource_group" {
  description = "IBM Cloud Resource Group name (leave empty to use account default)"
  type        = string
  default     = ""
}

variable "cluster_name_or_id" {
  description = "Name or ID of the existing OpenShift ROKS cluster"
  type        = string

  validation {
    condition     = length(var.cluster_name_or_id) > 0
    error_message = "cluster_name_or_id cannot be empty."
  }
}

variable "utils_namespace" {
  description = "Namespace where the License CR will be deployed"
  type        = string
  default     = "f5-utils"
}

variable "license_mode" {
  description = "License operation mode (connected or disconnected)"
  type        = string
  default     = "connected"

  validation {
    condition     = contains(["connected", "disconnected"], var.license_mode)
    error_message = "license_mode must be either 'connected' or 'disconnected'."
  }
}

# ============================================================
# Output from the flo project — set this from:
#   terraform -chdir=../ibmcloud_schematics_bigip_next_for_kubernetes_2_3_flo output cos_jwt_token
# ============================================================

variable "jwt_token" {
  description = "JWT token for F5 license authentication — from flo project output: cos_jwt_token"
  type        = string
  sensitive   = true
}
