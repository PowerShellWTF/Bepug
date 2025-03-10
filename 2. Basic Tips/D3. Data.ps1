

Measure-Command { 
  $tmp_lookup = Get-aduser -filter * -Properties * -SearchBase 'OU=NumericUsers,DC=powershell,DC=wtf' 
}

Measure-Command { 
  $tmp_lookup_2 = Get-aduser -filter * -Properties memberof -SearchBase 'OU=NumericUsers,DC=powershell,DC=wtf' 
}




############ data source https://mavenanalytics.io/data-playground

$stock_data = import-csv 'D:\2. Basic Tips\stocks.csv'
$stock_data.count
$stock_data | Select-Object -First 1 
#######################################################################################
measure-command {
  $stock_data_result1 = $stock_data.Where({$_.Symbol -eq "NTAP"})
  $stock_data_result2 = $stock_data.Where({$_.Symbol -eq "AMD"})
  $stock_data_result3 = $stock_data.Where({$_.Symbol -eq "DUK"})
  $stock_data_result3 = $stock_data.Where({$_.Symbol -eq "XRAY"})
  $stock_data_result4 = $stock_data.Where({$_.Symbol -eq "ABC"})
}


measure-command {
  $hashtable = $stock_data |%{ @{$_.symbol = $_}}
}

$hashtable.'NTAP'

Measure-Command {
  $stock_data_hash_result1 = $hashtable.'NTAP'
  $stock_data_hash_result2 = $hashtable.'AMD'
  $stock_data_hash_result3 = $hashtable.'DUK'
  $stock_data_hash_result4 = $hashtable.'XRAY'
  $stock_data_hash_result5 = $hashtable.'ABC'
}



$folderPath = 'D:\Z. JsonData'
set-location  $folderPath 
###############################################################
###############################################################


Measure-Command {


  $files= Get-ChildItem *.json

}


###############################################################
###############################################################

Measure-Command {
  $filter = '*.json'
  $queue  = [Collections.Generic.Queue[IO.DirectoryInfo]]::new()
  $queue.Enqueue((Get-Item $folderPath))
  $result = while($queue.Count) {
    try {
        $target = $queue.Dequeue()
        foreach($item in $target.EnumerateDirectories()) {
            $queue.Enqueue($item)
        }
        foreach($item in $target.EnumerateFiles($filter)) {
            [pscustomobject]@{
                Created      = $item.CreationTime
                Name         = $item.Name
                AbsolutePath = $item.FullName
            }
        }
    }
    catch {
      # ignore inaccessible / access denied folders
      # can add error handling here if needed else leave blank
    }
  }
}


#

#