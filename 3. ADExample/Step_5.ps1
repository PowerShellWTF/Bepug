#-----------------------------------------------------------------------------------
#  #STEP 5
#  
#           remove loop 
#-----------------------------------------------------------------------------------
$users = Get-aduser -filter * -Properties memberof,PrimaryGroup -SearchBase 'OU=VIP,DC=powershell,DC=wtf' 

remove-variable stopwatch,result,m,user,permission -ErrorAction SilentlyContinue 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

###############################################################

$result = ForEach($user in $users)
  {
       ($user.Memberof+$user.PrimaryGroup) | %{  [PSCustomObject]@{User=$user;DN=$_}}
    
  }
  



###############################################################
$stopwatch.Stop()
$stopwatch
write-host ("total count: {0}" -f $result.count) -ForegroundColor Yellow
