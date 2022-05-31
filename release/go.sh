
url="https://vsrm.dev.azure.com/karbonhq-ops/Karbon%20Infrastructure/_apis/release/releases?api-version=5.1"
user=$(az account show | jq -r .user.name)
PAT="OmJzNDM2ZWw2NnM2YjNyaWNvc2Q3MzZibnc2YmV1dXR6Zm1qazQzZHZlZzV0Y254M2R5N2E="
PAT="OmJzNDM2ZWw2NnM2YjNyaWNvc2Q3MzZibnc2YmV1dXR6Zm1qazQzZHZlZzV0Y254M2R5N2E="
body='{
    "definitionId": 3
    }'

ret=$(curl --write-out "%{http_code}\n" -X POST -L \
  -u $user:$PAT $url \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{ "definitionId": 3 }' --output output.txt --silent)

echo $ret
