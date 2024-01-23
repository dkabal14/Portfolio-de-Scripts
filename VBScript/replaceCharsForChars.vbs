'test







Function ReplaceDiacritics(strInp)
    Dim i, charCode
    Dim resultStr

    Dim dictDiacritics: Set dictDiacritics = CreateObject("Scripting.Dictionary")
    
    '===============================
    'Diacritics dictionary:
    '===============================
    dictDiacritics.Add Chr(39), Chr(39)   ' À
    dictDiacritics.Add Chr(192), "A"   ' À
    dictDiacritics.Add Chr(193), "A"   ' Á
    dictDiacritics.Add Chr(194), "A"   ' Â
    dictDiacritics.Add Chr(195), "A"   ' Ã
    dictDiacritics.Add Chr(196), "A"   ' Ä
    dictDiacritics.Add Chr(197), "A"   ' Å
    dictDiacritics.Add Chr(198), "AE"  ' Æ
    dictDiacritics.Add Chr(199), "C"   ' Ç
    dictDiacritics.Add Chr(200), "E"   ' È
    dictDiacritics.Add Chr(201), "E"   ' É
    dictDiacritics.Add Chr(202), "E"   ' Ê
    dictDiacritics.Add Chr(203), "E"   ' Ë
    dictDiacritics.Add Chr(204), "I"   ' Ì
    dictDiacritics.Add Chr(205), "I"   ' Í
    dictDiacritics.Add Chr(206), "I"   ' Î
    dictDiacritics.Add Chr(207), "I"   ' Ï
    dictDiacritics.Add Chr(208), "D"   ' Ð
    dictDiacritics.Add Chr(209), "N"   ' Ñ
    dictDiacritics.Add Chr(210), "O"   ' Ò
    dictDiacritics.Add Chr(211), "O"   ' Ó
    dictDiacritics.Add Chr(212), "O"   ' Ô
    dictDiacritics.Add Chr(213), "O"   ' Õ
    dictDiacritics.Add Chr(214), "O"   ' Ö
    dictDiacritics.Add Chr(215), "x"   ' ×
    dictDiacritics.Add Chr(216), "O"   ' Ø
    dictDiacritics.Add Chr(217), "U"   ' Ù
    dictDiacritics.Add Chr(218), "U"   ' Ú
    dictDiacritics.Add Chr(219), "U"   ' Û
    dictDiacritics.Add Chr(220), "U"   ' Ü
    dictDiacritics.Add Chr(221), "Y"   ' Ý
    dictDiacritics.Add Chr(222), "TH"  ' Þ
    dictDiacritics.Add Chr(223), "ss"  ' ß
    dictDiacritics.Add Chr(224), "a"   ' à
    dictDiacritics.Add Chr(225), "a"   ' á
    dictDiacritics.Add Chr(226), "a"   ' â
    dictDiacritics.Add Chr(227), "a"   ' ã
    dictDiacritics.Add Chr(228), "a"   ' ä
    dictDiacritics.Add Chr(229), "a"   ' å
    dictDiacritics.Add Chr(230), "ae"  ' æ
    dictDiacritics.Add Chr(231), "c"   ' ç
    dictDiacritics.Add Chr(232), "e"   ' è
    dictDiacritics.Add Chr(233), "e"   ' é
    dictDiacritics.Add Chr(234), "e"   ' ê
    dictDiacritics.Add Chr(235), "e"   ' ë
    dictDiacritics.Add Chr(236), "i"   ' ì
    dictDiacritics.Add Chr(237), "i"   ' í
    dictDiacritics.Add Chr(238), "i"   ' î
    dictDiacritics.Add Chr(239), "i"   ' ï
    dictDiacritics.Add Chr(240), "d"   ' ð
    dictDiacritics.Add Chr(241), "n"   ' ñ
    dictDiacritics.Add Chr(242), "o"   ' ò
    dictDiacritics.Add Chr(243), "o"   ' ó
    dictDiacritics.Add Chr(244), "o"   ' ô
    dictDiacritics.Add Chr(245), "o"   ' õ
    dictDiacritics.Add Chr(246), "o"   ' ö
    dictDiacritics.Add Chr(247), "÷"   ' ÷
    dictDiacritics.Add Chr(248), "o"   ' ø
    dictDiacritics.Add Chr(249), "u"   ' ù
    dictDiacritics.Add Chr(250), "u"   ' ú
    dictDiacritics.Add Chr(251), "u"   ' û
    dictDiacritics.Add Chr(252), "u"   ' ü
    dictDiacritics.Add Chr(253), "y"   ' ý
    dictDiacritics.Add Chr(254), "th"  ' þ
    dictDiacritics.Add Chr(255), "y"   ' ÿ

    resultStr = ""

    For i = 1 To Len(strInp)
        charCode = Asc(Mid(strInp, i, 1))
        wscript.echo Mid(strInp, i, 1)
        If not dictDiacritics.Exists(Chr(charCode)) Then
            'Replace diacritic character with its ASCII equivalent
            resultStr = resultStr & dictDiacritics(Chr(charCode))
        Else
            resultStr = resultStr & Mid(inputStr, i, 1)
        End If

    Next

    ReplaceDiacritics = resultStr
End Function

strVar1 = "É uma questão de lógica, e seus problemas se resolvem feito mágica"

Wscript.Echo ReplaceDiacritics(strVar1)