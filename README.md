# terraform-aks
Sets up an AKS cluster using terraform.

Specifically sets up:
1. AKS
2. Azure KeyVault (and puts kube-config into it)
3. ACR

For notes see: https://gist.github.com/rakelkar/33a7f011a8dd04bbd878492e8731156b

## Setup
1. Install terraform: https://www.terraform.io/downloads.html
2. Install az cli
3. Create an az service principle: https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal
4. Set env vars so that terraform can use your subscription see below. Also see: # see https://github.com/terraform-providers/terraform-provider-azurerm/issues/1569


## Run
```
export TF_VAR_tenant_id=$TENANT_ID
export TF_VAR_client_id=$CLIENT_ID
export TF_VAR_client_secret=$CLIENT_SECRET
export TF_VAR_sp_object_id=$SP_OBJECT_ID
export TF_VAR_subscription_id=$SUBSCRIPTION_ID

az login -u $CLIENT_ID -p $CLIENT_SECRET --subscription $SUBSCRIPTION_ID -t $TENANT_ID --service-principal

terraform init
terraform apply
```
