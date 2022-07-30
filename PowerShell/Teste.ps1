$users = Import-Csv -Path E:\Scripts\PowerShell\users_priv.csv


foreach ($user in $users)
{
    $primeiroNome = ($user.NOME.Split(" "))[0]
    $nsobreNome = ($user.NOME.Split(" "))
    $sobreNome = $nsobreNome[$nsobreNome.length - 1]

    Get-ADUser -Filter {displayName -like "*$($primeiroNome)*$($sobreNome)*"}

    #Get-ADUser -filter {displayName - ($user.NOME).ToLower()} | Select-Object -Property name,displayName
    
}