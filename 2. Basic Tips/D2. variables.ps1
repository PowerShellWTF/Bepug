
$data = import-csv "D:\2. Basic Tips\sales.csv" 
$data = $data * 2
$data | select-object -first 1 |format-table -AutoSize 

#######################################################################################


Measure-Command {
  $newarray = @() 

  $data |%{
    $newarray += $_.'unit cost'
  }
}


########################################################################################

Measure-Command {
  $newarray2 = [System.Collections.ArrayList]@()

  $data |%{
    $null =  $newarray2.Add($_.'unit cost')
  }
}
   

########################################################################################



Measure-Command {
  $newarray3 = $data.'unit cost' 
}

########################################################################################

Measure-Command {
  $newarray4 = [System.Collections.ArrayList]@()

  $data |%{

    $null =  $newarray4.Add((New-Object -TypeName PSCustomObject -Property @{"UnitCost" = $_.'unit cost';"OrderDate"=$_.'Order Date'}))
  }
}
   
   
########################################################################################




Measure-Command {
  $newarray5 = [System.Collections.ArrayList]@()

  $data |%{

    $null =  $newarray5.Add(([PSCustomOBject]@{"UnitCost" = $_.'unit cost';"OrderDate"=$_.'Order Date'}))
  }
}
   
 
######################################################################################## 


Measure-Command {


  $newarray6 = $data |%{ [PSCustomOBject]@{"UnitCost" = $_.'unit cost';"OrderDate"=$_.'Order Date'}}
}
   


######################### JUST FOR FUN ##########################################################


Measure-Command {
  $newarray7 = $data |Select-Object -Property @{Name="UnitCost";e={$_.'unit cost'}},@{Name="OrderDate";e={$_.'Order Date'}}
}
   

