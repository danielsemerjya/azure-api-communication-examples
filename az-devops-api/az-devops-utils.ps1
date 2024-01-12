function EncodePAT {
    param(
        [Parameter(Mandatory=$true)]
        [string]$PAT
    )

    $patToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))
    return $patToken
}

function GetProjectByName {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$header,
        
        [Parameter(Mandatory=$true)]
        [string]$orgName,
        
        [Parameter(Mandatory=$true)]
        [string]$projName
    )

    $URL = "https://dev.azure.com/$orgName/_apis/projects?api-version=6.0"
    $projects = Invoke-RestMethod -Uri $URL -Method Get -ContentType "application/json; charset=utf-8; api-version=6.0" -Headers $header -MaximumRedirection 10
    
    if ($null -eq $projects.value) {
        Write-Error "No projects found in organization $orgName"
    }

    foreach ($project in $projects.value) {
        if ($project.name -eq $projName) {
            return $project
        }
    }
}