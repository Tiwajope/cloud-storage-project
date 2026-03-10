#!/bin/bash

RESOURCE_GROUP="myResourceGroup"
LOCATION="eastus"
STORAGE_ACCOUNT="tiwastorage$RANDOM"
CONTAINER_NAME="files"
LOG_FILE="storage.log"

# Create Storage Account & Container 

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

#Get Storage Key 

STORAGE_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query '[0].value' -o tsv)

# File Management Menu

while true; do
  echo ""
  echo "Choose an action:"
  echo "1) Upload file"
  echo "2) Download file"
  echo "3) List files"
  echo "4) Delete file"
  echo "5) Exit"
  read -p "Enter option number: " option

  case $option in
    1)
      read -p "Enter local file path to upload: " FILE
      az storage blob upload \
        --account-name $STORAGE_ACCOUNT \
        --account-key $STORAGE_KEY \
        --container-name $CONTAINER_NAME \
        --name $(basename $FILE) \
        --file $FILE
      echo "$(date) - UPLOAD - $FILE" >> $LOG_FILE
      ;;
    2)
      read -p "Enter file name to download: " FILE
      az storage blob download \
        --account-name $STORAGE_ACCOUNT \
        --account-key $STORAGE_KEY \
        --container-name $CONTAINER_NAME \
        --name $FILE \
        --file $FILE
      echo "$(date) - DOWNLOAD - $FILE" >> $LOG_FILE
      ;;
    3)
      az storage blob list \
        --account-name $STORAGE_ACCOUNT \
        --account-key $STORAGE_KEY \
        --container-name $CONTAINER_NAME \
        --output table
      echo "$(date) - LIST FILES" >> $LOG_FILE
      ;;
    4)
      read -p "Enter file name to delete: " FILE
      az storage blob delete \
        --account-name $STORAGE_ACCOUNT \
        --account-key $STORAGE_KEY \
        --container-name $CONTAINER_NAME \
        --name $FILE
      echo "$(date) - DELETE - $FILE" >> $LOG_FILE
      ;;
    5)
      echo "Exiting. Bye!"
      break
      ;;
    *)
      echo "Invalid option. Try again."
      ;;
  esac
done