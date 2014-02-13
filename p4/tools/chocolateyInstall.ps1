$packageName = 'p4'
$installerType = 'EXE'
$url = 'http://www.perforce.com/downloads/perforce/r12.2/bin.ntx86/perforce.exe'
$url64 = 'http://www.perforce.com/downloads/perforce/r12.2/bin.ntx64/perforce64.exe'
$silentArgs = '/s /v"/qn"'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
