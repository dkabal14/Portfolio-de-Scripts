#This is script was made referencing Emanuel Palm arcticle on https://pipe.how/invoke-webscrape/

function Scrape-Quotes {
    function Add-Index {
        param (
            [Parameter()]
            [psobject]
            $Collection
        )
        $result = @()
        foreach ($item in $Collection)
        {
            $result += $item | Select-Object -Property @{Name = "index"; Expression = {$Collection.IndexOf($item)}}, *
        }
        $result
    }

    $Creds = Get-Credential -Message "Logging in Quotes to Scrape" -Title "Quotes To Scrape"

    $BaseUri = "http://quotes.toscrape.com"
    $Site = Invoke-WebRequest -Uri $BaseUri

    # Clicking on the login link    
    $Action = $Site.Links | Where-Object {$_.outerHTML -like "*Login*"} | Select-Object -ExpandProperty href
    $LoginUri = $BaseUri + $Action
    #Creating the cookies to keep logged on the website
    $LoginPage = Invoke-WebRequest -Uri $LoginUri -SessionVariable "TempSession"

    $csrf_token = $LoginPage.InputFields | Where-Object {$_.name -eq "csrf_token"} | Select-Object -ExpandProperty value

    #Filling the input forms of the login
    #Names of the fields were taken from Website elements using Google Chrome's DevTools
    $AuthBody = @{
        username    = $Creds.UserName
        password    = $Creds.Password
        csrf_token  = $csrf_token
        Submit      = "Login"
    }

    #Logging into the website and sabing the logged session to $TempSession
    $LoggedUri = Invoke-WebRequest -Uri $LoginUri -Body $AuthBody -WebSession $TempSession -Method Post

    #Download all the quotes inside the $Data object, with a loop that checks if exists a "Next" link
    Do
    {
        if ($null -eq $NextUri)
        {
            $NextUri = $BaseUri
        }
        #Getting the page's content, now logged in with TempSession's cookie
        $PageContent = Invoke-RestMethod -Uri $NextUri -WebSession $TempSession

        # Sample used to build the pattern:
        # <span class="text" itemprop="text">“The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.”</span>
        # <span>by <small class="author" itemprop="author">Albert Einstein</small>
        # <a href="/author/Albert-Einstein">(about)</a> - <a href="http://goodreads.com/author/show/9810.Albert_Einstein">(Goodreads page)</a>
        # </span>
        # <div class="tags">
        #     Tags:
        #     <meta class="keywords" itemprop="keywords" content="change,deep-thoughts,thinking,world" /    >
        #==================================================================================================================
        # (?<quote>.*)   -> Extract Quotes to $matches table (Name = quote; Value = "Extracted Quote")
        # (?<author>.*)  -> Extract Authors to $matches table (Name = author; Value = "Extracted author")
        # (?<links>.*)   -> Extract the link that goes to all the quotes from this author to $matches table (Name = links; Value = "Extracted link")
        # (?<source>.*)  -> Extract the source of the quote to $matches table (Name = source; Value = "Extracted sources")
        # (?<tags>.*)    -> Extract the list of tags to $matches table (Name = tags; Value = "Extracted tags (needs split (','))")
        # \n.* to jump a line
        # (\n.*){X} to jump a line X times
        #"\" before round brackets are there for regex interpret the litteral character "(", the usual resonde would be for "(" be interpreted as the start of a class match
        
        $Pattern = '<span class="text" itemprop="text">(?<quote>.*)</span>\n.*<span>by <small class="author" itemprop="author">(?<author>.*)</small>\n.*<a href="(?<links>.*)">\(about\)</a> - <a href="(?<source>.*)">\(Goodreads page\)</a>(\n.*){4}<meta class="keywords" itemprop="keywords" content="(?<tags>.*)"'

        $Matches = ($PageContent | Select-String -Pattern $Pattern -AllMatches).Matches

        #Add info to $Data
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

        $objNext = (Invoke-WebRequest -Uri $NextUri -SessionVariable $TempSession).Links | Where-Object {$_.outerHTML -like "*Next*"}
        if ($null -ne $objNext)
        {
            $NextUri = $BaseUri + $objNext.href
        }
    }
    Until (
        $null -eq $objNext
    )

    #Adding a index property to the $Data object
    $iData = Add-Index -Collection $Data
    $iData
}

function filter-Quotes {
    param (
        [psobject]$qData,
        [string]$Author = "",
        [string]$Tags = "",
        [string]$Page = ""
    )
    # #Case 0 $ChkAuthor = $False, $ChkTags = $False, $ChkPages = $False
    # #Case 1 $ChkAuthor = $False, $ChkTags = $False, $ChkPages = $True
    # #Case 2 $ChkAuthor = $False, $ChkTags = $True, $ChkPages = $False
    # #Case 3 $ChkAuthor = $False, $ChkTags = $True, $ChkPages = $True
    # #Case 4 $ChkAuthor = $True, $ChkTags = $False, $ChkPages = $False
    # #Case 5 $ChkAuthor = $True, $ChkTags = $False, $ChkPages = $True
    # #Case 6 $ChkAuthor = $True, $ChkTags = $True, $ChkPages = $False
    # #Case 7 $ChkAuthor = $True, $ChkTags = $True, $ChkPages = $True
    # $TruthA = @(0, 0, 0, 0, 1, 1, 1, 1)
    # $TruthB = @(0, 0, 1, 1, 0, 0, 1, 1)
    # $TruthC = @(0, 1, 0, 1, 0, 1, 0, 1)

    $TruthTable = 0..7| foreach {
        [PSCustomObject]@{
            chkAuthor = $TruthA[$_]
            chkTags = $TruthB[$_]
            chkPage = $TruthC[$_]
            Case = $_
        }
    }

    if ("" -ne $Author)
    {
        $chkAuthor = 1
    } else {$chkAuthor = 0}
    if ("" -ne $Tags)
    {
        $chkTags = 1
    } else {$chkTags = 0}
    if ("" -ne $Page)
    {
        $chkPage = 1
    } else {$chkPage = 0}
    
    $Case = ($TruthTable | Where-Object {$_.chkAuthor -eq $chkAuthor -and $_.chkTags -eq $chkTags -and $_.chkPage -eq $chkPage}).Case
    "Selecionado caso $Case"
    switch ($Case) {
        #No Parameter
        0 {
            $iData
        }
        #Paramter Page
        1 {
            $iData.Where{$_.QuotesURL -like "*$Page*"}
        }
        #Parameter Tags
        2 {
            $iData.Where{$_.Tags -contains $Tags}
        }
        #Parameters Tags and Page
        3 {
            $iData.Where{$_.Tags -contains $Tags -and $_.QuotesURL -like "*$Page*"}
        }
        #Parameter Author
        4 {
            $iData.Where{$_.Author -like "*$Author*"}
        }
        #Parameters Author and Page
        5 {
            $iData.Where{$_.Author -like "*$Author*" -and $_.QuotesURL -like "*$Page*"}
        }
        #Parameters Author and Tags
        6 {
            $iData.Where{$_.Author -like "*$Author*" -and $_.Tags -contains $Tags}
        }
        #Parameters Author, Tags and Page
        7 {
            $iData.Where{$_.Author -like "*$Author*" -and $_.Tags -contains $Tags -and $_.QuotesURL -like "*$Page*"}
        }
    }
} 