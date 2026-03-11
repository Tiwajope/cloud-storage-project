#!/bin/bash

RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"
STORAGE_ACCOUNT="tiwastorage$RANDOM"
CONTAINER_NAME="files" 

echo "Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

echo "Enabling public blob access..."
az storage account update \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --allow-blob-public-access true

echo "Creating container..."
az storage container create \
  --account-name $STORAGE_ACCOUNT \
  --name $CONTAINER_NAME \
  --public-access blob

echo "Storage setup complete!"
echo "Storage account: $STORAGE_ACCOUNT"  
 echo "Container: $CONTAINER_NAME"