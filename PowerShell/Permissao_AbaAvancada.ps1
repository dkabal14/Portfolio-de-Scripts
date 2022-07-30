#Script escrito por Diego Rosário Sousa - diegos.sonda@contratada.oi.net.br
#Suporte Nível 3 - RJ
#Atualização do Permissao_AbaAvancada.bat
<#
    Todos Níveis de ACL (Access Control List)
    disponíveis em:
    https://docs.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemrights?view=net-5.0
#>

$chaveDestino = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"

$FileSystemRights = "FullControl"
$AccessControlType = "Allow"
$IdentityReferences = @(
    "AUTORIDADE NT\Usuários autenticados"
    "AUTORIDADE NT\SISTEMA"
    "BUILTIN\Administradores"
    "OI\TC057318"
)
$chaveDestino = "HKLM:\SOFTWARE\Teste"
$objchaveDestino = Get-ChildItem -Path $chaveDestino -Recurse | Select-Object -Property *
$subChaves = @()
$subChaves += $objchaveDestino | Select-Object -Property PSParentPath -Unique | ForEach-Object {$_.PSParentPath}
$subChaves += $objchaveDestino.PSPath

foreach ($subChave in $subChaves)
{
    foreach ($IdentityReference in $IdentityReferences)
    {
        $Configs = $IdentityReference, $fileSystemRights, $AccessControlType
        $acesso = New-Object -TypeName System.Security.AccessControl.RegistryAccessRule -ArgumentList $Configs
        $novoAcl = Get-Acl -Path $subChave
        $novoAcl.SetAccessRule($acesso)
        Set-Acl -Path $subChave -AclObject $novoAcl
    }
}