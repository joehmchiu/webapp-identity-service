
rg=new-transformer-dev2-identity-app-rg
app=new-transformer-dev2-identity-app-server
az webapp deployment source config-zip -g $rg -n $app --src ../../zip/app.zip

echo "4.1. sleep and restart the webapp service"
sleep 6
az webapp restart -n $app -g $rg
