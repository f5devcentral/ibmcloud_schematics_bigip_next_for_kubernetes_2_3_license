output "license_id" {
  description = "Name of the License custom resource"
  value       = module.license.license_id
}

output "license_namespace" {
  description = "Namespace where the License CR is deployed"
  value       = module.license.license_namespace
}
