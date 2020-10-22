Invoke-RestMethod -Method Post -Uri http://127.0.0.1:5000/api/v1/signin -Body (@{ userName = 'admin'; password = 'any'} | ConvertTo-Json) -SessionVariable session -ContentType 'application/json'
Invoke-RestMethod -Uri http://127.0.0.1:5000/api/v1/role/1 -Method DELETE -WebSession $session 
Invoke-RestMethod -Uri http://127.0.0.1:5000/api/v1/role/2 -Method DELETE -WebSession $session   