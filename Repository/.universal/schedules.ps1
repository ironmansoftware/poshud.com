New-PSUSchedule -Cron "0 * * * *" -Script "GetProcess.ps1" -TimeZone "America/Denver"
New-PSUSchedule -OneTime ([DateTime]::Now.AddSeconds(10)) -Script "DisableRoles.ps1" -TimeZone "America/Denver"