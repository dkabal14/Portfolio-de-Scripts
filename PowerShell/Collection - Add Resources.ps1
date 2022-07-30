<#
Author: Ryan Ephgrave
Now Micro Right Click Tools
#>

$ScriptName = $MyInvocation.MyCommand.path
$Directory = Split-Path $ScriptName
Import-Module "$Directory\Functions - Col Depl.ps1"
Import-Module "$Directory\Functions - Working.ps1"

$ColID = $args[0]
$ColName = $args[1]
$Server = $args[2]
$Namespace = $args[3]

$Popup = New-Object -ComObject wscript.shell

Function Btn_Start_Click {
	$RulesToSkip = $null
	$strMessage = "Do you want to add these computers to $colname" + "?"
	$PopupAnswer = $Popup.Popup($strMessage,0,"Are you sure?",1)
	if ($PopupAnswer -eq 1) {
		$CompNameArray = $SyncTable.CompList
		$CompNameArray = $CompNameArray.Split("`n")
		$CompNameArray = $CompNameArray.Split("`r")
		$CompNameArray = $CompNameArray | select -Unique
		$strQuery = "Select * from SMS_Collection where CollectionID = '$ColID'"
		$Collection = Get-WmiObject -query $strQuery -ComputerName $Server -Namespace $Namespace
		$Collection.Get()
		Log -Message "Getting current direct rule list..."
		$Rules = $Collection.CollectionRules
		foreach ($Rule in $Rules) {
			$RuleClass = $Rule.__CLASS
			if ($RuleClass -eq "SMS_CollectionRuleDirect") {
				$RuleName = $Rule.RuleName
				if ($CompNameArray -icontains $RuleName) {$RulesToSkip += @($RuleName)}
			}
		}
		Log -Message "Starting to add rules..."
		foreach ($CompName in $CompNameArray) {
			$ResourceID = $null
			if ($RulesToSkip -contains $CompName) {
				Log -Message "$CompName rule already exists!"
				$Results = Select-Object -InputObject "" Name, Result
				$Results.Name = $CompName
				$Results.Result = "Rule already exists"
				$Synctable.DataGridResults += $Results
			}
			elseif ($CompName -eq "") {}
			else {
				if ($CompName -ne $null) {
					$strQuery = "Select * from SMS_R_System where Name like '$CompName'"
					Get-WmiObject -Query $strQuery -Namespace $Namespace -ComputerName $Server | ForEach-Object {
						$ResourceID = $_.ResourceID
						$RuleName = $_.Name
						$CompName = $RuleName
						if ($ResourceID -ne $null) {
							$Error.Clear()
							$Collection=[WMI]"\\$($Server)\$($Namespace):SMS_Collection.CollectionID='$ColID'"
							$RuleClass = [wmiclass]"\\$($Server)\$($NameSpace):SMS_CollectionRuleDirect"
							$newRule = $ruleClass.CreateInstance()
							$newRule.RuleName = $RuleName
							$newRule.ResourceClassName = "SMS_R_System"
							$newRule.ResourceID = $ResourceID
							$Collection.AddMembershipRule($newRule)
							if ($Error[0]) {
								Log -Message "Error adding $CompName - $Error"
								$ErrorMessage = "$Error"
								$ErrorMessage = $ErrorMessage.Replace("`n","")
								$Results = Select-Object -InputObject "" Name, Result
								$Results.Name = $CompName
								$Results.Result = "$ErrorMessage"
								$Synctable.DataGridResults += $Results
							}
							else {
								Log -Message "Successfully added $CompName"
								$Results = Select-Object -InputObject "" Name, Result
								$Results.Name = $CompName
								$Results.Result = "Successfully Added"
								$Synctable.DataGridResults += $Results
							}
						}
						else {
							Log -Message "Could not find $CompName - No rule added"
							$Results = Select-Object -InputObject "" Name, Result
							$Results.Name = $CompName
							$Results.Result = "No Resource ID"
							$Synctable.DataGridResults += $Results
						}
					}
					if ($ResourceID -eq $null) {
						Log -Message "Could not find $CompName - No rule added"
						$Results = Select-Object -InputObject "" Name, Result
						$Results.Name = $CompName
						$Results.Result = "No Resource ID"
						$Synctable.DataGridResults += $Results
					}
				}
			}
		}
	}
	Log -Message "Finished!"
}

