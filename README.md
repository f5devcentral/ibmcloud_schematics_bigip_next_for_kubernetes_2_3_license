# BIG-IP Next for Kubernetes 2.3 — Step 4: License

## About This Workspace

Deploys the F5 BNK License custom resource. This is the final step in the BIG-IP Next for Kubernetes deployment sequence.

The CNEInstance workspace **must be fully applied** before this workspace is planned or applied. The License CRD (`k8s.f5net.com/v1`) is registered by the `crd-installer` component that CNEInstance deploys.

## Deployment Sequence

```
Step 1 → cert-manager
Step 2 → flo
Step 3 → cneinstance
Step 4 → license        (this workspace)
```

## What This Workspace Deploys

- License custom resource (`k8s.f5net.com/v1`)
- JWT token and license operation mode configuration

## Prerequisites

- CNEInstance workspace applied (Step 3)
- JWT token from the FLO workspace:

```bash
cd ../ibmcloud_schematics_bigip_next_for_kubernetes_2_3_flo

terraform output -raw cos_jwt_token
```

Set this value as the `jwt_token` variable in `terraform.tfvars`.

## Variables

### IBM Cloud / Cluster

| Variable | Description | Required | Default |
| -------- | ----------- | -------- | ------- |
| `ibmcloud_api_key` | IBM Cloud API Key | REQUIRED | |
| `ibmcloud_cluster_region` | IBM Cloud region where the cluster resides | REQUIRED with default | `ca-tor` |
| `ibmcloud_resource_group` | IBM Cloud Resource Group name | Optional | `""` |
| `cluster_name_or_id` | Name or ID of the existing OpenShift ROKS cluster | REQUIRED | |

### License Configuration

| Variable | Description | Required | Default |
| -------- | ----------- | -------- | ------- |
| `utils_namespace` | Namespace where the License CR is deployed | Optional | `f5-utils` |
| `license_mode` | License operation mode (`connected` or `disconnected`) | Optional | `connected` |

### Value from FLO Workspace Output

| Variable | Description | Required | Source |
| -------- | ----------- | -------- | ------ |
| `jwt_token` | JWT token for F5 license authentication | REQUIRED | flo output: `cos_jwt_token` |

## Outputs

| Output | Description |
| ------ | ----------- |
| `license_id` | Name of the License custom resource |
| `license_namespace` | Namespace where the License CR is deployed |

## Deployment

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "no matches for kind License" during plan | CNEInstance workspace must be applied first — the License CRD is registered by `crd-installer`. |
| License CR stuck in "Registering" state | Verify the JWT token is valid and the cluster has internet access for `connected` mode. |

## Cleanup

```bash
terraform destroy -auto-approve
```

## Project Directory Structure

```
ibmcloud_schematics_bigip_next_for_kubernetes_2_3_license/
├── main.tf                   # Calls license module
├── variables.tf              # Input variables
├── outputs.tf                # Outputs
├── providers.tf              # IBM, kubernetes providers
├── terraform.tfvars.example  # Example variable values
└── modules/
    └── license/
        ├── main.tf           # License CR
        ├── variables.tf
        ├── outputs.tf
        └── terraform.tf
```
