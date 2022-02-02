#Compare local <packageName> package vs. delivered package
#Author: Leith Oscar 
#Date: 02-02-2022
#

Write-Host Compare local <packageName> package vs. delivered package
Write-Host Version: 1.0
 
$basePath = ""
$package = $basePath + '\package.json'
Set-Location $basePath

$json = Get-Content $package | Out-String | ConvertFrom-Json
$jsonDep =$json.dependencies 

Write-Host "path to check:" $package  -ForegroundColor Yellow  
Write-Host "Start Process:"  -ForegroundColor Yellow  

Foreach ($deps in $jsonDep.PSObject.Properties){
                 
                if($deps.Name.Contains("<packageName>"))
                {                    
                    $deliveredVersion= npm view $deps.name"@latest" version  
                    
                    if($deliveredVersion -eq $deps.value)
                    {
                        Write-Host $deps.name $deps.value "it's updated:" $deliveredVersion   -ForegroundColor Green  
                    }
                    else{
                        Write-Host $deps.name $deps.value "must be upload to:" $deliveredVersion   -ForegroundColor Red  
                    }       
                }     
}

Write-Host "end"  -ForegroundColor Yellow  
