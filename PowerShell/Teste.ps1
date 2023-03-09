$TruthA = @(0, 0, 0, 0, 1, 1, 1, 1)
$TruthB = @(0, 0, 1, 1, 0, 0, 1, 1)
$TruthC = @(0, 1, 0, 1, 0, 1, 0, 1)

$TruthTable = 0..7| foreach {
    [PSCustomObject]@{
        chkAuthor = $TruthA[$_]
        chkTags = $TruthB[$_]
        chkPage = $TruthC[$_]
        Case = $_
    }
}

$Case = ($TruthTable | Where-Object {$_.chkAuthor -eq $chkAuthor -and $_.chkTags -eq $chkTags -and $_.chkPage -eq $chkPage}).Case