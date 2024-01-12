import asyncio
import requests
import os
from dotenv import load_dotenv
load_dotenv()
import argparse
"""
This script is used to start or stop all virtual machines in a specified resource group.
Example of usage
    python vm_action.py start
"""

# Create the parser
parser = argparse.ArgumentParser(description="Perform an action")

# Add the arguments
parser.add_argument('Action', metavar='action', type=str, help='the action to perform (start/stop)')

# Parse the arguments
args = parser.parse_args()

AZURE_TENANT_ID = os.getenv("AZURE_TENANT_ID")
AZURE_SUBSCRIPTION_ID = os.getenv("AZURE_SUB_ID")
RESOURCE_GROUP_NAME = "kubernetes-rg"

def get_token(tenant_id: str):
    """
    Retrieves an access token for Azure API authentication.

    Args:
        tenant_id (str): The ID of the Azure tenant.

    Returns:
        str: The access token.

    Raises:
        None
    """
    login_url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
    payload = {
        'grant_type': 'client_credentials',
        'client_id': os.getenv("AZURE_CLIENT_ID"),
        'client_secret': os.getenv("AZURE_CLIENT_SECRET"),
        'scope': 'https://management.azure.com/.default'
    }
    response = requests.post(login_url, data=payload)
    return response.json()['access_token']

# # Get VM list
def get_vm_names_in_resource_group(token: str, subscription_id: str, resource_group: str):
    """
    Retrieves the names of virtual machines in a specified resource group.

    Args:
        token (str): The access token for authentication.
        subscription_id (str): The ID of the Azure subscription.
        resource_group (str): The name of the resource group.

    Returns:
        list: A list of virtual machine names in the specified resource group.
    """
    url = f"https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.Compute/virtualMachines?api-version=2020-12-01"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    response = requests.get(url, headers=headers)
    val = response.json()['value']
    return [vm['name'] for vm in val if vm['name'] != None]

def stop_vm(token: str, subscription_id: str, resource_group: str, vm_name: str):
    """
    Stops a virtual machine in Azure.

    Args:
        token (str): The authentication token.
        subscription_id (str): The ID of the Azure subscription.
        resource_group (str): The name of the resource group containing the virtual machine.
        vm_name (str): The name of the virtual machine.

    Returns:
        None
    """
    url = f"https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.Compute/virtualMachines/{vm_name}/powerOff?api-version=2023-09-01"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    requests.post(url, headers=headers)

def start_vm(token: str, subscription_id: str, resource_group: str, vm_name: str):
    """
    Starts a virtual machine in Azure.

    Args:
        token (str): The access token for authentication.
        subscription_id (str): The ID of the Azure subscription.
        resource_group (str): The name of the resource group containing the virtual machine.
        vm_name (str): The name of the virtual machine to start.
    """
    url = f"https://management.azure.com/subscriptions/{subscription_id}/resourceGroups/{resource_group}/providers/Microsoft.Compute/virtualMachines/{vm_name}/start?api-version=2023-09-01"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    requests.post(url, headers=headers)

access_token = get_token(AZURE_TENANT_ID)
vm_names = get_vm_names_in_resource_group(access_token, AZURE_SUBSCRIPTION_ID, RESOURCE_GROUP_NAME)

for vm_name in vm_names:
    if args.Action == "start":
        print(f"Starting {vm_name}...")
        start_vm(access_token, AZURE_SUBSCRIPTION_ID, RESOURCE_GROUP_NAME, vm_name)
    elif args.Action == "stop":
        print(f"Stopping {vm_name}...")
        stop_vm(access_token, AZURE_SUBSCRIPTION_ID, RESOURCE_GROUP_NAME, vm_name)
    else:
        print("Invalid action. Please specify start or stop.")
        break