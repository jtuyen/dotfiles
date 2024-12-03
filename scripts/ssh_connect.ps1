function Get-JsonConfigValues($configFilePath) {
    $ErrorActionPreference = "Stop" # Stop on error
    
    if (-not (Test-Path $configFilePath)) {
        Write-Output "The provided JSON file does not exist."
        return
    }
    
    try {
        $jsonContent = Get-Content -Raw $configFilePath | ConvertFrom-Json 
        
        # Extract server details from the json content
        $server = $jsonContent.server

        if ($null -eq $server) {
            Write-Output "No 'server' entry found in provided JSON file."
            return
        }

        # Output each key-value pair
        $server | Get-Member -MemberType NoteProperty | ForEach-Object {
            $key = $_.Name
            $value = $server.$key
            
            Write-Output "Key: $key, Value: $value"
        }
    } catch {
        Write-Error "An error occurred while reading the JSON file."
        $_ # Re-throw the exception for debugging purposes
    }
}

while ($true) {
    # Ask the user for their command
    $command = Read-Host "Please enter your command"
    
    # Use a switch statement to determine which action to take based on the user's input
    switch ($command) {
        'exit' || 'q' { 
            Write-Output "Exiting script..."
            break 
        }
        
        'date' { 
            Write-Output "The current date and time is: $(Get-Date)"
        }
        
        'dir' { 
            $folder = Read-Host "Please enter the folder path you want to list"
            Get-ChildItem -Path $folder
        }
        
        default { 
            Write-Output "Unknown command. Please try again."
        }
    }
}
