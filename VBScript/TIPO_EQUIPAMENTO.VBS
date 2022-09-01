strComputer = InputBox("Digite o nome do computador de destino")
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colChassis = objWMIService.ExecQuery _
    ("Select * from Win32_SystemEnclosure")
For Each objChassis in colChassis
    For  Each strChassisType in objChassis.ChassisTypes
        Select Case strChassisType
            Case 1
                MsgBox "Other"
            Case 2
                MsgBox "Unknown"
            Case 3
                MsgBox "Desktop"
            Case 4
                MsgBox "Low Profile Desktop"
            Case 5
                MsgBox "Pizza Box"
            Case 6
                MsgBox "Mini Tower"
            Case 7
                MsgBox "Tower"
            Case 8
                MsgBox "Portable"
            Case 9
                MsgBox "Laptop"
            Case 10
                MsgBox "Notebook"
            Case 11
                MsgBox "Handheld"
            Case 12
                MsgBox "Docking Station"
            Case 13
                MsgBox "All-in-One"
            Case 14
                MsgBox "Sub-Notebook"
            Case 15
                MsgBox "Space Saving"
            Case 16
                MsgBox "Lunch Box"
            Case 17
                MsgBox "Main System Chassis"
            Case 18
                MsgBox "Expansion Chassis"
            Case 19
                MsgBox "Sub-Chassis"
            Case 20
                MsgBox "Bus Expansion Chassis"
            Case 21
                MsgBox "Peripheral Chassis"
            Case 22
                MsgBox "Storage Chassis"
            Case 23
                MsgBox "Rack Mount Chassis"
            Case 24
                MsgBox "Sealed-Case PC"
            Case Else
                MsgBox "Unknown"
            End Select
    Next
Next