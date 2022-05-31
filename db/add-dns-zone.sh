
ep=${1:-new-transformer-dev2-db-server}
rg=${2:-new-transformer-dev2-identity-app-rg}
name=${3:-default}
zone="db-$ep"
pdz=${4:-privatelink.database.windows.net}

echo "2.1. create DNS Zone Group for the End Point"
az network private-endpoint dns-zone-group create --endpoint-name $ep -g $rg -n $name --zone-name $zone --private-dns-zone $pdz
# az network private-endpoint dns-zone-group add --endpoint-name $ep -g $rg -n $name --zone-name $zone --private-dns-zone $pdz

# echo "clean out"
# az network private-endpoint dns-zone-group delete --endpoint-name $ep -n $name -g $rg
