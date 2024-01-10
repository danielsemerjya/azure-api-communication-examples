
function Get-AzKeyVaultAccessToken {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ClientId,
        [Parameter(Mandatory = $true)]
        [string] $ClientSecret,
        [Parameter(Mandatory = $true)]
        [string] $TenantId,
        [Parameter(Mandatory = $false)]
        [string] $Scope = "https://vault.azure.net/.default"
    )
    $loginUrl = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"

    $Body = @{
        'scope'         = $Scope
        'client_id'     = $ClientId
        'grant_type'    = 'client_credentials'
        'client_secret' = $ClientSecret
    }

    $params = @{
        ContentType = 'application/x-www-form-urlencoded'
        Headers     = @{'accept' = 'application/json' }
        Body        = $Body
        Method      = 'Post'
        URI         = $loginUrl
    }

    $token = Invoke-RestMethod @params

    return $token.access_token
}

function Get-KeyVaultSecretsList {
    param (
        [Parameter(Mandatory = $true)]
        [string] $accessToken,
        [Parameter(Mandatory = $true)]
        [string] $KeyVaultName
    )

    $uri = "https://$KeyVaultName.vault.azure.net/secrets?api-version=7.0"

    $params = @{
        ContentType = 'application/json'
        Headers     = @{'Authorization' = "Bearer $accessToken" }
        Method      = 'Get'
        URI         = $uri
    }

    $secrets = Invoke-RestMethod @params
    return $secrets
}

function New-KeyVaultSecret {
    param (
        [Parameter(Mandatory = $true)]
        [string] $accessToken,
        [Parameter(Mandatory = $true)]
        [string] $KeyVaultName,
        [Parameter(Mandatory = $true)]
        [string] $SecretName,
        [Parameter(Mandatory = $true)]
        [string] $SecretValue
    )

    $uri = "https://" + $KeyVaultName + ".vault.azure.net/secrets/" + $SecretName + "?api-version=7.0"

    $params = @{
        ContentType = 'application/json'
        Headers     = @{'Authorization' = "Bearer $accessToken" }
        Method      = 'PUT'
        URI         = $uri
        Body        = '{"value":"' + $secretValue + '"}'
    }

    $secret = Invoke-RestMethod @params

    return $secret
}

function Get-KeyVaultSecret {
    param (
        [Parameter(Mandatory = $true)]
        [string] $accessToken,
        [Parameter(Mandatory = $true)]
        [string] $KeyVaultName,
        [Parameter(Mandatory = $true)]
        [string] $SecretName
    )

    $uri = "https://" + $KeyVaultName + ".vault.azure.net/secrets/" + $SecretName + "?api-version=7.0"

    $params = @{
        ContentType = 'application/json'
        Headers     = @{'Authorization' = "Bearer $accessToken" }
        Method      = 'Get'
        URI         = $uri
    }

    $secret = Invoke-RestMethod @params

    return $secret
}

function Remove-KeyVaultSecret {
    param (
        [Parameter(Mandatory = $true)]
        [string] $accessToken,
        [Parameter(Mandatory = $true)]
        [string] $KeyVaultName,
        [Parameter(Mandatory = $true)]
        [string] $SecretName
    )

    $uri = "https://" + $KeyVaultName + ".vault.azure.net/secrets/" + $SecretName + "?api-version=7.0"

    $params = @{
        ContentType = 'application/json'
        Headers     = @{'Authorization' = "Bearer $accessToken" }
        Method      = 'Delete'
        URI         = $uri
    }

    $secret = Invoke-RestMethod @params

    return $secret
}