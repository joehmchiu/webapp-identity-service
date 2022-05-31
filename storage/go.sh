
rg=${1:-new-transformer-dev2-identity-app-rg}
acc="newtransformerstorage"

# create a storage account
# az storage account create -n $acc -g $rg --sku Standard_LRS

export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string -n $acc -g $rg --query connectionString -o tsv)

az storage container create -n "public" --public-access blob
az storage container create -n "private" --public-access off
