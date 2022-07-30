#Fonte: https://timmyit.com/2016/08/08/sccm-and-powershell-force-installuninstall-of-available-software-in-software-center-through-cimwmi-on-a-remote-client/
#Alterado por Diego Rosário Sousa - diegos.sonda@contratada.oi.net.br

$strComputador = "DSKCCPAGO017206"
$strAplicativo = "Java 8 Update 181"
$Metodo = "Uninstall" # Utilizar "Install" para instalar e "Uninstall" para desinstalar
Function Start-CentralSoftwareInstallation
{
    
    Param
    (
        [String][Parameter(Mandatory=$True, Position=1)] $Computername,
        [String][Parameter(Mandatory=$True, Position=2)] $AppName,
        [ValidateSet("Install","Uninstall")]
        [String][Parameter(Mandatory=$True, Position=3)] $Method
    )
    
    Begin 
    {
        $Application = Get-WmiObject -ClassName CCM_Application -Namespace "root\ccm\clientSDK" -ComputerName $Computername | Where-Object {$_.Name -like $AppName}
        
        $CCMApplication = [wmiclass]"\\$($Computername)\root\ccm\clientSDK:CCM_Application"
        $Argus = @{EnforcePreference = [UINT32] 0
        Id = "$($Application.id)"
        IsMachineTarget = $Application.IsMachineTarget
        IsRebootIfNeeded = $False
        Priority = 'High'
        Revision = "$($Application.Revision)" }
    }
    
    Process
    {
        
        $CCMApplication.$($Method)($Argus.Id, $Argus.Revision, $Argus.IsMachineTarget, $Argus.EnforcePreference, $Argus.Priority, $Argus.IsRebootIfNeeded)
    }
    
    End {}
    
}
Start-CentralSoftwareInstallation -Computername $strComputador -AppName $strAplicativo -Method $Metodo