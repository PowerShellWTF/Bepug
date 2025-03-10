Clear-Host


##############################################################
$guid = New-Guid 

measure-command{   1..100000 |%{ $guid | out-null }    } 

measure-command{   1..100000 |%{ $null = $guid    }    }

##############################################################

Clear-Host


$perfmon =Get-Content 'D:\2. Basic Tips\sampledata.txt'
$perfmon.Count
$perfmon | Select-Object -First 1 

measure-command{ 

  $result1 = $perfmon | Where-Object {$_ -like "*e2*"}     
 
 }

measure-command{  

  $result2 = $perfmon.Where({$_ -like "*e2*"})   

   }






##############################################################

$perfmon = $perfmon  +$perfmon 

Measure-Command{

  ($perfmon | Measure-Object).count 

}


Measure-Command{

  $perfmon.count 

}