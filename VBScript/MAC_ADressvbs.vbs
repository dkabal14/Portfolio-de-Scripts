dim WMI:  set WMI = GetObject("winmgmts:\\OINOTE0067697\root\cimv2")
dim Nads: set Nads = WMI.ExecQuery("Select * from Win32_NetworkAdapter where physicaladapter=true") 
dim nad
for each Nad in Nads
    if not isnull(Nad.MACAddress) then Wscript.Echo Nad.description, Nad.MACAddress   
next 