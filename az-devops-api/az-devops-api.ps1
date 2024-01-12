$pat = $env:ADO_PAT
$orgName = ""
$projName = ""

. "$PSScriptRoot/az-devops-utils.ps1"

# Encode the PAT and create the header
$patToken = EncodePAT -PAT "$($pat)"
$header = @{'Authorization' = "Basic $patToken" }

# Get the project by name
$projectId = GetProjectByName -header $header -orgName $orgName -projName $projName

$projectId