tmpdir=/tmp/temp-app-deployment
az=/usr/local/bin/az
jq=/usr/bin/jq

echo Application Deployment 

dir=$(System.DefaultWorkingDirectory)
artdir=$(System.ArtifactsDirectory)

[ -d $tmpdir ] && rm -rf $tmpdir
mkdir $tmpdir

for f in $(find $dir/ -name 'app.zip' -o -name export.sh)
do
  echo $f
  cp $f $tmpdir/.
done

. /tmp/env.sh
echo $RG
echo $APP

cd $tmpdir
for i in `ls *.zip`
do
  $az webapp deployment source config-zip -g $RG -n $APP --src $i
done

echo "Restart to adopt the deployment changes"
$az webapp restart -n $APP -g $RG

