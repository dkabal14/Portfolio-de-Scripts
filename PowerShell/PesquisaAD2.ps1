﻿$objeto = Get-ADComputer -Filter {Enabled -eq True} -Properties * -Server oi.corp.net -SearchScope Base -SearchBase 'OU=Computers,OU=Estacoes,DC=oi,DC=corp,DC=net' | Select-Object -Property Name