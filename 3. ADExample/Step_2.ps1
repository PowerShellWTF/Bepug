#-----------------------------------------------------------------------------------
#  #STEP  2  
#  
#  used memberof property of user  + primarygroup 
#-----------------------------------------------------------------------------------
$users = Get-aduser -filter * -Properties memberof,PrimaryGroup  -SearchBase 'OU=VIP,DC=powershell,DC=wtf' 

remove-variable stopwatch,result,m,user,permission  -ErrorAction SilentlyContinue 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

###############################################################
$result = @()
ForEach($user in $users)
{
        foreach($permission in ($user.Memberof+$user.PrimaryGroup))
        {
          $m  = new-object -TypeName PSObject
          $m | Add-Member -Name 'User' -MemberType NoteProperty -Value $user.Name 
          $m | Add-Member -Name 'DN'   -MemberType NoteProperty -Value $permission 
          $result+=$m
        }
}
###############################################################
$stopwatch.Stop()
$stopwatch
write-host ("total count: {0}" -f $result.count) -ForegroundColor Yellow
