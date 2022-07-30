
#PERGUNTA DADOS
$RespostaNDT = Read-Host -Prompt 'Digite o nome do técnico que está fabricando a imagem'
$RespostaNDI = Read-Host -Prompt 'Digite o nome da imagem'
$RespostaMDM = Read-Host -Prompt 'Digite o Modelo do equipamento de referência'
$RespostaDDF = Read-Host -Prompt 'Digite a data de fabricação'
$RespostaVDI = Read-Host -Prompt 'Digite a versão da Imagem'
$RespostaD = Read-Host -Prompt 'Digite a descrições e/ou observações sobre a imagem'

#CRIAR NAMESPACE
$objNameSpace = [wmiclass]'root:__NameSpace'
$novoNameSpace = $objNameSpace.CreateInstance()
$novoNameSpace.Name = 'MicroInformatica'
$novoNameSpace.Put()
$objNameSpace = [wmiclass]'root\MicroInformatica:__NameSpace'
$novoNameSpace = $objNameSpace.CreateInstance()
$novoNameSpace.Name = 'SuporteNivel3'
$novoNameSpace.Put()


#CRIAR CLASSE
$novaClasse = New-Object System.Management.ManagementClass("root\MicroInformatica\SuporteNivel3",[string]::Empty,$null)
$novaClasse["__CLASS"] = "Imagem_N3"
$novaClasse.Qualifiers.Add("Static",$true)
$novaClasse.Properties.Add("NomeDoTecnico", [System.Management.CimType]::String, $false)
$novaClasse.Properties.Add("NomeDaImagem", [System.Management.CimType]::String, $false)
$novaClasse.Properties.Add("ModeloDaMaquina", [System.Management.CimType]::String, $false)
$novaClasse.Properties.Add("DataDeFabricacao", [System.Management.CimType]::String, $false)
$novaClasse.Properties.Add("VersaoDaImagem", [System.Management.CimType]::String, $false)
$novaClasse.Properties.Add("Descricao", [System.Management.CimType]::String, $false)
$novaClasse.Put()

#INSERE DADOS
$Imagem_N3 = [wmiclass]'root\MicroInformatica:Imagem_N3'
$Imagem_N3.Properties.Add('NomeDoTecnico', $RespostaNDT)
$Imagem_N3.Properties.Add('NomeDaImagem', $RespostaNDI)
$Imagem_N3.Properties.Add('ModeloDaMaquina', $RespostaMDM)
$Imagem_N3.Properties.Add('DataDeFabricacao', $RespostaDDF)
$Imagem_N3.Properties.Add('VersaoDaImagem', $RespostaVDI)
$Imagem_N3.Properties.Add('Descricao', $RespostaD)
$Imagem_N3.Put()