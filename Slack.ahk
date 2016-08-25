;Opens slack from tray if minimized, otherwise starts it
;Runs when doubleclickeed (supposed to be run from launchy by pressing "alt + space" and writing "Slack"

SetTitleMatchMode RegEx


IfWinExist .*Slack - QlikDev.*
{
    WinActivate, .*Slack - QlikDev.*
    exit
}
else{
    ;otherwise start it
    Run "C:\Users\ffn\AppData\Local\slack\Update.exe" --processStart slack.exe
    exit
}