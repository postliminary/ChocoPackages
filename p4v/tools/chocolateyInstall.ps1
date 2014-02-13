$packageName = 'p4v'
$installerType = 'EXE'
$url = 'http://www.perforce.com/downloads/perforce/r13.4/bin.ntx86/p4vinst.exe'
$url64 = 'http://www.perforce.com/downloads/perforce/r13.4/bin.ntx64/p4vinst64.exe'
$silentArgs = '/s /v"/qn"'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
