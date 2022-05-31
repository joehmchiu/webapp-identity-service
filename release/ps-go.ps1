
$url = "https://vsrm.dev.azure.com/karbonhq-ops/Karbon%20Infrastructure/_apis/release/releases?api-version=5.1"
$PAT = "OmJzNDM2ZWw2NnM2YjNyaWNvc2Q3MzZibnc2YmV1dXR6Zm1qazQzZHZlZzV0Y254M2R5N2E="
$body= '{
    "definitionId": 3
    }'
$result=Invoke-RestMethod -Uri $url -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)} -Method post -ContentType "application/json" -Body $body

