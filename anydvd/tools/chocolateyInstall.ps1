﻿$packageName = 'anydvd'
$installerType = 'EXE'
$url = 'http://static.slysoft.com/SetupAnyDVD7460.exe'
$url64 = $url
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
