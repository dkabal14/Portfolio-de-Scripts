$sig = '
[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
[DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);'
$type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru
[IntPtr]$handleConsole = (Get-Process -Id $pid).MainWindowHandle
[void]$type::ShowWindowAsync($handleConsole, 4);[void]$type::SetForegroundWindow($handleConsole)

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form = New-Object system.Windows.Forms.Form
$Form.ClientSize = '800,600'
$Form.text = "Aplicar Imagem"
$Form.TopMost = $False

$Label1 = New-Object System.Windows.Forms.Label
$Label1.text = 'Selecione a imagem'
$Label1.width = 150
$Label1.height = 30
$Label1.location = New-Object System.Drawing.Point(15,15)
$Label1.Font = 'Microsoft Sans Serif,10'

$ComboBox1 = New-Object System.Windows.Forms.ComboBox
$ComboBox1.width = 400
$ComboBox1.height = 30
$ComboBox1.location = New-Object System.Drawing.Point(15,45)
$ComboBox1.Font = 'Microsoft Sans Serif,10'
$colImagens = Get-ChildItem -Path ".\IMAGENS" -Include "*.wim*" -Recurse | foreach {$_.Name}
$ComboBox1.items.AddRange($colImagens)

$label2 = New-Object System.Windows.Forms.Label
$label2.text = "Selectione o disco que vai ser formatado"
$label2.width = 400
$label2.height = 30
$label2.Font = 'Microsoft Sans Serif,10'
$label2.location = New-Object System.Drawing.Point(10,80)

$ComboBox2 = New-Object System.Windows.Forms.ComboBox
$ComboBox2.width = 250
$ComboBox2.height = 30
$ComboBox2.location = New-Object System.Drawing.Point(10,110)
$ComboBox2.Font = 'Microsoft Sans Serif,10'
$colApplyDir = Get-WmiObject -Query "SELECT * FROM Win32_logicaldisk" | Where-Object {$_.DriveType -eq 3} | Select-Object -Property DeviceID,VolumeName,Size
$colApplyDir2 = @()
ForEach ($objItem in $colApplyDir)
{
    $SizeToMB = $objItem.Size/1048576
    
    $colApplyDir2 += $objItem.DeviceID + " | " + $objItem.VolumeName + " | " + [math]::Round($SizeToMB,2) + " MB"
}
$ComboBox2.items.AddRange($colApplyDir2)

$GroupBox3 = New-Object System.Windows.Forms.GroupBox
$GroupBox3.width = 300
$GroupBox3.height = 80
$GroupBox3.text = "Deseja Verificar a imagem depois de aplicar?"
$GroupBox3.location = New-Object System.Drawing.Point(10,140)
$GroupBox3.Font = 'Microsoft Sans Serif,10'

$RadioButton1 = New-Object System.Windows.Forms.RadioButton
$RadioButton1.width = 60
$RadioButton1.height = 30
$RadioButton1.location = New-Object System.Drawing.Point(15,161)
$RadioButton1.text = "Sim"
$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton2.width = 60
$RadioButton2.height = 30
$RadioButton2.location = New-Object System.Drawing.Point(75,161)
$RadioButton2.text = "Nao"

$GroupBox3.Controls.Add($RadioButton1)
$GroupBox3.Controls.Add($RadioButton2)

$Form.Add_Shown({
    $global:handleForm = (Get-Process -Id $pid).MainWindowHandle
})

$Button1.Add_Click({
    [void]$type::ShowWindowAsync($handleConsole, 4);[void]$type::SetForegroundWindow($handleConsole)
    Read-Host -Prompt "Please Enter a Value"
    [void]$type::ShowWindowAsync($global:handleForm, 4);[void]$type::SetForegroundWindow($global:handleForm)
})

$Form.controls.AddRange(@($Label1))
$Form.controls.AddRange(@($ComboBox1))
$Form.controls.AddRange(@($label2))
$Form.controls.AddRange(@($ComboBox2))
$Form.controls.AddRange(@($RadioButton1))
$Form.controls.AddRange(@($RadioButton2))
$Form.controls.AddRange(@($GroupBox3))

[void]$Form.ShowDialog()