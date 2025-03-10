$users = Get-aduser -filter * -Properties * -SearchBase 'OU=VIP,DC=powershell,DC=wtf' 

remove-variable stopwatch,result,m,user,permission  -ErrorAction SilentlyContinue 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
$results = @()
ForEach($user in $users)
{
  $permissions = Get-ADPrincipalGroupMembership -Identity $user.SID
  $userName = $user.Name
  ForEach($permission in $permissions)
  {
    $result = [PSCustomObject]@{
      User = $userName
      DN   = $permission.DistinguishedName
    }
    $results += $result
  }
}

###############################################################
$stopwatch.Stop()
$stopwatch
write-host ("total count: {0}" -f $results.count) -ForegroundColor Yellow
