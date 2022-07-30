﻿{[Version]
    Signature = "$Windows NT$"
    
    [Strings]
    szOID_ENHANCED_KEY_USAGE = "2.5.29.37"
    szOID_DOCUMENT_ENCRYPTION = "1.3.6.1.4.1.311.80.1"
    
    [NewRequest]
    Subject = "cn=diegos.sonda@contratada.oi.net.br"
    MachineKeySet = false
    KeyLength = 2048
    KeySpec = AT_KEYEXCHANGE
    HashAlgorithm = Sha1
    Exportable = true
    RequestType = Cert
    KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE | CERT_DATA_ENCIPHERMENT_KEY_USAGE"
    ValidityPeriod = "Years"
    ValidityPeriodUnits = "1000"
    
    [Extensions]
    %szOID_ENHANCED_KEY_USAGE% = "{text}%szOID_DOCUMENT_ENCRYPTION%"
    } | Out-File -FilePath d:\DocumentEncryption.inf