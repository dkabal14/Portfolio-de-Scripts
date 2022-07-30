#Script escrito por Diego Rosário Sousa
#diegorosariosousa@gmail.com
#Script com interface gráfica, escrito para comparar os arquivos entre duas pastas e mostrar as diferenças entre elas.
Add-Type -AssemblyName System.Windows.Forms

$form1 = New-Object System.Windows.Forms.Form
$form1.Text = 'AUXILIAR DE BACKUP'
$form1.Size = New-Object System.Drawing.Size(500,200)
$form1.StartPosition = 'CenterScreen'

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,20)
$label1.Size = New-Object System.Drawing.Size(460,20)
$label1.Text = 'Pasta de origem:'
$form1.Controls.Add($label1)

$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Location = New-Object System.Drawing.Point (10,40)
$TextBox1.Size = New-Object System.Drawing.Size(420,20)
$TextBox1.Enabled = $true
$form1.Controls.Add($TextBox1)

$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(430,40)
$button1.Size = New-Object System.Drawing.Size(30,20)
$button1.Text = '...'
$form1.Controls.Add($button1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,60)
$label2.Size = New-Object System.Drawing.Size(460,20)
$label2.Text = 'Pasta a ser comparada:'
$form1.Controls.Add($label2)

$TextBox2 = New-Object System.Windows.Forms.TextBox
$TextBox2.Location = New-Object System.Drawing.Point (10,80)
$TextBox2.Size = New-Object System.Drawing.Size(420,20)
$TextBox2.Enabled = $true
$form1.Controls.Add($TextBox2)

$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(430,80)
$button2.Size = New-Object System.Drawing.Size(30,20)
$button2.Text = '...'
$form1.Controls.Add($button2)

$OKButton1 = New-Object System.Windows.Forms.Button
$OKButton1.Location = New-Object System.Drawing.Point(200,120)
$OKButton1.Size = New-Object System.Drawing.Size(75,23)
$OKButton1.Text = 'OK'
$OKButton1.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form1.AcceptButton = $OKButton1
$form1.Controls.Add($OKButton1)

$button1.Add_Click(
    {
        $objPasta1 = New-Object System.Windows.Forms.FolderBrowserDialog
        $objPasta1.RootFolder = "MyComputer"
        $test1 = $objPasta1.ShowDialog()
        if ($test1 -eq "OK")
        {
            $comp1 = $objPasta1.SelectedPath
            $TextBox1.Text = $comp1
            return 
        }
    }
)

$button2.Add_Click(
    {
        $objPasta2 = New-Object System.Windows.Forms.FolderBrowserDialog
        $objPasta2.RootFolder = "MyComputer"
        $test2 = $objPasta2.ShowDialog()
        if ($test2 -eq "OK")
        {
            $comp2 = $objPasta2.SelectedPath
            $TextBox2.Text = $objPasta2.SelectedPath
        }
    }
)

$check1 = $false
Do
{
    $result1 = $form1.ShowDialog()
    if ($result1 -eq [System.Windows.Forms.DialogResult]::OK)
    {
        if ($TextBox1.Text -eq [string]::Empty -and $TextBox2.Text -eq [string]::Empty)
        {
            [System.Windows.Forms.MessageBox]::Show("Nenhum dos valores foi definido!", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OKOnly,[System.Windows.Forms.MessageBoxIcon]::Information)
        }
        elseif ($TextBox1.Text -eq [string]::Empty -and $TextBox2.Text -ne [string]::Empty)
        {
            [System.Windows.Forms.MessageBox]::Show("Favor informar a pasta de referência!", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OKOnly,[System.Windows.Forms.MessageBoxIcon]::Information)
        }
        elseif ($TextBox1.Text -ne [string]::Empty -and $TextBox2.Text -eq [string]::Empty)
        {
            [System.Windows.Forms.MessageBox]::Show("Favor informar a pasta de backup!", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OKOnly,[System.Windows.Forms.MessageBoxIcon]::Information)
        }
        else
        {
            $AppLog = "$PSScriptroot\Arquivos_Comparados.log"
            "=================================" | Out-File -FilePath $AppLog -Append
            "Processo Iniciado - " + (Get-Date) | Out-File -FilePath $AppLog -Append
            "=================================" | Out-File -FilePath $AppLog -Append
            $objDir1 = Get-ChildItem -Path $TextBox1.Text -Recurse | Select-Object -Property *
            $objDir2 = Get-ChildItem -Path $TextBox2.Text -Recurse | Select-Object -Property *
            $arquivos = Compare-Object -ReferenceObject $objDir1 -DifferenceObject $objDir2 -Property Name
            Foreach ($arquivo in $arquivos)
            {
                if ($arquivo.SideIndicator -eq "<=")
                {
                    $NomeCompletoArquivo = ($objDir1 | Where-Object {$_.Name -eq $arquivo.Name}).FullName
                    Write-Host "Arquivo não encontrado no Backup: "$NomeCompletoArquivo
                    $objDir1 | Where-Object {$_.Name -eq $arquivo.Name} | foreach {"ERROR - Arquivo não encontrado no Backup: " + $_.FullName} | Out-File -FilePath $AppLog -Append
                }
                else
                {
                    $NomeCompletoArquivo = ($objDir2 | Where-Object {$_.Name -eq $arquivo.Name}).FullName
                    Write-Host "Arquivo diferente da Origem: "$NomeCompletoArquivo
                    $objDir2 | Where-Object {$_.Name -eq $arquivo.Name} | foreach {"WARN - Arquivo Diferente da origem: " + $_.FullName} | Out-File -FilePath $AppLog -Append
                }
            }
            "=================================" | Out-File -FilePath $AppLog -Append


            $tamanhoDir1 = $objDir1 | Measure-Object -Property Length -Sum | foreach {$_.Sum}
            $tamanhoDir2 = $objDir2 | Measure-Object -Property Length -Sum | foreach {$_.Sum}
            $quantidadeDir1 = $objDir1 | Measure-Object -Property Length | foreach {$_.Count}
            $quantidadeDir2 = $objDir2 | Measure-Object -Property Length | foreach {$_.Count}
            [System.Windows.Forms.MessageBox]::Show("Tamanho dos arquivos na origem: $tamanhoDir1 Bytes `nTamanho dos arquivos no backup: $tamanhoDir2 Bytes`n `nQuantidade de arquivos na origem: $quantidadeDir1 `nQuantidade de arquivos no backup: $quantidadeDir2", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
            [System.Windows.Forms.MessageBox]::Show("Processo Terminado, abrindo log $AppLog.", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
            Start $AppLog

            $check1 = $true
        }
    }
    else
    {
        [System.Windows.Forms.MessageBox]::Show("Processo Cancelado pelo usuário", "AUXLIAR DE BACKUP",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
        $check1 = $true
    }
} Until ($check1 -eq $true)
