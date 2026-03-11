#!/bin/bash

# CLI script for local file management
STORAGE_ACCOUNT="$1"
STORAGE_KEY="$2"
CONTAINER_NAME="files"
LOG_FILE="storage.log"

if [[ -z "$STORAGE_ACCOUNT" || -z "$STORAGE_KEY" ]]; then
  echo "Usage: ./cloud_storage_cli.sh <STORAGE_ACCOUNT> <STORAGE_KEY>"
  exit 1
fi

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