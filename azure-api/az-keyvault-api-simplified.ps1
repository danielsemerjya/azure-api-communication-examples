# Example of usage Azure Key Vault API with PowerShell, without CLI - simpl

# - Load environment variables
$clientId = $env:AZURE_CLIENT_ID
$clientSecret = $env:AZURE_CLIENT_SECRET
$tenantId = $env:AZURE_TENANT_ID

$kvName = "stechkeyvault2023"

# - load az-keyvault-api-utils.ps1 file with functions
. "$PSScriptRoot/az-keyvault-api-utils.ps1"

$accessToken = Get-AzKeyVaultAccessToken -clientId $clientId -clientSecret $clientSecret -tenantId $tenantId

$secrets = Get-KeyVaultSecretsList -accessToken $accessToken -KeyVaultName $kvName

$secrets

# New-KeyVaultSecret -accessToken $accessToken -KeyVaultName $kvName -SecretName "mySecret4" -SecretValue "mySecretValue"

# Get-KeyVaultSecret -accessToken $accessToken -KeyVaultName $kvName -SecretName "mySecret4"

# Remove-KeyVaultSecret -accessToken $accessToken -KeyVaultName $kvName -SecretName "mySecret4"