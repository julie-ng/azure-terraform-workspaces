# azure-terraform-workspaces

Instead of giving Terraform access to my entire Azure subscription, I want to use resource groups as an isolation and security boundary.

I got tired of doing this by hand and decided to (semi-)automate it.

### Use Case

Each "environment" here is an independent workload.

- multiple terraform environments
- each environment has own resource group
- each environment has own service principal
- service principal has `Contributor` rights on its own resource group

### Creates Following Azure Resources

- resource group
- service principal for that resource group
- storage account in that resource group which you can use for Terraform state.

## How to Use

### Pre-requsites

⚠️ Run this *only locally* on your machine. It outputs service principal secrets, which you will need for CI/CD workflows

- Logged in via `az login`
- `Owner` rights on your subscription


### Configure Azure Backend for Terraform

#### 1. Create Storage Account

We will save our Terraform state in Azure Blob Storage

1. Create a storage account to hold Terraform state for this project. Be sure to [disable public read access](https://docs.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure?tabs=portal). 
1. Generate [SAS token](https://docs.microsoft.com/en-us/rest/api/storageservices/delegate-access-with-shared-access-signature) for this storage account
1. Create [Blob Storage container](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction#containers), e.g. `workspaces`, `projects`

#### 2. Configure Terraform

Create an `azure.conf` file, using `azure.conf.sample` as a template, filling in the placeholders iwth your values.

```
storage_account_name="azurestorageaccountname"
container_name="storagecontainername"
key="project.tfstate"
sas_token="?sv=2019-12-12…"
```

#### 3. Terraform Init with Config

Run `init` with our config. 

```
terraform init -backend-config=./azure.conf
```

#### 4. Happy Terraforming


```
terraform plan
terraform apply
```

## Todo

- [ ] Create custom "Terraform Contributor" role for service principal so that it can also assign RBAC. Example use case is AAD Pod Identity
- [ ] Save service principal secrets to Key Vault instead of outputting them
