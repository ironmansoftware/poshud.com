New-ComponentPage -Title 'Code Editor' -Description 'Edit code using the Monaco editor in your dashboards' -Content {
    New-Example -Title 'Code Editor' -Example {
New-UDCodeEditor -Language powershell -Code '$Process = Get-Process -Name "code" ' -Height '100px' -Autosize
    }
} -Cmdlet @("New-UDCodeEditor")