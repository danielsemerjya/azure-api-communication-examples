# This scripts takes two arguments "action" (start/stop) and "resource-group-name"

# First argument is an action start/stop
$action = $args[0]
# Second argument is a resource group name
$rgName = $args[1]

# List all vms in specific rg
$vmList = az vm list -g $rgName --query "[].name" -o tsv

# Example how to stop vm
foreach ($vm in $vmList) {
    az vm $action -g $rgName -n $vm
}