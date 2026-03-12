#!/bin/bash

# ===== CONFIGURATION =====
RESOURCE_GROUP="myResourceGroup"
STORAGE_ACCOUNT="$1"      # Pass storage account name as first argument
CONTAINER_NAME="files"    # Fixed container name
LOG_FILE="storage.log"

# ===== LOGIN CHECK =====
echo "Checking Azure login..."
az account show > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Not logged in5. Please run 'az login' first."
    exit 1
fi

# ===== ENSURE CONTAINER EXISTS =====
echo "Ensuring container exists..."
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT \
    --auth-mode login \
    --public-access blob > /dev/null

# ===== FILE MANAGEMENT MENU =====
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
                --container-name $CONTAINER_NAME \
                --name $(basename $FILE) \
                --file "$FILE" \
                --auth-mode login
            echo "$(date) - UPLOAD - $FILE" >> $LOG_FILE
            ;;
        2)
            read -p "Enter file name to download: " FILE
            az storage blob download \
                --account-name $STORAGE_ACCOUNT \
                --container-name $CONTAINER_NAME \
                --name "$FILE" \
                --file "$FILE" \
                --auth-mode login
            echo "$(date) - DOWNLOAD - $FILE" >> $LOG_FILE
            ;;
        3)
            az storage blob list \
                --account-name $STORAGE_ACCOUNT \
                --container-name $CONTAINER_NAME \
                --auth-mode login \
                --output table
            echo "$(date) - LIST FILES" >> $LOG_FILE
            ;;
        4)
            read -p "Enter file name to delete: " FILE
            az storage blob delete \
                --account-name $STORAGE_ACCOUNT \
                --container-name $CONTAINER_NAME \
                --name "$FILE" \
                --auth-mode login
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