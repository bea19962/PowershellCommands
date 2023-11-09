$projectFolder = <projFolderPath>
$startVSCode = <VSCodePath>
$dockerDesktopPath = <dockerPath>
$dockerComposeFile = <composePath>
$networkName = <networkName>
$containerName = <containerName>

# Open Docker and wait for a bit
& $dockerDesktopPath
Start-Sleep -Seconds 5

# Open VSCode at the specified location
Set-Location -Path $startVSCode
code .

# Start Docker services for the project
Set-Location -Path $projectFolder
docker-compose down
docker-compose -f $dockerComposeFile up -d


# Check if the network and container are created
$networkExists = docker network ls --format "{{.Name}}" | Where-Object { $_ -eq $networkName }
$containerExists = docker ps -a --format "{{.Names}}" | Where-Object { $_ -eq $containerName }

if ($networkExists -and $containerExists) {
    # Send the key command to open another Windows Terminal tab
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("^+(t)")

    # Run npm start in the newly opened tab
    Start-Sleep -Seconds 2 # Wait a bit for the new tab to open
    [System.Windows.Forms.SendKeys]::SendWait("cd $($projectFolder)\<appName>{ENTER}npm start{ENTER}")
