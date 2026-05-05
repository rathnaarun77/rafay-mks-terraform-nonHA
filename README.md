# Rafay MKS Cluster using Environment Manager

This repository contains a Terraform project that integrates with Rafay Environment Manager to create and manage MKS clusters directly from the Rafay UI. Compute resources are provisioned on Oracle Cloud Infrastructure (OCI).

---

## Features

- Provision OCI compute instances (with or without block volumes)
- Create and manage MKS clusters from Rafay UI
- Start/Stop OCI instances from Rafay (no OCI console/CLI needed)
- Easy deployment and teardown

---

## Prerequisites

- Terraform installed locally
- Rafay CLI config file
- OCI API key configured
- Existing Rafay project
- A deployed GitOps agent in the same project

---

## Setup

### Step 1: Clone Only the Setup Folder

```bash
git clone --filter=blob:none --sparse -b main https://github.com/rathnaarun77/rafay-mks-terraform-nonHA.git tmp-repo && \
cd tmp-repo && \
git sparse-checkout set setup && \
mv setup ../ && \
cd .. && \
rm -rf tmp-repo
```
### Step 2: Configure Input Variables for Setup
Rename the example file:
```bash
mv terraform.tfvars.example terraform.tfvars
```
Update the values:

```hcl
project               = "<rafay-project>"
rafay_cli_config_file = "<path-to-rafay-cli-config>"
oci_api_key_path      = "<path-to-oci_api_key.pem>"
user_ocid             = "<oci-user-ocid>"
fingerprint           = "<oci-api-key-fingerprint>"
agent_name            = "<gitops-agent-name>"
```
### Step 3: Run Setup Terraform
```bash
terraform init
terraform plan
terraform apply
```

## Usage

1. Go to **Rafay Console** → **Environments**
2. Launch a new environment using the created template
3. Override inputs if needed
4. Click **Save & Deploy**

#### Once deployment is complete:
OCI resources will be provisioned and MKS cluster will be available under **Infrastructure → Clusters**

### Manage OCI Instances

From the **Rafay Environment** page, you can run predefined actions to control your OCI instances:

#### Available Actions

- **start-oci-instance**  
  Powers **ON** the OCI instance

- **stop-oci-instance**  
  Powers **OFF** the OCI instance