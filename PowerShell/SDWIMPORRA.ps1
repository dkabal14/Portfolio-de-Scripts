Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Function Lista-Escolha
{
    param
    (
     [Array]$Lista  
    )
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Selecionar Partição'
    $form.Size = New-Object System.Drawing.Size(600,200)
    $form.StartPosition = 'CenterScreen'

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(150,120)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = 'Cancel'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(580,20)
    $label.Text = 'Escolha o disco que será FORMATADO:'
    $form.Controls.Add($label)

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10,40)
    $listBox.Size = New-Object System.Drawing.Size(560,20)
    $listBox.Height = 80

    #[void] $listBox.Items.Add('atl-dc-001')
    #[void] $listBox.Items.Add('atl-dc-002')
    #[void] $listBox.Items.Add('atl-dc-003')
    #[void] $listBox.Items.Add('atl-dc-004')
    #[void] $listBox.Items.Add('atl-dc-005')
    #[void] $listBox.Items.Add('atl-dc-006')
    #[void] $listBox.Items.Add('atl-dc-007')
    $contador = 0
    Do
    {
        [void] $listBox.Items.Add($Lista[$contador])
        $contador = $contador + 1
    } While ($contador -le ($Lista.Length - 1))

    $form.Controls.Add($listbox)

    $form.Topmost = $true

    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $listBox.SelectedItem
        $x
    }
}

#Selecionar o Disco para formatação completa
Function Escolhe-Disco
{
    $colDisk = Get-Disk | Select-Object -Property DiskNumber,Friendlyname,Size,SerialNumber | Sort-Object -Property DiskNumber
    $Result = (Lista-Escolha -Lista $colDisk).DiskNumber
    $Result
}

#Selecionar a Partição para reinstalação do Windows em "Somente uma partição"
Function Escolhe-Particao
{
    $colDisk = Get-Disk | Select-Object -Property DiskNumber,Friendlyname,Size,SerialNumber | Sort-Object -Property DiskNumber
    $Disk = (Lista-Escolha -Lista $colDisk).DiskNumber
    $colPartition = Get-Disk $Disk | Get-Partition | Select-Object -Property PartitionNumber,DriveLetter,Size | Sort-Object -Property PartitionNumber
    $Partition = (Lista-Escolha -Lista $colPartition).PartitionNumber
    $Result = @($Disk,$Partition)
    $Result
}

Function Aplica-Imagem
{
    dism /Apply-Image /ImageFile:N:\Images\my-windows-partition.wim /Index:1 /ApplyDir:W:\
}

Function Formata-DiscoInteiro
{
    Try
    {
        #Selecinar o disco e partição que serão formatados
        $discoFormatado = Escolhe-Disco
        #Criar o script de diskpart na raiz
        $textoScript = "
         select disk $discoFormatado
         clean
         convert gpt
         create partition efi size=500
         format quick fs=fat32 label=System
         assign letter=S
         create partition msr size=128
         create partition primary
         shrink minimum=15000
         format quick fs=ntfs label=Windows
         assign letter=W
         create partition primary
         format quick fs=ntfs label=Recoveryimage
         assign letter=R
         set id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
         gpt attributes=0x8000000000000001
         list volume
         exit"
         $textoScript | Set-Content "$PSScriptRoot\DISKPART_GPT-UEFI.txt"
        #Chamar o Script para formatar
        DISKPART /S "$PSScriptRoot\DISKPART_GPT-UEFI.txt"
        If (Test-Path "w:\")
        {
            #Questionar se o usuário deseja aplicar a imagem
            $questAplicImg = [System.Windows.Forms.MessageBox]::Show('Deseja Instalar o Windows na partição formtada?','SDWIM - N3','YesNoCancel','Question')
            if ($questAplicImg -eq "Yes")
            #Se Verdadeiro
            {
                #Iniciar o script de Aplicação da imagem
                Write-Host "SIIIIIIIIIIIIIIIIIIIIIIM"
            }
            #Se falso
            else
            {
                #Indicar o nome do script de Aplicação de Imagens
                Write-Host "NAAAAAAAAAAAAAAAAAAAAAAO"
            }
        }
        else
        {
            throw "Ocorreu um problema durante a criação e/ou execução do script para formatação do disco"
        }

    }
    Catch [Exception]
    {
        [System.Windows.Forms.MessageBox]::Show($_.Exception,'SDWIM - N3','Ok','Error')
    }
    Finally
    {
        
    }
}
