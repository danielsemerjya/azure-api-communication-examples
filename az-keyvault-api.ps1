# Example of usage Azure Key Vault API with PowerShell, without CLI

# -- We could logout from Azure CLI, becouse we are not going to use it
# az logout

# -- We need to have Azure service principal with access to Key Vault
# - So we create it first - manualy

# -- Now we need to get the credentials for service principal and aquire access token
$clientId = ""
$clientSecret = ""
$tenantId = ""

$loginUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$scope = "https://vault.azure.net/.default";

$Body = @{
    'scope'         = $scope
    'client_id'     = $clientId
    'grant_type'    = 'client_credentials'
    'client_secret' = $clientSecret
}

$params = @{
    ContentType = 'application/x-www-form-urlencoded'
    Headers     = @{'accept' = 'application/json' }
    Body        = $Body
    Method      = 'Post'
    URI         = $loginUrl
}

$token = Invoke-RestMethod @params

# Write-Output $token.access_token

# -- Now we can query for list of secrets in kv
$kvName = "stechkeyvault2023"

# $uri = "https://$kvName.vault.azure.net/secrets?api-version=7.0"

# $params = @{
#     ContentType = 'application/json'
#     Headers     = @{'Authorization' = "Bearer $($token.access_token)" }
#     Method      = 'Get'
#     URI         = $uri
# }

# $secrets = Invoke-RestMethod @params

# Write-Output $secrets

# # -- Now we can add new secret to key vault
# $uri = "https://$kvName.vault.azure.net/secrets/mySecret2?api-version=7.0"
# $params = @{
#     ContentType = 'application/json'
#     Headers     = @{'Authorization' = "Bearer $($token.access_token)" }
#     Method      = 'PUT'
#     URI         = $uri
#     Body        = '{"value":"mySecretValue"}'
# }

# $secret = Invoke-RestMethod @params

# Write-Output $secret

# # -- And again query for list of secrets in kv
# $uri = "https://$kvName.vault.azure.net/secrets?api-version=7.0"
# $params = @{
#     ContentType = 'application/json'
#     Headers     = @{'Authorization' = "Bearer $($token.access_token)" }
#     Method      = 'Get'
#     URI         = $uri
# }

# $secrets = Invoke-RestMethod @params

# Write-Output $secrets.value

# # -- As we are able to see list, we cant get the value of the secret
# # - lets get it
# $uri = "https://$kvName.vault.azure.net/secrets/mySecret2?api-version=7.0"
# $params = @{
#     ContentType = 'application/json'
#     Headers     = @{'Authorization' = "Bearer $($token.access_token)" }
#     Method      = 'Get'
#     URI         = $uri
# }

# $secret = Invoke-RestMethod @params

# Write-Output $secret

# # -- Now we can delete the secret
# $uri = "https://$kvName.vault.azure.net/secrets/mySecret2?api-version=7.0"
# $params = @{
#     ContentType = 'application/json'
#     Headers     = @{'Authorization' = "Bearer $($token.access_token)" }
#     Method      = 'Delete'
#     URI         = $uri
# }

# $secret = Invoke-RestMethod @params

# Write-Output $secret