
rg=${1:-new-transformer-dev2-identity-app-rg}
app=${2:-new-transformer-dev2-identity-app-server}
vnet=${3:-vnet-new-transformer-dev2-001}

echo "1. create resource group and vnet"
cd vnet
sh go.sh $rg $vnet

cd ..
echo "2. create identity db server"
cd db
sh go.sh
# sh add-dns-zone.sh

cd ..
echo "3. create identity app server"
cd app
sh go.sh
app_subnet=subnet-app-001
sh conn-string.sh $app $rg $vnet $app_subnet

echo "DONE!"
exit
echo "4. deploy application to app server"
cd ..
cd release
sh az-deploy.sh

cd ..
echo "5. create ubuntu tester server for testing"
cd tester
sh go.sh

