$Creds = Get-Credential -Message "Informe login e senha" -Title "Quotes To Scrape"

$Uri = "http://quotes.toscrape.com"
$Site = Invoke-WebRequest -Uri $Uri

# Clicking on the login link    
$Action = $Site.Links | Where-Object {$_.outerHTML -like "*Login*"} | Select-Object -ExpandProperty href
$LoginUri = $Uri + $Action
$LoginPage = Invoke-WebRequest -Uri $LoginUri -SessionVariable "TempSession"

$csrf_token = $LoginPage.InputFields | Where-Object {$_.name -eq "csrf_token"} | Select-Object -ExpandProperty value

$AuthBody = @{
    username    = $Creds.UserName
    password    = $Creds.Password
    csrf_token  = $csrf_token
    Submit      = "Login"
}

$LoggedUri = Invoke-WebRequest -Uri $LoginUri -Body $AuthBody -WebSession $TempSession -Method Post
$LoggedUri.Headers