Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Show-Janelas
{
    $form1 = New-Object System.Windows.Forms.Form
    $form1.Text = 'Data Entry Form'
    $form1.Size = New-Object System.Drawing.Size(300,500)
    $form1.StartPosition = 'CenterScreen'

    $okButton1 = New-Object System.Windows.Forms.Button
    $okButton1.Location = New-Object System.Drawing.Point(75,400)
    $okButton1.Size = New-Object System.Drawing.Size(75,23)
    $okButton1.Text = 'OK'
    $okButton1.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form1.AcceptButton = $okButton
    

    $cancelButton1 = New-Object System.Windows.Forms.Button
    $cancelButton1.Location = New-Object System.Drawing.Point(150,400)
    $cancelButton1.Size = New-Object System.Drawing.Size(75,23)
    $cancelButton1.Text = 'Cancel'
    $cancelButton1.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form1.CancelButton = $cancelButton
    

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Location = New-Object System.Drawing.Point(10,20)
    $label1.Size = New-Object System.Drawing.Size(280,20)
    $label1.Text = 'Cole a lista de máquinas na caixa de texto abaixo::'
    

    $textBox1 = New-Object System.Windows.Forms.TextBox
    $textBox1.Multiline = $true
    $textBox1.ScrollBars = "Vertical"
    $textBox1.Location = New-Object System.Drawing.Point(10,40)
    $textBox1.Size = New-Object System.Drawing.Size(260,60)
    

    $comboBox1 = New-Object System.Windows.Forms.ComboBox
    $comboBox1.Location = New-Object System.Drawing.Point(10,140)
    $comboBox1.Size = New-Object System.Drawing.Size(260,60)
    $comboBox1.Text = "Escolha a OU:"
    
    Clear-Host
    

    #Adicionar Controles:
    $form1.Controls.Add($okButton1)
    $form1.Controls.Add($cancelButton1)
    $form1.Controls.Add($label1)
    $form1.Controls.Add($textBox1)
    $form1.Controls.Add($comboBox1)


    $form1.Topmost = $true

    $form1.Add_Shown({$textBox1.Select()})
    $result = $form1.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox1.Text
        Return $x
    }
}

function get-OUPadrao #lista de OU's para preencher o ComboBox
{
    
}

#function Move-OU

Show-Janelas