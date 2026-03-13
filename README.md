# Cloud Storage CLI with Azure Blob Storage
## Project Overview 

This project implements a **Cloud Storage Command Line Interface (CLI)** that interacts with **Azure Blob Storage**. The CLI allows users to manage files stored in an Azure Storage container directly from the terminal.

The script provides a simple menu that allows users to:

Upload files

Download files

List files in the container

Delete files

This project demonstrates the use of **Azure Storage Accounts, Blob Containers, and Azure CLI commands** for managing cloud storage resources.

## Technologies Used

Bash scripting

Azure CLI

Azure Blob Storage

GitHub for version control

## Storage Account Details

Storage Account Name: tiwastoragecapstone

Resource Group: myResourceGroup

Region: East US

Container Name: files

## Features

The CLI script provides the following options:

**1. Upload File**

Uploads a file from the local system to the Azure Blob container.

**2. Download File**

Downloads a file from the Azure Blob container to the local system.

**3. List Files**

Displays all files stored in the Azure Blob container.

**4. Delete File**

Deletes a specified file from the Azure Blob container.

**5. Exit**

Closes the program.


## How to Run the Project

**Step 1: Login to Azure**

az login

**Step 2: Create Storage Account**

az storage account create \
--name tiwastoragecapstone \
--resource-group myResourceGroup \
--location eastus \
--sku Standard_LRS

**Step 3: Create Container**

az storage container create \
--name files \
--account-name tiwastoragecapstone \
--account-key <STORAGE_KEY>

**Step 4: Run the CLI Script**

./cloud_storage_cli.sh tiwastoragecapstone <STORAGE_KEY>

**Example CLI Menu**

Choose an action:
1) Upload file
2) Download file
3) List files
4) Delete file
5) Exit

## Screenshots

Azure Storage Account

Container Created

File Uploaded

File Listed in CLI

File Deleted

File Downloaded


## Challenges Encountered and Solutions
### 1. Azure Subscription Not Found

**Challenge**:
When attempting to run Azure CLI commands, an error occurred indicating that no active subscription was found. This prevented the creation of the storage account and other resources.

**Solution**:
The issue was resolved by logging into Azure and confirming the active subscription using the following commands:
az login
az account show

This ensured the correct Azure account and subscription were being used.

### 2. Microsoft.Storage Provider Not Registered

**Challenge**:
While attempting to create the storage account, an error appeared stating that the Microsoft.Storage resource provider was not registered for the subscription.

**Solution**:
The storage provider was registered using the following command:
az provider register --namespace Microsoft.Storage

After registering the provider, the storage account creation command executed successfully.

### 3. Incorrect Storage Key

**Challenge**:
When running the CLI script, authentication failed due to an incorrect storage account key being used. This caused commands like uploading or listing files to fail.

**Solution**:
The correct storage key was retrieved from the Azure portal by navigating to:

Storage Account → Access Keys

The correct key was then used when executing the script:
./cloud_storage_cli.sh tiwastoragecapstone <STORAGE_KEY>

### 4. Container Not Appearing in Azure Portal

**Challenge**:
After running the script, the container did not appear in the Azure portal, making it difficult to verify if the container was created successfully.

**Solution**:
The container was manually verified and created using Azure CLI:
az storage container create \
--name files \
--account-name tiwastoragecapstone \
--account-key <STORAGE_KEY>

Refreshing the Azure portal then showed the container successfully.

### 5. Container Appearing Empty

**Challenge:**
When viewing the container in the Azure portal, no files were visible even though the container had been created.

**Solution**:
This occurred because no files had yet been uploaded. A file was uploaded using the CLI script, after which the file appeared in the container.

### 6. File Path Errors During Upload

**Challenge**:
While attempting to upload a file, the script returned an error indicating that the file path could not be found.

**Solution**:
The issue was resolved by providing the correct absolute file path when uploading files. For example:
C:\Users\Username\Documents\example.txt

Ensuring the file existed at the specified location allowed the upload process to complete successfully.

### 7. Connecting the CLI Script with Azure Storage

**Challenge**:
Initially it was confusing how the Bash script interacts with Azure Blob Storage through the Azure CLI commands.

**Solution**:
This was resolved by reviewing Azure CLI documentation and understanding how commands such as:

az storage blob upload

az storage blob list

az storage blob download

az storage blob delete

allow the script to communicate directly with the Azure Storage container.

## Repository Structure
```
CLOUD-STORAGE-PROJECT

│

├── cloud_storage_cli.sh

├── cloud_storage_auto.sh

├── .github

|        ├──workflows
        
|        ├──deploy_storage.yml

|        ├──.gitkeep

├── storage.log

├── README.md                  

│

├── screenshots      

|    ├── azure_storage_account.png   

│    ├── container_created.png

│    ├── delete_file.png

│    ├── download_file.png

│    ├── github_actions.png

│    ├── list_files.png

│    └── upload_file.png    

│

└── report

    └── cloud_storage_report.pdf  
```

## Project Report

The detailed project report can be found here:

[Cloud Storage Project Report](report/cloud_storage_report.pdf)

## Conclusion

This project demonstrates how cloud storage operations can be automated using **Bash scripting and Azure Blob Storage**. The CLI simplifies file management in cloud storage by allowing users to perform operations directly from the terminal.