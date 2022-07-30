$list = @("DSKPSRDRJ099611","DSKPSRDRJ096332","DSKPSRDRS098687","DSKPSRDRJ088232","DSKPSRDRJ099383")
#ID da Collection onde o Deploy foi feito
$CollectionID = "DSK003B1"

$tb = @()

$cont = 0

"`n"
foreach ($computer in $list)
{
    $CountTB = $tb.Count
    $cont = $cont + 1
    $Query = "SELECT * FROM SMS_AppDeploymentAssetDetails Where MachineName = '$($computer)' and CollectionID = '$($CollectionID)'"
    
    $tb += Get-WmiObject -Query $Query -Namespace "root\SMS\site_DSK" -ComputerName "scmpw21.oi.corp.net" | `
    Select-Object -Property MachineName, AppName,
    @{
        Name = 'AppStatusType'
        Expression = 
        {
            switch ($_.AppStatusType) 
            {
            
                1 {"Success"}
                2 {"InProgress"}
                3 {"RequirementsNotMet"}
                4 {"Unknown"}
                5 {"Error"}
            }
        }
    }
    
    if ($tb.Count -eq $CountTB)
    {
        Write-Host "Equipamento $($computer) não pôde ser encontrado" -ForegroundColor Yellow
    }
}

$tb | Sort-Object -Property AppStatusType -Descending