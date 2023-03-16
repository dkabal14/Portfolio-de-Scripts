#Teste Get-CredentialGUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
function Get-CredentialGUI
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Titulo
    )
    $inputForm = New-Object System.Windows.Forms.Form
    $inputForm.Text = $Titulo
    $inputForm.Size = New-Object System.Drawing.Size(350,200)
    $inputForm.StartPosition = 'CenterScreen'
    $inputForm.Icon = ('C:\d\Scripts\Github\Portfolio-de-Scripts\PowerShell\Hihgbond-LaunchPadModule\Resources\Highbond-icon.ico')

    $lb = New-Object System.Windows.Forms.Label
    $lb.Location = New-Object System.Drawing.Point(20,20)
    $lb.Size = New-Object System.Drawing.Size(240,20)
    $lb.Text = "E-mail:"
    $inputForm.Controls.Add($lb)

    $tb1 = New-Object System.Windows.Forms.TextBox
    $tb1.Location = New-Object System.Drawing.Point(20,40)
    $tb1.Size = New-Object System.Drawing.Size(240,20)
    $inputForm.Controls.Add($tb1)

    $lb2 = New-Object System.Windows.Forms.Label
    $lb2.Location = New-Object System.Drawing.Point(20,60)
    $lb2.Size = New-Object System.Drawing.Size(240,20)
    $lb2.Text = "Senha"
    $inputForm.Controls.Add($lb2)

    $tb2 = New-Object System.Windows.Forms.TextBox
    $tb2.Location = New-Object System.Drawing.Point(20,80)
    $tb2.Size = New-Object System.Drawing.Size(240,20)
    $tb2.PasswordChar = '#'
    $inputForm.Controls.Add($tb2)

    $okb = New-Object System.Windows.Forms.Button
    $okb.Location = New-Object System.Drawing.Point(20,105)
    $okb.Size = New-Object System.Drawing.Size(75,25)
    $okb.Text = 'Ok'
    $okb.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $inputForm.AcceptButton = $okb
    $inputForm.Controls.Add($okb)

    $inputForm.Topmost = $true
    $inputForm.Add_Shown({$tb1.Select()})
    $rs = $inputForm.ShowDialog()
    if ($rs -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $result = [PSCustomObject]@{
            email = $tb1.text
            senha = $tb2.text
        }
        return $result
    }
}

#Teste Criando um manifesto para um módulo de powershell
function Create-ModuleManifest {
    $ModuleName     = "Highbond-LaunchPadModule"
    $path           = "C:\D\Scripts\Github\Portfolio-de-Scripts\PowerShell\LocalRepository\$ModuleName"
    $CompanyName    = "Quality Software S.A."
    $Author         = "Diego Rosário Sousa"
    $CopyRights     = "2023, Quality Software S.A. All Rights Reserved"
    $Description    = "Module to web-scrape robots' data from HighBond Launchpad API"
    $ModuleVersion  = "0.0.1"
    $rootModule     = "$path\$ModuleVersion\$ModuleName.psm1"
    $dotNetVersion  = "3.5"
    $Prerelease     = "alpha"
    $Assemblies     = @("System.Windows.Forms","System.Drawing")
    New-ModuleManifest -Path "$path\$ModuleVersion\$ModuleName.psd1" -CompanyName $CompanyName -Author $Author -Copyright $CopyRights -Description $Description -RootModule $rootModule -ModuleVersion $ModuleVersion -DotNetFrameworkVersion $dotNetVersion -Prerelease $Prerelease -TypesToProcess $Assemblies
}