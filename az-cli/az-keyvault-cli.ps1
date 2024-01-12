# Example of usage Azure Key Vault API with PowerShell and CLI
# This script requires Azure CLI to be installed and logged in
# And also modules Az.Accounts and Az.KeyVault to be installed

# az login

$kvName = "stechkeyvault2023"

# -- First manual assign a role to user 

# -- Than we could query the secrets from key vault
az keyvault secret list --vault-name $kvName | ConvertFrom-Json

# -- Now we can add new secret to key vault
az keyvault secret set --vault-name $kvName --name "mySecret" --value "mySecretValue"

# -- And again query for list of secrets in kv
az keyvault secret list --vault-name $kvName | ConvertFrom-Json

# -- As we are able to see list, we cant get the value of the secret
# - lets get it
az keyvault secret show --vault-name $kvName --name "mySecret3" | ConvertFrom-Json

# -- Now we can delete the secret
az keyvault secret delete --vault-name $kvName --name "mySecret"

# -- And again query for list of secrets in kv
az keyvault secret list --vault-name $kvName | ConvertFrom-Json

# -- Optional logout
az logout



