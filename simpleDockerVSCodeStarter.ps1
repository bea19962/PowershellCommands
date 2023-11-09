$projectFolder = <projectFolderPath>
$startVSCode = <VSCodePath>

Set-Location -Path $startVSCode

code .

Set-Location -Path $projectFolder

docker-compose down --rmi local

docker-compose -f ./docker-compose.local.yml up --build

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("ALL DONE :D", "PowerShell Message", "OK", "Information")

# Done :D
