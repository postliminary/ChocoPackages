function Main
{
    $scriptDir = Get-ScriptDirectory
    Write-Host "Package directory: $scriptDir"

    #Confrim build
    Read-Host "Press any key to build a new anydvd package"

    #Confirm version
    $version = Get-Version
    Read-Host "Press any key to update anydvd package to $version"

    #Build
    $nuspec = Join-Path $scriptDir "anydvd.nuspec"
	
	Set-Location -Path $scriptDir
    
    Update-Nuspec-File $nuspec
    Update-Install-File (Join-Path $scriptDir "tools\chocolateyInstall.ps1")
    Build-Package $nuspec
    
    #Test
    Read-Host "Press any key to test package"
    Test-Package $version $scriptDir
    
    #Push
    if((Read-Host "Do you want to push package [y/n]") -eq "y")
    {
        $package = Join-Path $scriptDir ("anydvd." + $version + ".nupkg")
        Push-Package $package
    }

    Read-Host "Finished. Press any key to exit"
}

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope Global).Value;
    if($Invocation.PSScriptRoot)
    {
        $Invocation.PSScriptRoot;
    }
    Elseif($Invocation.MyCommand.Path)
    {
        Split-Path $Invocation.MyCommand.Path
    }
    else
    {
        $Invocation.InvocationName.Substring(0,$Invocation.InvocationName.LastIndexOf("\"));
    }
}

function Get-Version
{
    $input = Read-Host "Enter anydvd version number [X.X.X.X]"

    while($input -notmatch "\d\.\d\.\d\.\d") 
    {
        $input = Read-Host "Invalid format please try again [X.X.X.X]"
    }
    
    $input
}

function Update-Nuspec-File ($file)
{
    #Updating version in nuspec file
    Write-Host "Modifying $file"
    
    (Get-Content $file) | 
    Foreach-Object {$_ -replace "<version>.*</version>","<version>$version</version>"}  | 
    Out-File $file
}

function Update-Install-File ($file)
{
    #Updating version in install script file
    Write-Host "Modifying $file"
    
    (Get-Content  $file) | 
    Foreach-Object {$_ -replace "SetupAnyDVD\d+",("SetupAnyDVD" + ($version -replace "\.",""))}  | 
    Out-File $file
}

function Build-Package ($file)
{
    Write-Host "Building package..."
    $command = "cpack $file"
    iex $command
    Write-Host "Done"
}

function Test-Package ($version, $dir)
{
    Write-Host "Testing package..."
    $command = "cinst anydvd -version $version -source $dir"
    iex $command
    Write-Host "Done"
}

function Push-Package ($file)
{
    Write-Host "Pushing package..."
    $command = "cpush $file"
    iex $command
    Write-Host "Done"
}

Main