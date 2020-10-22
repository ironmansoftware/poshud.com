param($dockerpwd = $Env:dockerpassword)

$TagNames = @()
$Version = (Get-Content "$PSScriptRoot/version.txt" -Raw).Trim()
$TagNames = @("ironmansoftware/universal-demo:latest", "ironmansoftware/universal-demo:$Version")

docker login -u adamdriscoll -p $dockerpwd

$TagNames | ForEach-Object {
    docker tag universal-demo $_
    docker push $_
}
