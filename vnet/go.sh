
rg=${1:-new-transformer-dev2-identity-app-rg}
location=westus

az group create -n $rg -l $location 

vnet=${2:-vnet-new-transformer-dev2-001}
cidr=10.1.0.0/16
az network vnet create -n $vnet -g $rg --address-prefixes $cidr

snet=subnet-app-001
cidr=10.1.30.0/24
az network vnet subnet create -n $snet -g $rg --vnet-name $vnet --address-prefixes $cidr

snet=subnet-db-001
cidr=10.1.50.0/24
az network vnet subnet create -n $snet -g $rg --vnet-name $vnet --address-prefixes $cidr

snet=subnet-tester-001
cidr=10.1.70.0/24
az network vnet subnet create -n $snet -g $rg --vnet-name $vnet --address-prefixes $cidr

