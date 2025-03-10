$data_array = 1..1000000

measure-command{ 
 
     $data_array | ForEach-Object {$a = 1/2}    

}


 measure-command{ 

  $totalcount = $data_array.count
    for ($x = 0; $x -lt  $totalcount ; $x++)  { $a = 1/2 }
 
 
 }

 measure-command{ 
     
     
    foreach($g in $data_array ) {$a = 1/2}    
                            
}

#######################################################################################

$data_array = 1..500000

measure-command {
  $data_array| ForEach-Object  { $a = 1/2 }
  }

measure-command {
  $data_array| ForEach-Object -Parallel { $a = 1/2  }
}