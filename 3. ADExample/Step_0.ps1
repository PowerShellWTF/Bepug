#-----------------------------------------------------------------------------------
#  #INITIAL 
#  
#  customer wants variable with username + groupmember distinguished Names
#-----------------------------------------------------------------------------------
$users = get-aduser -Properties * -Filter * -SearchBase 'OU=VIP,DC=powershell,DC=wtf' 

remove-variable stopwatch,result,m,user,permission  -ErrorAction SilentlyContinue 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

###############################################################
$result = @()
ForEach($user in $users)
{
  $permissions = (Get-ADPrincipalGroupMembership -Identity $user.SID )
        foreach($permission in $permissions)
        {
          $m  = new-object -TypeName PSObject
          $m | Add-Member -Name 'User' -MemberType NoteProperty -Value $user.Name 
          $m | Add-Member -Name 'DN'   -MemberType NoteProperty -Value $permission.DistinguishedName 
          $result+=$m         
        }
}
###############################################################
$stopwatch.Stop()
$stopwatch
write-host ("total count: {0}" -f $result.count) -ForegroundColor Yellow
