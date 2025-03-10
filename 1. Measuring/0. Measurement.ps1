Set-Location 'D:\Z. JsonData'
#-----------------------------------------------------------------------------------

Measure-Command {

  $files= Get-ChildItem *.json
  
}
#-----------------------------------------------------------------------------------
Remove-Variable files 

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
$files= Get-ChildItem *.json
$stopwatch.Stop()
$stopwatch
#-----------------------------------------------------------------------------------



set-location "D:\1. Measuring\"


Measure-Command -Expression {.\bad_script.ps1}




$trace_results = Trace-Script -ScriptBlock { .\bad_script.ps1} 



$trace_results.Top50Duration | ogv 






$trace_results = Trace-Script -ScriptBlock { .\bad_script.ps1} -ExportPath 'D:\1. Measuring'