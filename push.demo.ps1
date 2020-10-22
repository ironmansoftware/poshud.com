param($dockerpwd, [Switch]$Preview)

$TagNames = @()
$Version = (Get-Content "$PSScriptRoot/version.txt" -Raw).Trim()
if ($Preview)
{
    $TagNames = @("ironmansoftware/universal-demo:preview")
}
else 
{
    $TagNames = @("ironmansoftware/universal-demo:latest", "ironmansoftware/universal-demo:$Version")
}

docker login -u adamdriscoll -p $dockerpwd

$TagNames | ForEach-Object {
    docker tag universal-demo $_
    docker push $_
}
