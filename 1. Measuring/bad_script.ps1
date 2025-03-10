Start-Sleep -seconds 10
$data = Invoke-RestMethod 'https://restcountries.com/v3.1/all'
$unique_regions = $data | Select-Object -Property Region -Unique  
$jsondata = $data | convertto-json  
