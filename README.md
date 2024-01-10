# Azure Utilities Repository

This repository contains scripts and utilities for working with Azure services including Azure API, Azure CLI, and Azure DevOps API.

## Structure

- `azure-api`: Contains PowerShell scripts for making API calls to various Azure services.
- `azure-cli`: Scripts for Azure Command Line Interface (CLI) usage examples.
- `azure-devops-api`: PowerShell scripts for interacting with Azure DevOps APIs.
- `load-environment-variables.ps1` : Powershell script to load environment variables from .env file.

## Required variables in .env file
To use all of scripts in this repo you .env file should contains variables, like on below example (customized for your azure environment):
  ```.env
  AZURE_CLIENT_ID=0fbde213-8cf9-4525-8f11-ca4e411173bb
  AZURE_CLIENT_SECRET=aisnjdosakdnmaojs93u43rjaoi*HYFHS!!
  AZURE_TENANT_ID=12ab52e2-7f12-4bef-awe4-3111962fc321
  ADO_PAT=aisn*NWSB7da9n980um*93u43rjaoi*HYFHS!!
  ```

## Azure API Usage

### Scripts

- `az-keyvault-api-simplified.ps1`: Simplified examples of Key Vault API calls.
- `az-keyvault-api-utils.ps1`: Utility functions for Key Vault API.
- `az-keyvault-api.ps1`: Comprehensive Key Vault API call examples.

## Azure CLI Usage

### Scripts

- `az-commands.ps1`: Common Azure CLI commands.
- `az-keyvault-cli.ps1`: Specific CLI commands for interacting with Azure Key Vault.

## Azure DevOps API Usage

### Scripts

- `az-devops-api.ps1`: Examples of API calls to Azure DevOps services.
- `az-devops-utils.ps1`: Utility functions for Azure DevOps API.

## Getting Started

To use these scripts, you will need to have PowerShell installed and configured on your system. Additionally, you'll need to have the necessary permissions and Azure CLI installed for the Azure-related scripts.

## Examples

Here are some quick examples of what you can find in this repository:

### Azure API

- **Key Vault - List Secrets**:
  ```powershell
  # Using az-keyvault-api.ps1
  ./az-keyvault-api.ps1
