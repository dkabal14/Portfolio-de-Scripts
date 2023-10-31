function Test-ports {
    param(
        # Parametro Hostname
        [Parameter(Mandatory=$true)]
        [PSCustomObject]
        $hostnames,
        # Parametro Porta
        [Parameter(Mandatory=$true)]
        [string]
        $port
    )
        $testResult = Test-NetConnection -ComputerName $hostname -Port $port -InformationLevel Detailed

        $Data += Foreach ($item in $Matches)
        {
            #$links = $item.Value.Split('<a href="').Split('">(about)')[1]
            #$source = $item.Value.Split('<a href="').Split('">(Goodreads page)')[2]
            [PSCustomObject]@{
                # [System.Web.HttpUUtility] was used because some of the quotes had some special characters in it and HTML brings it like '&#39;'
                Quote = [System.Web.HttpUtility]::HtmlDecode(($Item.Groups.Where{$_.Name -like 'Quote'}).Value)
                Author = ($Item.Groups.Where{$_.Name -like 'Author'}).Value
                #About = $links
                About = ($Item.Groups.Where{$_.Name -like 'links'}).Value
                #Source = $source
                Source = ($Item.Groups.Where{$_.Name -like 'source'}).Value
                Tags = ($Item.Groups.Where{$_.Name -like 'Tags'}).Value -split ','
                QuotesURL = $NextUri
            }
        }
        
        return $testResult
}