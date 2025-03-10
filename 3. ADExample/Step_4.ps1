#-----------------------------------------------------------------------------------
#  #STEP 4  
#  
#  PSCustomObject 
#-----------------------------------------------------------------------------------
$users = Get-aduser -filter * -Properties memberof,PrimaryGroup -SearchBase 'OU=VIP,DC=powershell,DC=wtf' 

remove-variable stopwatch,result,m,user,permission  -ErrorAction SilentlyContinue 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

###############################################################

$result = ForEach($user in $users)
  {
      foreach($permission in ($user.Memberof+$user.PrimaryGroup))
      {
        $permission | %{[PSCustomObject]@{User=$user;DN=$_}}
        }
  }


###############################################################
$stopwatch.Stop()
$stopwatch
write-host ("total count: {0}" -f $result.count) -ForegroundColor Yellow
