$lista = "
LAPCORPPR106220
"
$lista = $lista.Replace("`r","/").Replace("`n","\")
$lista = $lista.Substring(2,$lista.Length - 4).Split("/\")
$lista = $lista | Select-Object -Unique


foreach ($nomeRemover in $lista)
{
#    try
#    {
        #ALTERAR AQUI!!!!!!!!!!!!!!!!!!
        #=============================================================
        #PROJETO MS TEAMS - INSTALADOS
        #$ColID = "DSK0046A"
        
        #COLLECTION PRA REMOVER PRIVILÉGIO
        $ColID = "DSK00172"
        Write-Host $nomeRemover
        #PROJETO MS TEAMS - PROD
        #$ColID = "DSK00460"
            
        #=============================================================
            
        $Server = "scmpw21.oi.corp.net"
        $Namespace = "root\sms\site_DSK"
        $ResourceID = $null

        $strQuery = "Select * from SMS_Collection where CollectionID = '$ColID'"
        $Collection = Get-WmiObject -Query $strQuery -ComputerName $Server -Namespace $Namespace
        $Collection.Get()
		$regras = $Collection.CollectionRules

        $membros = $regras | Select-Object -Property RuleName
                        
        if ($membros.RuleName -contains $nomeRemover)
        {
            #Remover
            $strQuery = "Select * from SMS_R_System where Name like '$nomeRemover'"
            $nomeRemoverProps = Get-WmiObject -Query $strQuery -Namespace $Namespace -ComputerName $Server
            ForEach ($nomeRemoverProp in $nomeRemoverProps)
            {
                $ResourceID = $nomeRemoverProp.ResourceID
                $RuleName = $nomeRemoverProp.Name
                if ($null -ne $ResourceID)
                {
                    $Error.Clear()
                    $Collection = [WMI]"\\$($Server)\$($Namespace):SMS_Collection.CollectionID='$ColID'"
					$RuleClass = [wmiclass]"\\$($Server)\$($NameSpace):SMS_CollectionRuleDirect"
                    $remRule = $RuleClass.CreateInstance()
                    $remRule.RuleName = $RuleName
                    $remRule.ResourceClassName = "SMS_R_System"
                    $remRule.ResourceID = $ResourceID
                    $Result = $Collection.DeleteMembershipRule($remRule)
                    if ($Result.ReturnValue -eq 0)
                    {
                        Write-Host "Equipamento $nomeRemover removido da collection $($Collection.Name)" -ForegroundColor Green
                        #if (([WMI]"\\$($Server)\$($Namespace):SMS_Collection.CollectionID='$ColID'").CollectionRules.RuleName)
                    }
                    else
                    {
                        Write-Host "Não foi possível remover o equipamento $nomeRemover da Collection $($Collection.Name)" -ForegroundColor Red
                    }
                }

            }
        }
        else
        {
            Write-Host "$($nomeRemover) já está fora da Collection $($Collection.Name)" -ForegroundColor Yellow
        }

    }
#    catch
#    {
#        Write-Host "FALHA GERAL" -ForegroundColor Red
#    }
#}