$Global:SyncTable = [HashTable]::Synchronized(@{})
$SyncTable.Host = $Host
$SyncTable.ColName = $ColName
$SyncTable.Directory = $Directory
$Synctable.DataGridResults = New-Object System.Collections.Arraylist
$Runspace = [RunspaceFactory]::CreateRunspace()
$Runspace.ApartmentState = "STA"
$Runspace.ThreadOptions = "ReuseThread"
$Runspace.Open()
$Runspace.SessionStateProxy.SetVariable("SyncTable",$SyncTable)
$psScript = [Powershell]::Create().AddScript({

    Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
	[XML]$xaml = @'
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Add Resources to Collection" Height="500" Width="475" ShowInTaskbar="False" WindowStartupLocation="CenterScreen">
    <Grid>
        <Menu Height="22" VerticalAlignment="Top">
            <MenuItem x:Name="MS_File" Header="File" Height="22">
                <MenuItem x:Name="MS_Config" Header="Configure Tools" Height="22"/>
                <MenuItem x:Name="MS_Exit" Header="Exit" Height="22"/>
            </MenuItem>
            <MenuItem x:Name="MS_Help" Header="Help" Height="22">
                <MenuItem x:Name="MS_About" Header="About" Height="22"/>
            </MenuItem>
        </Menu>
        <Label x:Name="Lbl_ColName" VerticalAlignment="Top" Content="" Margin="10,25,10,10" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <Label Content="Computer List" HorizontalAlignment="Left" Width="170" VerticalAlignment="Top" Margin="10,54,10,10" VerticalContentAlignment="Center" HorizontalContentAlignment="Center"/>
        <TextBox x:Name="Txt_CompList" TextWrapping="Wrap" AcceptsReturn="True" HorizontalAlignment="Left" Text="" Width="170" Margin="10,84,10,135" HorizontalScrollBarVisibility="Auto" VerticalScrollBarVisibility="Auto"/>
        <Label Content="Results" VerticalAlignment="Top" Margin="190,54,10,10" VerticalContentAlignment="Center" HorizontalContentAlignment="Center"/>
        <DataGrid x:Name="Grid_Results" Margin="190,83,10,135" IsReadOnly="True" AutoGenerateColumns="False" SelectionUnit="FullRow" HeadersVisibility="Column" ItemBindingGroup="{Binding}">
            <DataGrid.Columns>
                <DataGridTextColumn Binding="{Binding Path=Name}" Header="Name"/>
                <DataGridTextColumn Binding="{Binding Path=Result}" Header="Results" Width="*"/>
            </DataGrid.Columns>
        </DataGrid>
        <Label Content="Log" VerticalAlignment="Bottom" Margin="10,10,10,107" HorizontalContentAlignment="Center" VerticalContentAlignment="Center"/>
        <TextBox x:Name="Txt_Log" TextWrapping="NoWrap" AcceptsReturn="True" IsReadOnly="True" VerticalAlignment="Bottom" HorizontalScrollBarVisibility="Auto" VerticalScrollBarVisibility="Auto" Height="75" Margin="10,10,10,32"/>
        <TextBlock x:Name="NowMicroLink" Text="By Now Micro" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="5,5,5,5"/>
        <Button x:Name="Btn_Start" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="75" Height="22" Content="Start" Margin="5,5,10,5"/>
    </Grid>
</Window>

'@
$XMLReader = (New-Object System.Xml.XmlNodeReader $xaml)
$SyncTable.Window = [Windows.Markup.XamlReader]::Load($XMLReader)
$SyncTable.Window.Add_Closed({$SyncTable.Host.Runspace.Events.GenerateEvent("On_Close", $SyncTable.Window, $null, "")})
$SyncTable.MS_File = $SyncTable.Window.FindName("MS_File")
$SyncTable.MS_File.Add_Click({$SyncTable.Host.Runspace.Events.GenerateEvent("MS_File_Click", $SyncTable.MS_File, $null, "")})
$SyncTable.MS_Config = $SyncTable.Window.FindName("MS_Config")
$SyncTable.MS_Config.Add_Click({$SyncTable.Host.Runspace.Events.GenerateEvent("MS_Config_Click", $SyncTable.MS_Config, $null, "")})
$SyncTable.MS_Exit = $SyncTable.Window.FindName("MS_Exit")
$SyncTable.MS_Exit.Add_Click({$SyncTable.Host.Runspace.Events.GenerateEvent("MS_Exit_Click", $SyncTable.MS_Exit, $null, "")})
$SyncTable.MS_Help = $SyncTable.Window.FindName("MS_Help")
$SyncTable.MS_Help.Add_Click({$SyncTable.Host.Runspace.Events.GenerateEvent("MS_Help_Click", $SyncTable.MS_Help, $null, "")})
$SyncTable.MS_About = $SyncTable.Window.FindName("MS_About")
$SyncTable.MS_About.Add_Click({$SyncTable.Host.Runspace.Events.GenerateEvent("MS_About_Click", $SyncTable.MS_About, $null, "")})
$SyncTable.Lbl_ColName = $SyncTable.Window.FindName("Lbl_ColName")
$SyncTable.Txt_CompList = $SyncTable.Window.FindName("Txt_CompList")
$SyncTable.Grid_Results = $SyncTable.Window.FindName("Grid_Results")
$SyncTable.Txt_Log = $SyncTable.Window.FindName("Txt_Log")
$SyncTable.NowMicroLink = $SyncTable.Window.FindName("NowMicroLink")
$SyncTable.Btn_Start = $SyncTable.Window.FindName("Btn_Start")
$SyncTable.Btn_Start.Add_Click({$SyncTable.CompList = $SyncTable.Txt_CompList.Text;$SyncTable.Host.Runspace.Events.GenerateEvent("Btn_Start_Click", $SyncTable.Btn_Start, $null, "")})
$Directory = $SyncTable.Directory
$SyncTable.Window.Icon = "$Directory\NowMicroPointer.ico"
$SyncTable.Lbl_ColName.Content = $SyncTable.ColName

$Timer = New-Object System.Windows.Threading.DispatcherTimer
$Timer.Interval = [TimeSpan]"0:0:1.00"
$Action = {
	$OldText = $SyncTable.Txt_Log.Text
	if ($OldText -ne $SyncTable.LogText) {
		$SyncTable.Txt_Log.Text = $SyncTable.LogText
		$SyncTable.Txt_Log.ScrollToEnd()
	}
	$Synctable.Grid_Results.ItemsSource = $Synctable.DataGridResults
}
$Timer.Add_Tick($Action)
$Timer.Start()

$SyncTable.Window.ShowDialog() | Out-Null
})
$psScript.Runspace = $Runspace
$Handle = $psScript.BeginInvoke()
Register-EngineEvent -SourceIdentifier "On_Close" -Action {On_Close}
Register-EngineEvent -SourceIdentifier "MS_Config_Click" -Action {MS_Config_Click}
Register-EngineEvent -SourceIdentifier "MS_Exit_Click" -Action {MS_Exit_Click}
Register-EngineEvent -SourceIdentifier "MS_About_Click" -Action {MS_About_Click}
Register-EngineEvent -SourceIdentifier "Btn_Start_Click" -Action {Btn_Start_Click}

Start-Sleep 2

$SyncTable.Window.Dispatcher.Invoke(
	[Action]{
		$SyncTable.Window.ShowInTaskbar = $true
		},
	"Normal"
)

Pause-Script