SetTitleMatchMode RegEx
SetBatchLines, -1
GroupAdd, Explorer, ahk_class CabinetWClass



#1::Run C:\gits

#c::OpenBashInCurrent()

#IfWinActive .* - Message .*
^f::Send, {f4}
^w::Send, !{f4}
#IfWinActive

#IfWinActive .* - Meeting .*
^f::Send, {f4}
^w::Send, !{f4}
#IfWinActive

#IfWinActive .*Slack - QlikDev.*
^w::Send, !{f4}
#IfWinActive

#IfWinActive .* - Notepad.*
^w::Send, !{f4}
#IfWinActive

#IfWinActive, ahk_class rctrl_renwnd32
^f::Send, {CtrlDown}e{CtrlUp}
^w::Send, !{f4}
#IfWinActive

#IfWinActive, ahk_class Progman
^t::CreateTextFileOnDesktop()
#IfWinActive

#IfWinActive, ahk_class WorkerW
^t::CreateTextFileOnDesktop()
#IfWinActive


#IfWinActive, ahk_class CabinetWClass
^t::CreateTextFileInCurrent()
#IfWinActive

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




