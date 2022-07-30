#Script criado por Diego por Diego Ros�rio Sousa - Suporte N�vel 3 - RJa
#diegos.sonda@contratada.oi.net.br
#Mostra uma lista dos softwares instalados e te permite remov�-lo (para executar com perfil de adminsitrador em m�quinas com usu�rios sem priv logados)

$softwares = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
$softNames = $softwares | Get-ItemProperty | Select-Object -Property DisplayName | foreach {$_.DisplayName}

Function Show-Menu #Usu�rio FischFreund em https://www.reddit.com/r/PowerShell/comments/8afs51/create_dynamic_menu_from_array/
{

    Param(

        [String[]]$softNames

    )

    do { 
    
        Write-Host "Selecione o software para remo��o:"

        $index = 1
        foreach ($location in $softNames) {
    
            Write-host "[$index] $location"
            $index++

        }
    
        $Selection = Read-Host 

    } until ($softNames[$selection-1])

    Write-Verbose "You selected $($softNames[$selection-1])" -Verbose

    Return $softNames[$selection-1]

}

$Selection = Show-Menu -softNames $softNames
$optRemove = $softwares | Get-ItemProperty | Where-Object {$_.displayName -eq $Selection}# | Select-Object -Property UninstallString

Write-Host $optRemove.uninstallString -ForegroundColor Yellow
Start cmd -ArgumentList /c,$optRemove.UninstallString