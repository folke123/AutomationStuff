SetTitleMatchMode RegEx
SetBatchLines, -1
GroupAdd, Explorer, ahk_class CabinetWClass


;Open my git folder
#1::Run C:\gits

;Open git-bash in current folder
#c::OpenBashInCurrent()

;Close Outlook messages with CTRL + W and search with CTRL + F
#IfWinActive .* - Message .*
^f::Send, {f4}
^w::Send, !{f4}
#IfWinActive

;Close Outlook meetings with CTRL + W and search with CTRL + F
#IfWinActive .* - Meeting .*
^f::Send, {f4}
^w::Send, !{f4}
#IfWinActive

;Minimize slack to tray with CTRL + W
#IfWinActive .*Slack - QlikDev.*
;^w::Send, !{f4}
^w::Send, #{Down}
#IfWinActive

;Close Notepad with CTRL + W
#IfWinActive .* - Notepad.*
^w::Send, !{f4}
#IfWinActive

;Close command line or git-bash with CTRL + W
#IfWinActive, ahk_exe cmd.exe
^w::Send, !{f4}
#IfWinActive

;Close Outlook with CTRL + W and search with CTRL + F
#IfWinActive, ahk_class rctrl_renwnd32
^f::Send, {CtrlDown}e{CtrlUp}
^w::Send, !{f4}
#IfWinActive

;Create text file on desktop with CTRL + T if the desktop is active
#IfWinActive, ahk_class Progman
^t::CreateTextFileOnDesktop()
#IfWinActive

;Create text file on desktop with CTRL + T if the desktop is active
#IfWinActive, ahk_class WorkerW
^t::CreateTextFileOnDesktop()
#IfWinActive

;Create text file in current folder with CTRL + T
#IfWinActive, ahk_class CabinetWClass
^t::CreateTextFileInCurrent()
#IfWinActive

;Create text file in current folder with CTRL + T
#IfWinActive, ahk_class ExploreWClass") 
^t::CreateTextFileInCurrent()
#IfWinActive


CreateTextFileOnDesktop()
{
	DirPath := "C:\Users\ffn\Desktop\"
	Disambiguator := ;in case file exists, append "(<number>)" to file namne
	FileName := "New text file"
	FileExt := ".txt"

	FilePath := DirPath . FileName . Disambiguator . FileExt
	
	While FileExist(FilePath) ;Find suitable file name (i.e. one that does not exist already)
	{
		Index += 1
		Disambiguator := " (" . Index . ")"
		FilePath := DirPath . FileName . Disambiguator . FileExt
	}

	FileAppend,, %FilePath%

	While !FileExist(FilePath)
		Sleep 50
	Sleep 850 ;White till file icon is visible (sending F5 speeds things up but causes window to flicker)
	
	ControlFocus, SysListView321, A
	Send % FileName . Disambiguator . FileExt
	SendInput {F2}
}

CreateTextFileInCurrent()
{
	DirPath := ActiveFolderPath() . "\"
	Disambiguator := ;in case file exists, append "(<number>)" to file namne
	FileName := "New text file"
	FileExt := ".txt"

	FilePath := DirPath . FileName . Disambiguator . FileExt
	
	While FileExist(FilePath) ;Find suitable file name (i.e. one that does not exist already)
	{
		Index += 1
		Disambiguator := " (" . Index . ")"
		FilePath := DirPath . FileName . Disambiguator . FileExt
	}

	FileAppend,, %FilePath%  

	While !FileExist(FilePath)
		Sleep 50
	Sleep 850 ;White till file icon is visible (sending F5 speeds things up but causes window to flicker)
	
	ControlFocus, SysListView321, A
	Send % FileName . Disambiguator . FileExt
	SendInput {F2}
}

OpenBashInCurrent()
{
    WinGetTitle, Title, ahk_class CabinetWClass
    if (Title= ""){
      Run "C:\Program Files\Git\git-bash.exe"
    }
    else
    {
      Run C:\Users\ffn\Desktop\batfiles\bash.bat "%Title%"
    }
}


ActiveFolderPath()
{
   return PathCreateFromURL( ExplorerPath(WinExist("A")) )
}

ExplorerPath(_hwnd)
{
   for Item in ComObjCreate("Shell.Application").Windows
      if (Item.hwnd = _hwnd)
         return, Item.LocationURL
}

PathCreateFromURL( URL )
{
 VarSetCapacity( fPath, Sz := 2084, 0 )
 DllCall( "shlwapi\PathCreateFromUrl" ( A_IsUnicode ? "W" : "A" )
         , Str,URL, Str,fPath, UIntP,Sz, UInt,0 )
 return fPath
}




