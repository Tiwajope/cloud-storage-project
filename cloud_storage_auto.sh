#!/bin/bash

RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"
STORAGE_ACCOUNT="tiwastoragecapstone"
CONTAINER_NAME="files"
LOG_FILE="storage.log"

echo "Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --allow-blob-public-access true

echo "Creating container..."
az storage container create \
  --account-name $STORAGE_ACCOUNT \
  --name $CONTAINER_NAME \
  --public-access blob

echo "Storage setup complete!"
echo "Storage account: $STORAGE_ACCOUNT"
echo "Container: $CONTAINER_NAME"

# Get storage key
STORAGE_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query '[0].value' -o tsv)

echo "STORAGE_KEY=$STORAGE_KEY"