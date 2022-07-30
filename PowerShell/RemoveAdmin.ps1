function Remove-Privilegio
{
    $listaRemocao = Get-LocalGroupMember -Group "Administradores" | Where-Object {$_.objectClass -eq "Usuário" -and $_.Name -ne "$env:COMPUTERNAME\Supervisor"} | foreach {$_.Name}

    ForEach ($Usuario in $listaRemocao)
    {
        Write-Host "Removendo o usuário $Usuario da lista" -ForegroundColor Red
        Remove-LocalGroupMember -Group "Administradores" -Member $Usuario
    }
}
Remove-Privilegio