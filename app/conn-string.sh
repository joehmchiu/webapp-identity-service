
app=${1:-new-transformer-dev2-identity-app-server}
rg=${2:-new-transformer-dev2-identity-app-rg}
vnet=${3:-vnet-new-transformer-dev2-001}
subnet=${4:-subnet-app-001}
zone=${5:-privatelink.database.windows.net}

echo "3.1. webapp vnet integration"
vnetid=$(az network vnet list -g $rg | jq '.[].id' | sed 's/"//g')
subnetid=$(az network vnet subnet list -g $rg --vnet-name $vnet | jq '.[] | select (.name=="'$subnet'") | .id' | sed 's/"//g')
echo "az webapp vnet-integration add -g $rg -n $app --vnet $vnetid --subnet $subnetid"
az webapp vnet-integration add -g $rg -n $app --vnet $vnetid --subnet $subnetid

echo "3.2. configure connection string"
string="'Data Source=tcp:new-transformer-dev2-db-server.database.windows.net,1433;Initial Catalog=Identity;User Id=new-transformer-sql-admin;Password=Passw0rd'"
az webapp config connection-string set -g $rg -n $app -t SQLAzure --settings IdentityConnectionString="$string"

echo "3.3. restart to adopt the changes"
# az webapp restart -n $app -g $rg

echo "3.4. add webapp a record"
az network private-dns record-set a add-record -g $rg -z $zone -n app -a 10.1.30.4

