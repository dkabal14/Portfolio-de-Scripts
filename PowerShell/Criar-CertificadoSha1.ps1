#Criado por Diego Rosário Sousa a partir do documento: https://kamranicus.com/wmf5-powershell-dsc-generating-encryption-certificate/
function Criar-CertificadoSha1 {
    [CmdletBinding()]
    param (
        [Parameter(mandatory=$false)]
        [string]
        $cerOutput="c:\SHA1.cer",
        [Parameter(mandatory=$true)]
        [string]
        $email,
        [Parameter(mandatory=$false)]
        [validateset("Years","Months","Days","Hours","Minutes","Seconds")]
        [string]
        $ValidityPeriod="Years",
        [Parameter(mandatory=$false)]
        [string]
        $ValidityPeriodUnity="10"
    )
    $infOutput="c:\DocumentEncryption.inf"

    $infInput='    [Version]
    Signature = "$Windows NT$"
    
    [Strings]
    szOID_ENHANCED_KEY_USAGE = "2.5.29.37"
    szOID_DOCUMENT_ENCRYPTION = "1.3.6.1.4.1.311.80.1"
    
    [NewRequest]
    Subject = "cn='+ $email + '"
    MachineKeySet = false
    KeyLength = 2048
    KeySpec = AT_KEYEXCHANGE
    HashAlgorithm = Sha1
    Exportable = true
    RequestType = Cert
    KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE | CERT_DATA_ENCIPHERMENT_KEY_USAGE"
    ValidityPeriod = ' + $ValidityPeriod + '
    ValidityPeriodUnits = ' + $ValidityPeriodUnity + '
    
    [Extensions]
    %szOID_ENHANCED_KEY_USAGE% = "{text}%szOID_DOCUMENT_ENCRYPTION%"'

    $infInput | Out-File -FilePath $infOutput
    
    certreq -new $infOutput $cerOutput
} 
Criar-CertificadoSha1 -cerOutput "c:\CertificadoSHA1.cer" -email "diegorosariosousa@gmail.com" -ValidityPeriod "Years" -ValidityPeriodUnity "10"