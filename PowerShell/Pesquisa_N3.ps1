#PesquisaN3
$objImagem_N3 = [wmiclass]'\\OIDESK0065993\root\MicroInformatica:Imagem_N3'
wRITE-HOST '------------------------------------------'
$objImagem_N3.Properties | foreach { $_.Name + ": " + $_.Value }