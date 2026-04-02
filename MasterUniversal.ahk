; travoprost fridge

#SingleInstance force
#Requires AutoHotkey 1.1
#NoTrayIcon

;#Persistent
SetTimer, PatientInfo, 250

IniDelete, C:\AHK\CPD.ini,CPD,Name
IniDelete, C:\AHK\CPD.ini,CPD,ID
IniDelete, C:\AHK\CPD.ini,CPD,Address
IniDelete, C:\AHK\CPD.ini,CPD,Birthday
FileDelete, C:\AHK\CPD.ini

Loop, Files, C:\AHK\*.ahk
{
    FileName := A_LoopFileName
    if (RegExMatch(FileName, "(\d{7}[A-Za-z] )"))
    {
		FileDelete, C:\AHK\%FileName%
    }
}

Loop, Files, C:\AHK\*.txt
{
    FileName := A_LoopFileName
    if (RegExMatch(FileName, "(\d{7}[A-Za-z] )"))
    {
		FileDelete, C:\AHK\%FileName%
    }
}

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180
Sleep, 50
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180
FileDelete, C:\AHK\FridgeWarning.txt

FileAppend,, %A_Desktop%\Login.ahk
Sleep, 100
file := FileOpen(A_Desktop "\Login.ahk", "w")

DetectHiddenWindows, On
WinGet, List, List, ahk_class AutoHotkey

Loop %List%
  {
    WinGet, PID, PID, % "ahk_id " List%A_Index%

	WinGetTitle,Title,ahk_pid %PID%

	If Title contains %A_ScriptName%
	{}

	If Title not contains NovaStock.ahk,Reminder,%A_ScriptName%,ItemFinder
	{
	    If ( PID <> DllCall("GetCurrentProcessId") )
         PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index%
	}
  }

DetectHiddenWindows, Off

FileCreateDir, C:\AHK\

If !WinExist("ahk_exe poycclient.exe")
{
MsgBox ,, WPDS is not open, Open WPDS first and scan a scheme card prior to running Master Universal, 3
ExitApp
}

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe

; ---- Pastebin licence verification ----

If !ConnectedToInternet()
{
MsgBox, No Internet Connection
FileDelete, C:\AHK\Master Universal.ahk
ExitApp
}

WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("GET", "https://pastebin.com/raw/PrR6q4Dr", false)
WinHttp.Send()
KeyList := WinHttp.ResponseText

FoundPos := RegExMatch(KeyList, "devkey\:\:(.*)", devkey)
FoundPos := RegExMatch(KeyList, "userkey\:\:(.*)", userkey)
FoundPos := RegExMatch(KeyList, "pastekeylicences\:\:(.*)", pastekeylicences)
FoundPos := RegExMatch(KeyList, "pastekeymasteruniversal\:\:(.*)", pastekeymasteruniversal)
FoundPos := RegExMatch(KeyList, "pastekeyoosfill\:\:(.*)", pastekeyoosfill)
FoundPos := RegExMatch(KeyList, "pastekeystockme\:\:(.*)", pastekeystockme)
FoundPos := RegExMatch(KeyList, "pastekeycopyqr\:\:(.*)", pastekeycopyqr)
FoundPos := RegExMatch(KeyList, "pastekeyduedatechecker\:\:(.*)", pastekeyduedatechecker)

paramPrivatePasteReturn := "api_dev_key=" devkey1 "&api_user_key=" userkey1 "&api_option=show_paste&api_paste_key=" pastekeylicences1
strPrivatePasteReturn =https://pastebin.com/api/api_raw.php

Licences := url_tovarPrivatePasteReturn(strPrivatePasteReturn, paramPrivatePasteReturn)

UsernameNoSpace := RegExReplace(A_Username,"\s+","")
ComputerNameNoSpace := RegExReplace(A_ComputerName,"\s+","")

FoundPos := RegExMatch(Licences,UsernameNoSpace ComputerNameNoSpace " \*\|(.*)\|*",PharmacyCreds)

Number := 1

Loop, Parse, PharmacyCreds1 , |
{
PharmacyCredential%Number% := A_LoopField
Number++
}

PharmacyEmailwTitle := PharmacyCredential1
PharmacyEmailSubject := PharmacyCredential2
PharmacyClosingEmail := PharmacyCredential3
PharmacyPictureLink := PharmacyCredential4
PharmacyEmailLink := PharmacyCredential5
PharmacyUserName := PharmacyCredential6
PharmacyPassword := PharmacyCredential7
DoctorReg := PharmacyCredential8

Number :=
RegRead, UniqueID, HKEY_CURRENT_USER\Software\Classes\APPPID530217126725 , PID

If UniqueID is space
{
WinGetTitle, PharmacyName , ahk_exe poycclient.exe
FoundPos := RegExMatch(PharmacyName, "POYC Main Dispensing - (.*) \(LIVE", IsemSpizerija)
PharmacyName := IsemSpizerija1
PID := A_ComputerName
Transaction := "Unauthorized No Licence"

try
{
RagicCounterfeit(PharmacyName,PID,Transaction)
}
catch e
{
}

MsgBox, Unauthorized Access
FileDelete, C:\AHK\Master Universal.ahk
ExitApp
}

UniqueID .= A_UserName A_ComputerName
UniqueID := RegExReplace(UniqueID,"\s+","")

If Licences not contains %UniqueID%
{
WinGetTitle, PharmacyName , ahk_exe poycclient.exe
FoundPos := RegExMatch(PharmacyName, "POYC Main Dispensing - (.*) \(LIVE", IsemSpizerija)
PharmacyName := IsemSpizerija1
PID := A_ComputerName
Transaction := "Unauthorized Unmatching Licence"

try
{
RagicCounterfeit(PharmacyName,PID,Transaction)
}
catch e
{
}

MsgBox, Unauthorized Access
FileDelete, C:\AHK\Master Universal.ahk
ExitApp
}




Loop, Files, C:\AHK\*.ahk
{
    FileName := A_LoopFileName
    if (RegExMatch(FileName, "(\d{7}[A-Za-z] )"))
    {
		FileDelete, C:\AHK\%FileName%
    }
}

Loop, Files, C:\AHK\*.txt
{
    FileName := A_LoopFileName
    if (RegExMatch(FileName, "(\d{7}[A-Za-z] )"))
    {
		FileDelete, C:\AHK\%FileName%
    }
}

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180
FileDelete, C:\AHK\FridgeWarning.txt

FileAppend,, %A_Desktop%\Login.ahk
Sleep, 100
file := FileOpen(A_Desktop "\Login.ahk", "w")

DetectHiddenWindows, On 
WinGet, List, List, ahk_class AutoHotkey 

Loop %List% 
  { 
    WinGet, PID, PID, % "ahk_id " List%A_Index% 
	
	WinGetTitle,Title,ahk_pid %PID%
	
	If Title contains %A_ScriptName%
	{}
	
	If Title not contains NovaStock.ahk,Reminder,%A_ScriptName%,ItemFinder
	{
	    If ( PID <> DllCall("GetCurrentProcessId") ) 
         PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
	}
  }

DetectHiddenWindows, Off

FileCreateDir, C:\AHK\
FileCreateDir, %A_MyDocuments%\POYC OOS
FileCreateDir, %A_MyDocuments%\POYC LOGIN RECORDS
;FileCreateDir, %A_MyDocuments%\POYC COMPLETE TRANSACTION RECORDS
;FileCreateDir, %A_MyDocuments%\POYC DDA REGISTERS

; ---- Initialise UIA for direct table read/write (no clipboard/keyboard needed) ----
global g_pUIA := UIA_Setup()

If !WinExist("ahk_exe poycclient.exe")
{
MsgBox ,, WPDS is not open, Open WPDS first and scan a scheme card prior to running Master Universal, 3
ExitApp
}

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe

PharmacyEmailwTitle := "PharmacyCredential1"
PharmacyEmailSubject := "PharmacyCredential2"
PharmacyClosingEmail := "PharmacyCredential3"
PharmacyPictureLink := "PharmacyCredential4"
PharmacyEmailLink := "PharmacyCredential5"
PharmacyUserName := "PharmacyCredential6"
PharmacyPassword := "PharmacyCredential7"
DoctorReg := ""

Number :=
RegRead, UniqueID, HKEY_CURRENT_USER\Software\Classes\APPPID530217126725 , PID

If UniqueID is space
{
WinGetTitle, PharmacyName , ahk_exe poycclient.exe
FoundPos := RegExMatch(PharmacyName, "POYC Main Dispensing - (.*) \(LIVE", IsemSpizerija)
PharmacyName := IsemSpizerija1
PID := A_ComputerName
Transaction := "Unauthorized No Licence"

try
{
RagicCounterfeit(PharmacyName,PID,Transaction)
}
catch e
{
}

MsgBox, Unauthorized Access
FileDelete, C:\AHK\Master Universal.ahk
ExitApp
}

;if FileExist("C:\AHK\Patient Due Date Checker.ahk")
;GoTo, CopyQRLabel

FileDelete, C:\AHK\Ragic.ahk

IniRead, DueDateIniExist, C:\AHK\DueDateSettings.ini, DueDateSetting, DueDate
{
If DueDateIniExist = ERROR
IniWrite, 0, C:\AHK\DueDateSettings.ini, DueDateSetting, DueDate
}

IniRead, SkipRegNumber, C:\AHK\RegNumberSettings.ini, RegNumberSettings, RegNos
{
If SkipRegNumber = ERROR
IniWrite, 0, C:\AHK\RegNumberSettings.ini, RegNumberSettings, RegNos
}

IniRead, SkipImage, C:\AHK\ImageSettings.ini, ImageSettings, SkipImageVal
{
If SkipImage = ERROR
IniWrite, 1, C:\AHK\ImageSettings.ini, ImageSettings, SkipImageVal
}

IniRead, NonAutoFill, C:\AHK\NonAutoFillSettings.ini, NonAutoFillSettings, SkipAutoFill
{
If NonAutoFill = ERROR
IniWrite, 0, C:\AHK\NonAutoFillSettings.ini, NonAutoFillSettings, SkipAutoFill
}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
{
If LabelPrint = ERROR
IniWrite, 0, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
}

IniRead, CombineNameandDate, C:\AHK\CombineNameandDateSettings.ini, CombineNameandDateSettings, CombineNameandDate
{
If CombineNameandDate = ERROR
IniWrite, 0, C:\AHK\CombineNameandDateSettings.ini, CombineNameandDateSettings, CombineNameandDate
}

IniRead, NumberOfOutOfStockLabels, C:\AHK\NumberOfOutOfStockLabelsSettings.ini, NumberOfOutOfStockLabelsSettings, NumberOfOutOfStockLabels
{
If NumberOfOutOfStockLabels = ERROR
IniWrite, 1, C:\AHK\NumberOfOutOfStockLabelsSettings.ini, NumberOfOutOfStockLabelsSettings, NumberOfOutOfStockLabels
}

IniRead, SkipDOB, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
{
If SkipDOB = ERROR
IniWrite, 1, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
}

IniRead, SkipDate, C:\AHK\SkipDateSettings.ini, SkipDateSettings, SkipDate
{
If SkipDate = ERROR
IniWrite, 0, C:\AHK\SkipDateSettings.ini, SkipDateSettings, SkipDate
}

IniRead, SkipDDALabel, C:\AHK\SkipDDALabelSettings.ini, SkipDDALabelSettings, SkipDDALabel
{
If SkipDDALabel = ERROR
IniWrite, 0, C:\AHK\SkipDDALabelSettings.ini, SkipDDALabelSettings, SkipDDALabel
}

; ---- One-time QR Code preference (saved, only asked once) ----
IniRead, UseQRCode, C:\AHK\QRCodeSettings.ini, QRCodeSettings, UseQRCode
If (UseQRCode = "ERROR" || UseQRCode = "") {
    MsgBox, 262180, QR Code Feature, Do you use the QR Code / Birthday Image feature?`n`nIf you select No the program will run significantly faster each time.`n`nThis will only be asked once. You can change it later`nby editing C:\AHK\QRCodeSettings.ini
    IfMsgBox Yes
        IniWrite, 1, C:\AHK\QRCodeSettings.ini, QRCodeSettings, UseQRCode
    IfMsgBox No
        IniWrite, 0, C:\AHK\QRCodeSettings.ini, QRCodeSettings, UseQRCode
    IniRead, UseQRCode, C:\AHK\QRCodeSettings.ini, QRCodeSettings, UseQRCode
}

LoginScript =
(
#SingleInstance Force
#Requires AutoHotkey 1.1
winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
WinClose , Invalid Entry
WinGet, ActiveControlList, ControlList, ahk_exe poycclient.exe
Loop, Parse, ActiveControlList , ``n
{
ControlGetText, ControlText, `%A_Loopfield`%, ahk_exe poycclient.exe
ControlListData .= ControlText "(" A_LoopField ")" "``n"

If ControlText contains Scheme Card
SchemeButton := A_LoopField

If ControlText contains Birth
DOBButton := A_LoopField

If ControlText contains Cancel
CancelAddress := A_LoopField

If ControlText contains toolstrip1
ToolStripAddress := A_LoopField

If ControlText contains /
sysdate := A_LoopField
}

ControlGetPos , CX, CY, CW, CH, `%CancelAddress`%, ahk_exe poycclient.exe
ControlGetPos , TX, TY, TW, TH, `%ToolStripAddress`%, ahk_exe poycclient.exe

CAY := (TH/2.978) ; apply entitlement Y coordinates Y must be around 93
CAX := (TW/2.11) ; apply entitlement X coordinates X must be around 26

Sleep, 50
winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
WinClose , Invalid Entry
SetControlDelay -1
ControlClick , `%ToolStripAddress`%, ahk_exe poycclient.exe,,,, X`%CAX`% Y`%CAY`% ; Cancel All

Sleep, 75

IDEDIT := RegExReplace(SchemeButton, "BUTTON","EDIT")
IDEDIT := RegExReplace(IDEDIT, "112","111")

InputBox, wordsearch, Word Search, , , 396, 125, 1036, 353, , ,

winminimize, ahk_exe poycclient.exe

	if ErrorLevel ;if inputbox is closed
	return
	
	else

WinClose , Invalid Entry
Sleep, 50
WinClose , Invalid Entry
Loop, Read, `%A_MyDocuments`%\POYC LOGIN RECORDS\Login Records.ini
{
If InStr(A_LoopReadLine, "[")
If InStr(A_LoopReadLine, "]")
If InStr(A_LoopReadLine, wordsearch)
MsgBox, 4, Search Patient, `%A_LoopReadLine`%
	
	IfMsgBox Yes
	{
	WinClose , Invalid Entry
	Sleep, 75
	NameSurnameID := A_LoopReadLine
	FoundPosZ := RegExMatch(NameSurnameID, "\s+(\d{7}\w+)]", IDOnly)
	
	winactivate, ahk_exe poycclient.exe
	winwaitactive, ahk_exe poycclient.exe
	WinClose , Invalid Entry
	
	SetControlDelay -1
	ControlClick, `%IDEDIT`%,,,,, NA
	SendInput, `%IDOnly1`%{Enter}
	Break
	}
	

	
	IfMsgBox No
	{
	}

}	
Return
)

file := FileOpen(A_Desktop "\Login.ahk", "w")
Sleep, 100

Loop,
{
FileRead, TestLogin, %A_Desktop%\Login.ahk

If (TestLogin = "")
{
file := FileOpen(A_Desktop "\Login.ahk", "a")
file.write(LoginScript)
}

If (TestLogin != "")
Break
}

GetPatientDueDateChecker:
;FileDelete, C:\AHK\Patient Due Date Checker.ahk
;paramPrivatePasteReturn := "api_dev_key=" devkey1 "&api_user_key=" userkey1 "&api_option=show_paste&api_paste_key=" pastekeyduedatechecker1
;strPrivatePasteReturn =https://pastebin.com/api/api_raw.php
;SoftPatientDueDateChecker := url_tovarPrivatePasteReturn(strPrivatePasteReturn, paramPrivatePasteReturn)
;FileAppend, %SoftPatientDueDateChecker%, C:\AHK\Patient Due Date Checker.ahk
;Sleep, 50
;FileRead, NewPatientDueDateChecker, C:\AHK\Patient Due Date Checker.ahk
;If NewPatientDueDateChecker is Space
;GoTo, GetPatientDueDateChecker

CopyQRLabel:
;if FileExist("CopyQR.ahk")
;GoTo, StockMeLabel

GetCopyQR:
;FileDelete, C:\AHK\CopyQR.ahk
;paramPrivatePasteReturn := "api_dev_key=" devkey1 "&api_user_key=" userkey1 "&api_option=show_paste&api_paste_key=" pastekeycopyqr1
;strPrivatePasteReturn =https://pastebin.com/api/api_raw.php
;SoftCopyQR := url_tovarPrivatePasteReturn(strPrivatePasteReturn, paramPrivatePasteReturn)
;FileAppend, %SoftCopyQR%, C:\AHK\CopyQR.ahk
;Sleep, 200
;FileCreateShortcut, C:\AHK\CopyQR.ahk, %A_Desktop%\CopyQR.lnk ,,, Copies QR Codes,,,,
;FileRead, NewQR, C:\AHK\CopyQR.ahk
;If NewQR is Space
;GoTo, GetCopyQR

StockMeLabel:
;if FileExist("StockMe.ahk")
;GoTo, MUniversal

GetSoftStockMe:
;FileDelete, C:\AHK\StockMe.ahk
;paramPrivatePasteReturn := "api_dev_key=" devkey1 "&api_user_key=" userkey1 "&api_option=show_paste&api_paste_key=" pastekeystockme1
;strPrivatePasteReturn =https://pastebin.com/api/api_raw.php
;SoftStockMe := url_tovarPrivatePasteReturn(strPrivatePasteReturn, paramPrivatePasteReturn)
;FileAppend, %SoftStockMe%, C:\AHK\StockMe.ahk
;Sleep, 200
;FileCreateShortcut, C:\AHK\StockMe.ahk, %A_Desktop%\StockMe.lnk ,,, Order POYC Stationery,,,,
;FileRead, New, C:\AHK\StockMe.ahk
;If New is Space
;GoTo, GetSoftStockMe

Limiter := 1

MUniversal:
;get coordinates
winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
WinGet, ActiveControlList, ControlList, ahk_exe poycclient.exe

Loop, Parse, ActiveControlList , `n
{
ControlGetText, ControlText, %A_Loopfield%, ahk_exe poycclient.exe
ControlListData .= ControlText "(" A_LoopField ")" "`n"

If ControlText contains Apply Selected
ApplySelectedAddress := A_LoopField

If ControlText contains Doctor Registration Line Entry
DrRegLineEntryAddress := A_LoopField

If ControlText contains Doctor Reg No
DrRegNoAddress := A_LoopField

If ControlText contains Cancel
CancelAddress := A_LoopField

If ControlText contains toolstrip1
ToolStripAddress := A_LoopField

If ControlText contains Code
CodeAddress := A_LoopField

If ControlText contains Description
DescriptionAddress := A_LoopField

If A_LoopField contains WindowsForms10.Window.8.app
If A_LoopField contains ad113
{
TransactionAddress := A_LoopField
PreceedingTransactionBlock :=
}

If A_LoopField contains WindowsForms10.Window.8.app
If A_LoopField contains ad114
{
TransactionAddress := A_LoopField
PreceedingTransactionBlock :=
}

If ControlText contains This Transaction
PreceedingTransactionBlock := A_LoopField

If PreceedingParticularsBlock is not space
{
Particulars := A_LoopField
PreceedingParticularsBlock :=
}

If ControlText contains Particulars
PreceedingParticularsBlock := A_LoopField

If A_LoopField contains SysTabControl32
entschtool := A_LoopField
}

;find coordinates
ControlGetPos , DRX, DRY, DRW, DRH, %DrRegNoAddress%, ahk_exe poycclient.exe
ControlGetPos , CX, CY, CW, CH, %CancelAddress%, ahk_exe poycclient.exe
ControlGetPos , TX, TY, TW, TH, %ToolStripAddress%, ahk_exe poycclient.exe
ControlGetPos , CoX, CoY, CoW, CoH, %CodeAddress%, ahk_exe poycclient.exe
ControlGetPos , DeX, DeY, DeW, DeH, %DescriptionAddress%, ahk_exe poycclient.exe
ControlGetPos , TrX, TrY, TrW, TrH, %TransactionAddress%, ahk_exe poycclient.exe
ControlGetPos , PaX, PaY, PaW, PaH, %Particulars%, ahk_exe poycclient.exe
ControlGetPos , ESX, ESY, ESW, ESH, %entschtool%, ahk_exe poycclient.exe
ControlGetPos , DRGLEX, DRGLEY, DRGLEW, DRGLEH, %DrRegLineEntryAddress%, ahk_exe poycclient.exe
ControlGetPos , ApplySelectAddressX, ApplySelectAddressY, ApplySelectAddressW, ApplySelectAddressH, %ApplySelectedAddress%, ahk_exe poycclient.exe

TTY := (TY - CY)/3.22 ; transaction table Y coordinates needs to be around 26 because the home pc button has height of 52
TTX := (Dex-CoX)/15 ; transaction table X coordinates Needs to be around 18 because the home pc has button width of 36
MLY := ((TY - CY)/1.29) ; medicine line Y coordinates
MLX := ((DeX - CoX)*2.43454) ; medicine line X coordinates
AEY := (TH/7.69) ; apply entitlement Y coordinates Y must be around 36
AEX := (TW/2.11) ; apply entitlement X coordinates X must be around 26
CAY := (TH/2.978) ; apply entitlement Y coordinates Y must be around 93
CAX := (TW/2.11) ; apply entitlement X coordinates X must be around 26
PoY := (TH/2.146) ; post Y coordinates
PoX := (TW/2.11) ; post X coordinates
PaY := (CoY-DRY)/2.25 ; post Y coordinates must be 12
PaX := (CoX-DRX)/3.61 ; post X coordinates X must be 18
SchY := ESY*0.188524
SchX := ESX*0.4562334
EntY := ESY*0.188524
EntX := ESX*0.016949
TransX := SchX*4.0787255
2GUIW := TrX + TrW - 20

Global DRGLEX
Global DRGLEY
Global DRGLEW
Global DRGLEH
global DRX
global DRY
global CX
global CY
global TX
global TY
global CoX
global CoY
global DeX
global DeY
global TrX
global TrY
global PaX
global PaY
global DRW
global DRH
global CW
global CH
global TW
global TH
global CoW
global CoH
global DeW
global DeH
global TrW
global TrH
global PaW
global PaH
global DrRegNoAddress
global CancelAddress
global ToolStripAddress
global CodeAddress
global DescriptionAddress
global TransactionAddress
global Particulars
global SchY
global SchX
global EntY
global EntX

/*

SetControlDelay -1
ControlClick , %entschtool%, ahk_exe poycclient.exe,,,, X%SchX% Y%SchY% ; Select Schedules
Sleep, 25

CoordMode, Mouse , Client
Click, 414,82
Sleep, 25

Loop,
{
Clipboard :=
SendInput {Ctrl Down}{c Down}
Sleep 25
SendInput {c Up}{Ctrl Up}
ClipWait, 2

if Clipboard = ""
Sleep, 100

If Clipboard != ""
Break
}

FileDelete, ExpiredPermit.txt

CoordMode, Mouse , Window

SetControlDelay -1
ControlClick , %entschtool%, ahk_exe poycclient.exe,,,, X%EntX% Y%EntY% ; Select Entitlement
Sleep, 25

  Date += 52, Days
  FormatTime, expdatealertlimit, %Date%, yyyyMMdd
  
p := 1, m := "", ExpiredPermitList := ""
while p := RegExMatch(Clipboard, "\s+(.+)\s+\d{2}\/\d{2}\/\d{4}\s+\d{2}\:\d{2}\:\d{2}\s+(\d{2}\/\d{2}\/\d{4})\s+\d{2}\:\d{2}\:\d{2}", m, p + StrLen(m))
    {
	;match%A_Index% := m1 " " m2
	;NumberOfExp := A_Index
	
	expdate := RegExReplace(m2,"(\d{2})\/(\d{2})\/(\d{4})","$3$2$1")
	
	datefrom := expdatealertlimit
	distance := dateto := expdate
	distance -= datefrom, days
		
	If (distance < 52)
	ExpiredPermitList .= m1 " " m2 "`n"
	}

ExpiredPermitList := RegExReplace(ExpiredPermitList, "\n\s*$(?!\n)", "")


If (ExpiredPermitList != "")
{
ExpiredPermitList2 .= "EXPIRED PERMITS:`n" ExpiredPermitList

MsgBox, 4148, Expired Permit, An expired permit has been detected.`nDo you wish to print a warning label?
	
	IfMsgBox Yes
	{
	FileAppend, %ExpiredPermitList2%, ExpiredPermit.txt

	Loop,
	{
	If !FileExist("ExpiredPermit.txt")
	{
	Sleep, 100
	}
	
	If FileExist("ExpiredPermit.txt")
	Break
	}
	
RunWait print "ExpiredPermit.txt",, HIDE
FileDelete, ExpiredPermit.txt
	}
	}
*/


DATEPRINTSECTION =
(
CollectionDate:

IniRead, DueDateOffset, C:\AHK\DueDateSettings.ini, DueDateSetting, DueDate

If DueDateOffset = x
{
HolidayDeduct := -1

FileDelete, C:\AHK\Collection Date.txt
FileDelete, C:\AHK\CollectionDate.ini

  Date += 55, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy 
datestring = `%nDate`%
StringSplit, d, datestring, /
date := d3 d1 d2

Loop,
{
FormatTime, day_of_Week, `%date`%, dddd
gurnata = `%day_of_Week`%
var1 = Sunday
var2 = Monday
var3 = Saturday
If gurnata = `%var1`%
{
  Date += -3, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
  }
If gurnata = `%var2`%
{
  Date += 1, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
}
If gurnata = `%var3`%
{
  Date += -2, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
}
If checkholdate contains 0101,1002,1903,3103,0105,0706,2906,1508,0809,2109,0812,1312,2512
{
  Date += `%HolidayDeduct`%, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
  HolidayDeduct -= 1
}
Else
{
FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
Break
}
}

}

If DueDateOffset != x
{
RecalibratedDate := 56 - DueDateOffset

FileDelete, C:\AHK\Collection Date.txt

  Date += `%RecalibratedDate`%, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy 
datestring = `%nDate`%
StringSplit, d, datestring, /
date := d3 d1 d2

FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
}

FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
FileAppend, Next Due: `%nDate`%, C:\AHK\Collection Date.txt
WaitForFileReady("C:\AHK\Collection Date.txt", 1000)

FileRead, nDate, C:\AHK\Collection Date.txt
	
If nDate is space
{
GoTo, CollectionDate	
Sleep, 100
}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
IniRead, CombineNameandDate, C:\AHK\CombineNameandDateSettings.ini, CombineNameandDateSettings, CombineNameandDate
If CombineNameandDate = 1
GoTo, SkipPrintDate

IniRead, SkipDate, C:\AHK\SkipDateSettings.ini, SkipDateSettings, SkipDate
If SkipDate = 1
GoTo, SkipPrintDate

if !SafePrintTextFile("C:\AHK\Collection Date.txt")
    LogFailure("Print failed: C:\AHK\Collection Date.txt")
FileDelete, C:\AHK\Collection Date.txt
SkipPrintDate:
}
)

DDACHECK =
(
DDARxCheck:
FileDelete, C:\AHK\DDAPrint.txt
Sleep, 100
FileAppend, `%Details`%, C:\AHK\DDAPrint.txt
WaitForFileReady("C:\AHK\DDAPrint.txt", 1000)

FileRead, DDArx, C:\AHK\DDAPrint.txt
	
If DDArx is space
{
GoTo, DDARxCheck	
Sleep, 100
}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
IniRead, SkipDDALabel, C:\AHK\SkipDDALabelSettings.ini, SkipDDALabelSettings, SkipDDALabel

If SkipDDALabel = 0
If LabelPrint = 0
{
if !SafePrintTextFile("C:\AHK\DDAPrint.txt")
    LogFailure("Print failed: C:\AHK\DDAPrint.txt")
}
FileDelete, C:\AHK\DDAPrint.txt
}

SkipDDABecause02:
}
)


EXECUTIONERPT1 =
(
AutoBdayQRLabel:
Gui, Submit, NoHide
IniWrite, `%AutoBdayQR`%, C:\AHK\Settings.ini, Settings, AutoPrintBday
Return

QRCODE:
If FileExist("C:\AHK\FinalImage.png")
{
RunWait, mspaint /p C:\AHK\FinalImage.png, , Hide 
Sleep, 100
FileDelete C:\AHK\vcc.png
FileDelete C:\AHK\CaptionText.png
FileDelete C:\AHK\FinalImage.png
}
Return

RemovefromOOSlist:
IniDelete, C:\AHK\OOSRecords.ini, `%patientdata2`% `%patientdata1`%, `%RecordFiltered1`%
Return
)
	
OOSLOADSECTION =
(
FileDelete, C:\AHK\OOSLoad.ahk
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("POST", "https://pastebin.com/api/api_raw.php")
	WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    paramPrivatePasteReturn := "api_dev_key=%devkey1%&api_user_key=%userkey1%&api_option=show_paste&api_paste_key=%pastekeyoosfill1%"
	WebRequest.Send(paramPrivatePasteReturn)

	OOSLoad := WebRequest.ResponseText
FileAppend, `%OOSLoad`%, C:\AHK\OOSLoad.ahk
Sleep, 50
FileRead, OOSLoadChecker, C:\AHK\OOSLoad.ahk
If OOSLoadChecker is Space
GoTo, OOSLoad

Run, C:\AHK\OOSLoad.ahk
)

GUISCRIPTS =
(
CheckComment(){

		IniRead, IDComment, C:\AHK\CPD.ini, CPD, Name
		
		API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="
		
		ColTransRef := "where=1000563,eq,"
		FilterTransRef := IDComment
		
		WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		WinHttp.Open("GET", "https://www.ragic.com/masteruniversal1/masteruniversal/41/?" ColTransRef FilterTransRef "&api", false)
		WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
		WinHttp.Send(Data)
		res := WinHttp.ResponseText
		
		Loop, Parse, res, ``n
		{
		FdCommentPos := RegExMatch(A_Loopfield, "\""COMMENT\""\: \""(.*)?\""", Comment)
		
		If Comment1 !=
		CommentVar := Comment1
		}

		Return CommentVar
}

Gui, -Caption +LastFound +AlwaysOnTop
Gui,Font, s6,
Gui, Add, Button, x0 y0 w55 h20 gBack, BACK
Gui,Font,
Gui, Add, Button, x0 y22 w55 h40 gCancelAll, CANCEL ALL
Gui, Add, Button, x0 y64 w55 h55 vPost gPost, POST
Gui, Add, Button, x0 y122 w55 h55 gPostwoLabel, POST w/o LABEL
Gui,Font, s6,
Gui, Add, Button, x0 y224 w28 h20 gQRCODE, BDAY QR
Gui, Add, Button, x28 y224 w28 h20 gCollectionDateClosedLoop, DATE
Gui,Font, s5,
Gui, Add, Button, x0 y246 w28 h20 gNamePrint,NAME
Gui, Add, Button, x28 y246 w28 h20 gFridgeManualPrint,FRIJ
Gui,Font, s6,
Gui, Add, Button, x0 y180 w28 h20 gDDAFILTER, DDA
Gui, Add, Button, x28 y180 w28 h20 gOOSLOAD vOOSbutton, OOS
Gui, Add, Button, x0 y202 w28 h20 gWARFARINFILTER, WAR
Gui, Add, Button, x28 y202 w28 h20 gINSULINFILTER, INS
Gui, Add, Button, x0 y268 w28 h20 gDrugInteractions, RPT
Gui, Add, Button, x28 y268 w28 h20 gReverse, RET
Gui, Add, Button, x0 y290 w28 h20 gNote, NOTE
Gui, Add, Button, x28 y290 w28 h20 gDue, DUE

IniRead, Check1, C:\AHK\Settings.ini, Settings, AutoPrintBday

Gui, Add, CheckBox, x0 y310 w55 h35 Checked`%Check1`% vAutoBdayQR gAutoBdayQRlabel, AUTO BDAY QR?
Gui, Show, x%TX% y%TY% w55, Posting
IniRead, IsThereOOS, C:\AHK\OOSRecords.ini, %patientdata2% %patientdata1%

REGADJ := %DRGLEY% + 60


If (IsThereOOS = "")
GuiControl,Disable, OOSbutton

WinActivate, Order items

;Run, C:\AHK\Patient Due Date Checker.ahk
OnMessage(0x200, "Tooltips")

IniRead, IDComment, C:\AHK\CPD.ini, CPD, Name
IniRead, ActiveComment, C:\AHK\Notes.ini, `%IDComment`%, Comment, 0

If ActiveComment = 0
ActiveComment :=

CommentVar := CheckComment()

If ActiveComment =
ActiveComment := CommentVar

If ActiveComment !=
ActiveComment .= "``n" CommentVar

If ActiveComment != 0
If ActiveComment !=
MsgBox, 262144, Comment, `%ActiveComment`%

Clipboard :=
;IniDelete, C:\AHK\CPD.ini,CPD,Name
;IniDelete, C:\AHK\CPD.ini,CPD,ID
;IniDelete, C:\AHK\CPD.ini,CPD,Address
;IniDelete, C:\AHK\CPD.ini,CPD,Birthday
;FileDelete, C:\AHK\CPD.ini
Return

Due:
FunctionDue()
Return

FunctionDue(){
WinClose, ahk_class Notepad
Sleep, 50

file := FileOpen(A_MyDocuments "\POYC COMPLETE TRANSACTION RECORDS\Due.txt", "w") 
file.write()
file.close()

WinClose, ahk_class Notepad
Sleep, 50

While FileExist( A_MyDocuments "\POYC COMPLETE TRANSACTION RECORDS\Due.txt" )
{
  Sleep 50
  FileDelete, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Due.txt
}

Sleep, 100
file := FileOpen(A_MyDocuments "\POYC COMPLETE TRANSACTION RECORDS\Due.txt", "w") 
file.write()
file.close()
Sleep, 100

FileRead, LongCompleteRecords, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Complete Records.txt

Loop, Parse, LongCompleteRecords, ``n
{
FP := RegExMatch(A_Loopfield,"(.*)?(?:(\d{2})\/(\w+)\/(\d{4}))", part)

If FP != 0
CompleteRecords .= A_Loopfield "``n"
}

CompleteRecords := RegExReplace(CompleteRecords, "January",01)
CompleteRecords := RegExReplace(CompleteRecords, "February",02)
CompleteRecords := RegExReplace(CompleteRecords, "March",03)
CompleteRecords := RegExReplace(CompleteRecords, "April",04)
CompleteRecords := RegExReplace(CompleteRecords, "May",05)
CompleteRecords := RegExReplace(CompleteRecords, "June",06)
CompleteRecords := RegExReplace(CompleteRecords, "July",07)
CompleteRecords := RegExReplace(CompleteRecords, "August",08)
CompleteRecords := RegExReplace(CompleteRecords, "September",09)
CompleteRecords := RegExReplace(CompleteRecords, "October",10)
CompleteRecords := RegExReplace(CompleteRecords, "November",11)
CompleteRecords := RegExReplace(CompleteRecords, "December",12)



Loop, Parse, CompleteRecords, ``n
{
FP := RegExMatch(A_Loopfield,"(.*)?(?:(\d{2})\/(\d{2})\/(\d{4}))", part)

ModifiedRecords .= part1 part4 part3 part2 "``n"
}



Loop, Parse, ModifiedRecords, ``n
{
FP := RegExMatch(A_Loopfield,"(\d{8})", part)
FormatTime, dateto , dateto, yyyyMMdd

datefrom := part1

distance := dateto := dateto

distance -= datefrom, days

	If distance <= 27
		{
			FP := RegExMatch(A_Loopfield,"(.*)?(?:\d{8})", part)
			
			FULL := RegExMatch(part1,"\s+F\s+", cntfull)
		
			if FULL != 0
			{
			done := RegExReplace(A_Loopfield,"\[","")
			done := RegExReplace(done,"\s+F\s+.*","")
			LatestWork .= done ","
			}
		}		
}




Loop, Parse, ModifiedRecords, ``n
{
FP := RegExMatch(A_Loopfield,"(\d{8})", part)
FormatTime, dateto , dateto, yyyyMMdd

datefrom := part1

distance := dateto := dateto

distance -= datefrom, days

	If distance > 27
	If distance < 90
		{
		
		FP := RegExMatch(A_Loopfield,"(.*)?(?:\d{8})", part)
			
			FULL := RegExMatch(part1,"\s+F\s+", cntfull)
			
				if A_Loopfield not contains `%LatestWork`%
				if FULL != 0
					{
					part1 := RegExReplace(part1,"\[","")
					part1 := RegExReplace(part1,"\s+F\s+","")
					DueRecords .= part1 ": " distance " days ago ``n"
					}
		}
		

}



;FileAppend, `%DueRecords`%, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Due.txt
Sleep, 100

While !FileExist( A_MyDocuments "\POYC COMPLETE TRANSACTION RECORDS\Due.txt" )
  Sleep 50

Run, NOTEPAD.exe `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Due.txt
Return
}

CheckCommentCreateOrUpdate(Message){
		
		IniRead, IDComment, C:\AHK\CPD.ini, CPD, Name

		API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="

		ColTransRef := "where=1000563,eq,"
		FilterTransRef := IDComment

		WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		WinHttp.Open("GET", "https://www.ragic.com/masteruniversal1/masteruniversal/41/?" ColTransRef FilterTransRef "&api", false)
		WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
		WinHttp.Send(Data)
		res := WinHttp.ResponseText

		Loop, Parse, res, ``n
		{
		FdCommentPos := RegExMatch(A_Loopfield, "\""COMMENT\""\: \""(.*)?\""", Comment)
		FdRagicIDPos := RegExMatch(A_Loopfield, "\""_ragicId\""\: (.*)?\,", RagicID)

		If Comment1 !=
		CommentVar := Comment1
		
		If RagicID1 !=
		queryRagicIdExist := RagicID1
		}
		

		If res = {}
		GoSub, CreateEntry

		If res != {}
		GoSub, ModifyEntry
		Return
		
		CreateEntry:
		API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="

		Data = 1000563=`%IDComment`%&1000564=`%Message`%&api=

		WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		
		WinHttp.Open("POST", "https://www.ragic.com/masteruniversal1/masteruniversal/41", false)
		WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
		WinHttp.Send(Data)
		Return
		
		ModifyEntry:
		API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="

		Data = 1000564=`%Message`%&api=

		WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		WinHttp.Open("POST", "https://www.ragic.com/masteruniversal1/masteruniversal/41/" queryRagicIdExist "?api", false)
		WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
		WinHttp.Send(Data)
		Return
}


Note:
InputBox, UserInput, Comment, Type a comment OR leave empty to delete a previous comment, , 380, 150
if ErrorLevel
    Return

FdUserInput4InternetCommentPos := RegExMatch(UserInput, "^\*\*\*", check4internetcomment)

If FdUserInput4InternetCommentPos != 0
{
UserInput := RegExReplace(UserInput,"^\*\*\*","")

MsgBox,262192,, You are about to add the message "`%UserInput`%" to the cloud server.``n``nThis allows the message to be read on multiple PCs belonging to the same pharmacy.``n``nIF THE PATIENT SWITCHES PHARMACIES AND THE PHARMACY ALSO HAS MASTER UNIVERSAL IT WILL BE ABLE TO READ THIS MESSAGE.

CheckCommentCreateOrUpdate(UserInput)
}

If FdUserInput4InternetCommentPos = 0
    {
	IniRead, IDComment, C:\AHK\CPD.ini, CPD, Name
	
	IniWrite, `%UserInput`%, C:\AHK\Notes.ini, `%IDComment`%, Comment
	}
Return


Tooltips(wParam, lParam, Msg) {

MouseGetPos,,,, OutputVarControl

IfEqual, OutputVarControl, Button1

	Help := "The BACK button switches off the Master Universal``nbut leaves you logged in this patient's file"

else IfEqual, OutputVarControl, Button2

	Help := "The CANCEL ALL button exits the patient's file``nand exits the Master Universal"
	
else IfEqual, OutputVarControl, Button3

	Help := "The POST button posts the medicines``nAND issues the due date.``nUse this when giving the full 2 month supply"
	
else IfEqual, OutputVarControl, Button4

	Help := "The POST w/o LABEL button posts the medicines``nwithout a due date.``nUse this for posting Out of Stock, Warfarin, and DDA only"
	
else IfEqual, OutputVarControl, Button5

	Help := "Prints the Birthday QR Code``nMay be switched off from the backend``nWhen not needed contact me to switch off``nMaster Universal runs faster with it switched off"

else IfEqual, OutputVarControl, Button6

	Help := "Prints an extra Due Date label``nThe date depends on the preset backend date and is adjustable"
	
else IfEqual, OutputVarControl, Button7

	Help := "Prints an extra Patient Name, ID, DOB label"

else IfEqual, OutputVarControl, Button8

	Help := "Prints a label with the fridge items if present"

else IfEqual, OutputVarControl, Button9

	Help := "Removes any item which is not a DDA"
	
else IfEqual, OutputVarControl, Button10

	Help := "Complex function for OOS``nAvoid unless you are an advanced user"
	
else IfEqual, OutputVarControl, Button11

	Help := "Removes any item which is not a Warfarin"
	
else IfEqual, OutputVarControl, Button12

	Help := "Opens an insulin calculator``nEnter insulin units according to type(cartridge or vial)``nResult is a 2 month supply with wastage included"

else IfEqual, OutputVarControl, Button13

	Help := "The REPORT button pulls a report``nof the drug interactions, contraindications and indications"

else IfEqual, OutputVarControl, Button14

	Help := "Return items. This will take you to returns and prefills items according to what is active on the entitlement"
	
else IfEqual, OutputVarControl, Button15

	Help := "Add a note to this patient"
	
else IfEqual, OutputVarControl, Button16

	Help := "Prints a Birthday QR Code everytime the POST button is clicked``nMay be switched off from the backend``nContact me to activate it from the backend"

ToolTip `% Help

}

NamePrint:
IniRead, patientdata2,  C:\AHK\CPD.ini, CPD, Name
IniRead, patientdata1,  C:\AHK\CPD.ini, CPD, ID
IniRead, patientaddress1,  C:\AHK\CPD.ini, CPD, Address

IniRead, SkipDOB, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
If SkipDOB = 1
IniRead, patientbirthday1,  C:\AHK\CPD.ini, CPD, Birthday

FileAppend,``n     `%patientdata1`%``n     `%patientdata2`%``n     `%patientbirthday1`%, C:\AHK\Patient Data.txt

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180

if !SafePrintTextFile("C:\AHK\Patient Data.txt")
    LogFailure("NamePrint: Failed to print Patient Data label")

FileDelete, C:\AHK\Patient Data.txt
FileDelete, C:\AHK\Collection Date.txt
Return


CollectionDateClosedLoop:
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180

IniRead, DueDateOffset, C:\AHK\DueDateSettings.ini, DueDateSetting, DueDate

If DueDateOffset = x
{
HolidayDeduct := -1

FileDelete, C:\AHK\Collection Date.txt
FileDelete, C:\AHK\CollectionDate.ini

  Date += 55, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy 
datestring = `%nDate`%
StringSplit, d, datestring, /
date := d3 d1 d2

Loop,
{
FormatTime, day_of_Week, `%date`%, dddd
gurnata = `%day_of_Week`%
var1 = Sunday
var2 = Monday
var3 = Saturday
If gurnata = `%var1`%
{
  Date += -3, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
  }
If gurnata = `%var2`%
{
  Date += 1, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
}
If gurnata = `%var3`%
{
  Date += -2, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
}
If checkholdate contains 0101,1002,1903,3103,0105,0706,2906,1508,0809,2109,0812,1312,2512
{
  Date += `%HolidayDeduct`%, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy
  datestring = `%nDate`%
  StringSplit, d, datestring, /
  date := d3 d1 d2
  checkholdate := d2 d1
  HolidayDeduct -= 1
}
Else
{
FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
Break
}
}

}

If DueDateOffset != x
{
RecalibratedDate := 56 - DueDateOffset

FileDelete, C:\AHK\Collection Date.txt

  Date += `%RecalibratedDate`%, Days
  FormatTime, nDate, `%Date`%, MM/dd/yyyy 
datestring = `%nDate`%
StringSplit, d, datestring, /
date := d3 d1 d2

FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
}

FormatTime, nDate, `%Date`%, dddd dd MMMM yyyy
FileAppend, Next Due: `%nDate`%, C:\AHK\Collection Date.txt
WaitForFileReady("C:\AHK\Collection Date.txt", 1000)

FileRead, nDate, C:\AHK\Collection Date.txt
	
If nDate is space
{
GoTo, CollectionDateClosedLoop
Sleep, 100
}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
IniRead, CombineNameandDate, C:\AHK\CombineNameandDateSettings.ini, CombineNameandDateSettings, CombineNameandDate ;no need for this because the client just wants to print the name manually
If CombineNameandDate = 1
GoTo, SkipPrintDateCL

if !SafePrintTextFile("C:\AHK\Collection Date.txt")
    LogFailure("Print failed: C:\AHK\Collection Date.txt")
FileDelete, C:\AHK\Collection Date.txt
}
Return

SkipPrintDateCL:
FileRead, Collectionz, C:\AHK\Collection Date.txt
IniRead, patientdata2,  C:\AHK\CPD.ini, CPD, Name
IniRead, patientdata1,  C:\AHK\CPD.ini, CPD, ID
IniRead, patientaddress1,  C:\AHK\CPD.ini, CPD, Address

IniRead, SkipDOB, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
If SkipDOB = 1
IniRead, patientbirthday1,  C:\AHK\CPD.ini, CPD, Birthday


FileAppend,`%patientdata1`%``n`%patientdata2`%``n     `%patientbirthday1`%``n`%Collectionz`%, C:\AHK\Patient Data.txt
; (removed - SafePrintTextFile waits internally)

if !SafePrintTextFile("C:\AHK\Patient Data.txt")
    LogFailure("Print failed: C:\AHK\Patient Data.txt")
	
FileDelete, C:\AHK\Collection Date.txt
FileDelete, C:\AHK\Patient Data.txt

Return
)

WARFARINSECTION =
(
; ---- Warfarin filter: UIA reads descriptions, keyboard deletes (original method) ----
_hwndW := WinExist("ahk_exe poycclient.exe")
_pGridW := 0
Loop, 30
{
    Sleep, 50
    _pGridW := UIA_FindGrid(g_pUIA, _hwndW, "dvPatSuppMed", "Supp QTY.")
    if _pGridW
        break
}
if _pGridW {
    _totW := UIA_ReadAllRows(_pGridW, _rcW, _rdW, _reW, _rbW, _rsW, _rmW, _rwW, _rrW)
    UIA_Release(_pGridW)
    ; Navigate to Supp QTY column, first row (same as original)
    WinActivate, ahk_exe poycclient.exe
    WinWaitActive, ahk_exe poycclient.exe,, 2
    ControlClick , `%TransactionAddress`%, ahk_exe poycclient.exe,,,, X`%MLX`% Y`%MLY`%
    Loop, 50
    {
    SendInput, {Up}
    }
    
    ; Top-down: if not warfarin → {Del} (row removed, next slides up)
    ;           if warfarin → {Down} (skip to next row)
    Loop, `%_totW`%
    {
        if (!InStr(_rdW[A_Index], "WARFARIN") && _rdW[A_Index] != "") {
            SendInput, {Del}
        } else {
            SendInput, {Down}
        }
        
    }
}
GuiControl,Disable, Post
)

INSULINCALC =
(
INSULINFILTER:
Gui, Insulins: Add, Edit, x5 y35 w25 vMor1, 0
Gui, Insulins: Add, Edit, x40 y35 w25 vNoon1, 0
Gui, Insulins: Add, Edit, x70 y35 w25 vEve1, 0
Gui, Insulins: Add, Edit, x105 y35 w25 vNight1, 0
Gui, Insulins: Add, Edit, x5 y130 w25 vMor2, 0
Gui, Insulins: Add, Edit, x40 y130 w25 vNoon2, 0
Gui, Insulins: Add, Edit, x70 y130 w25 vEve2, 0
Gui, Insulins: Add, Edit, x105 y130 w25 vNight2, 0
Gui, Insulins: Add, Text, x5 y20, Morn - Noon - Eve - Night
Gui, Insulins: Add, Text, x5 y5, Insulin Calculator for Cartridges
Gui, Insulins: Add, Text, x5 y115, Morn - Noon - Eve - Night
Gui, Insulins: Add, Button, x5 y60 w126 h40 gSubmitCartridges, Submit Cartridges
Gui, Insulins: Add, Text, x5 y100, Insulin Calculator for Injections
Gui, Insulins: Add, Button, x5 y165 w126 h40 gSubmitInjections, Submit Injections
Gui, Insulins: Show,, Insulin Calculator
Return

SubmitInjections:
Gui, Insulins: Submit, NoHide
Gui, Insulins: Destroy
UnitsInjectionInsulins := Mor2 + Noon2 + Eve2 +Night2
UnitsInjectionInsulins56days := UnitsInjectionInsulins * 56
mLInjectionInsulins56days := UnitsInjectionInsulins56days / 100
vialsInjectionInsulins56days := mLInjectionInsulins56days / 10
MsgBox `%vialsInjectionInsulins56days`%
Return

SubmitCartridges:
Gui, Insulins: Submit
Gui, Insulins: Destroy
UnitsCartridgesInsulins := Mor1 + Noon1 + Eve1 +Night1
UnitsCartridgesInsulins56days := UnitsCartridgesInsulins * 56
mLCartridgesInsulins56days := UnitsCartridgesInsulins56days / 100
vialsCartridgesInsulins56days := mLCartridgesInsulins56days / 3
MsgBox `%vialsCartridgesInsulins56days`%
Return
)

MANUALFRIDGESECTION =
(
FridgeManualPrint:
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 100
Sleep, 50
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 100
Sleep, 50

; ---- Read transaction table via UIA (no clipboard needed) ----
_hwndF := WinExist("ahk_exe poycclient.exe")
_pGridF := 0
Loop, 30
{
    Sleep, 50
    _pGridF := UIA_FindGrid(g_pUIA, _hwndF, "dvPatSuppMed", "Supp QTY.")
    if _pGridF
        break
}
CompleteRecordFiltered := ""
if _pGridF {
    _totF := UIA_ReadAllRows(_pGridF, _rcF, _rdF, _reF, _rbF, _rsF, _rmF, _rwF, _rrF)
    UIA_Release(_pGridF)
    Loop, `%_totF`% {
        CompleteRecordFiltered .= _rdF[A_Index] " " _rsF[A_Index] "``r``n"
    }
}

IniRead, patientdata2,  C:\AHK\CPD.ini, CPD, Name
IniRead, patientdata1,  C:\AHK\CPD.ini, CPD, ID
IniRead, patientaddress1,  C:\AHK\CPD.ini, CPD, Address

CompleteRecordDetails := "[" patientdata2 " " patientdata1 " P " RecordDate "]``r``n" CompleteRecordFiltered "``r``n"

RegRead, OldFontSize, HKEY_CURRENT_USER\Software\Microsoft\Notepad , iPointSize

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 100

FormatTime, FridgeTime,FridgeTime, dd/MM/yyyy

FridgeMSG := patientdata2 " " patientdata1 "``n``nFridge - " FridgeTime "``n``n"

If CompleteRecordDetails contains insulin,erythropoietin,adalimumab,somatropin,etanercept,glucagon,interferon,ALPHACALCIDOL 2MCG
{
FridgeMSG .= 

Loop, Parse, CompleteRecordDetails, ``n
		{		
		Qty := 
		If (InStr(A_LoopField, "ISOPHANE") AND InStr(A_LoopField, "CART") AND !InStr(A_LoopField, "BIPHASIC"))
		  {
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. N (green) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "ISOPHANE") AND InStr(A_LoopField, "VIAL") AND !InStr(A_LoopField, "BIPHASIC"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. N (green) Vials (small) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "BIPHASIC ISOPHANE") AND InStr(A_LoopField, "CART"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. M30 (brown) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "BIPHASIC ISOPHANE") AND InStr(A_LoopField, "VIAL"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. M30 (brown) Vials (small) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "NEUTRAL") AND InStr(A_LoopField, "CART"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. R (yellow) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "NEUTRAL") AND InStr(A_LoopField, "VIAL"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. R (yellow) Vials (small) " Qty1 "``n"
		  }
		If InStr(A_LoopField, "GLARGINE")
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "LANTUS " Qty1 "``n"
		  }
		If InStr(A_LoopField, "ASPART")
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "NOVORAPID " Qty1 "``n"
		  }
		If A_LoopField contains erythropoietin,adalimumab,somatropin,etanercept,glucagon,interferon,ALPHACALCIDOL 2MCG
		FridgeMsg .= A_LoopField "``n"
		}
		
		
		
FridgeMsg := RegExReplace(FridgeMsg, "``n$","")
StringUpper, FridgeMsg, FridgeMsg

FileAppend, `%FridgeMSG`%, C:\AHK\FridgeWarning.txt
; (removed - SafePrintTextFile waits internally)
	
	if !SafePrintTextFile("C:\AHK\FridgeWarning.txt")
	    LogFailure("Print failed: C:\AHK\FridgeWarning.txt")
}

Sleep, 150
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180
Return
)


FRIDGESECTION =
(
RegRead, OldFontSize, HKEY_CURRENT_USER\Software\Microsoft\Notepad , iPointSize

FormatTime, FridgeTime,FridgeTime, dd/MM/yyyy

FridgeMSG := patientdata2 " " patientdata1 "``n``nFridge - " FridgeTime "``n``n"

If CompleteRecordDetails contains insulin,erythropoietin,adalimumab,somatropin,etanercept,glucagon,interferon,ALPHACALCIDOL 2MCG
{
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 100
FridgeMSG .= 

Loop, Parse, CompleteRecordDetails, ``n
		{		
		Qty := 
		If (InStr(A_LoopField, "ISOPHANE") AND InStr(A_LoopField, "CART") AND !InStr(A_LoopField, "BIPHASIC"))
		  {
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. N (green) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "ISOPHANE") AND InStr(A_LoopField, "VIAL") AND !InStr(A_LoopField, "BIPHASIC"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. N (green) Vials (small) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "BIPHASIC ISOPHANE") AND InStr(A_LoopField, "CART"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. M30 (brown) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "BIPHASIC ISOPHANE") AND InStr(A_LoopField, "VIAL"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. M30 (brown) Vials (small) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "NEUTRAL") AND InStr(A_LoopField, "CART"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. R (yellow) Cartridges (big) " Qty1 "``n"
		  }
		If (InStr(A_LoopField, "NEUTRAL") AND InStr(A_LoopField, "VIAL"))
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "Gen. R (yellow) Vials (small) " Qty1 "``n"
		  }
		If InStr(A_LoopField, "GLARGINE")
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "LANTUS " Qty1 "``n"
		  }
		If InStr(A_LoopField, "ASPART")
		  { 
		FoundQty := RegExMatch(A_LoopField, "(\d+)\s+$", Qty)
		FridgeMsg .= "NOVORAPID " Qty1 "``n"
		  }
		If A_LoopField contains erythropoietin,adalimumab,somatropin,etanercept,glucagon,interferon,ALPHACALCIDOL 2MCG
		FridgeMsg .= A_LoopField "``n"
		}
		
		
		
FridgeMsg := RegExReplace(FridgeMsg, "``n$","")
StringUpper, FridgeMsg, FridgeMsg

FileAppend, `%FridgeMSG`%, C:\AHK\FridgeWarning.txt
; (removed - SafePrintTextFile waits internally)
	
	if !SafePrintTextFile("C:\AHK\FridgeWarning.txt")
	    LogFailure("Print failed: C:\AHK\FridgeWarning.txt")
}

; Restore font size after fridge label printing (was set to 100 for small fridge labels)
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, `%OldFontSize`%
)
	
DDASECTION =
(
; ---- DDA filter: UIA reads descriptions, keyboard deletes (original method) ----
_hwndD := WinExist("ahk_exe poycclient.exe")
_pGridD := 0
Loop, 30
{
    Sleep, 50
    _pGridD := UIA_FindGrid(g_pUIA, _hwndD, "dvPatSuppMed", "Supp QTY.")
    if _pGridD
        break
}
if _pGridD {
    DDAList := "AZEPAM,PHENOBARBITONE,TRAMADOL,MORPHINE,METHYLPHENIDATE,CLOBAZAM,PETHIDINE,FENTANYL,DIHYDROCODEINE"
    _totD := UIA_ReadAllRows(_pGridD, _rcD, _rdD, _reD, _rbD, _rsD, _rmD, _rwD, _rrD)
    UIA_Release(_pGridD)
    ; Navigate to Supp QTY column, first row (same as original)
    WinActivate, ahk_exe poycclient.exe
    WinWaitActive, ahk_exe poycclient.exe,, 2
    ControlClick , `%TransactionAddress`%, ahk_exe poycclient.exe,,,, X`%MLX`% Y`%MLY`%
    Loop, 50
    {
    SendInput, {Up}
    }
    
    ; Top-down: if not DDA → {Del}, if DDA → {Down}
    Loop, `%_totD`%
    {
        desc := _rdD[A_Index]
        isDDA := false
        Loop, Parse, DDAList, `,
        {
            if InStr(desc, A_LoopField)
                isDDA := true
        }
        if (desc != "" && !isDDA) {
            SendInput, {Del}
        } else {
            SendInput, {Down}
        }
        Sleep, 10
    }
}
GuiControl,Disable, Post
)



winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
WinGetTitle, PharmacyName , ahk_exe poycclient.exe
WinGet, ActiveControlList, ControlList, ahk_exe poycclient.exe
Loop, Parse, ActiveControlList , `n
{
ControlGetText, ControlText, %A_Loopfield%, ahk_exe poycclient.exe
ControlListData .= ControlText "`n"

If ControlText contains toolStrip1
ToolStripAddress := A_LoopField
}
FoundPos := RegExMatch(ControlListData, "ID Card :\n[0-9a-zA-Z]+\n([a-zA-Z0-9]+)", SchemeCard)

OSSP0() ;get patient name and ID

PatientParticulars := Clipboard

GetIDControl() ;stored in IDControl

IfGreater, Limiter, 5
{
MsgBox ,, Scan a file, Please scan a scheme card in WPDS prior to running Master Universal, 3
ExitApp
}

If patientdata1 is space
{
Limiter++
GoTo, MUniversal
}

ReverseSection =
(
)

DrugInteractionsSection =
(
Gui, drugint: +AlwaysOnTop
Gui, drugint: Add, Text, x5 y5, Gathering Information``n``n        Please wait`n`n`n
Gui, drugint: Add, Text, x5 y60 vStatusLoading, Loading Drug Interactions
Gui, drugint: Show

Gui, 3: Destroy
FileDelete, C:\AHK\DrugInteractions.txt

; ---- Read transaction table via UIA (no clipboard needed) ----
_hwndDI := WinExist("ahk_exe poycclient.exe")
_pGridDI := 0
Loop, 30
{
    Sleep, 50
    _pGridDI := UIA_FindGrid(g_pUIA, _hwndDI, "dvPatSuppMed", "Supp QTY.")
    if _pGridDI
        break
}
CompleteRecordFiltered := ""
if _pGridDI {
    _totDI := UIA_ReadAllRows(_pGridDI, _rcDI, _rdDI, _reDI, _rbDI, _rsDI, _rmDI, _rwDI, _rrDI)
    UIA_Release(_pGridDI)
    Loop, `%_totDI`% {
        CompleteRecordFiltered .= _rdDI[A_Index] "``r``n"
    }
}

Loop, parse, CompleteRecordFiltered, ``n
{
	FoundPos := RegExMatch(A_LoopField,"(.+?)(\t|\s+\d+MG|\s+\d+\.\d+MG|\s+\d+MCG|\s+\d+\.\d+MCG|\s+\d+\`%|\s+\d+\.\d+\`%|\s+\(|\s+\d+G|\s+\d+\.\d+G|\s+\d+ML|\s+\d+\.\d+ML|\s+\d+L|\s+\d+\.\d+L|\s+VIALS|\s+\d+IU|\s+\d+CM|\s+\d+\.\d+CM|\s+P\.G\.|\s+CONTAINING|\s+NEB\.\s+SOL\.|\®|SODIUM\s+CHRONO)",medname)

	WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WinHttp.Open("GET", "https://rxnav.nlm.nih.gov/REST/rxcui?name=" medname1, false)
	WinHttp.Send()
	RXCUI := WinHttp.ResponseText

	FoundPos := RegExMatch(RXCUI,"\<rxnormId\>(.+)\<\/rxnormId\>",RXID)


	If RXID1 =
	{
	number += 1

		If NotFoundItem not contains `%medname1`%
		NotFoundItem .= medname1 "|"
	}

	If RXID1 !=
	{
	RXIDLIST .= RXID1 "+"
	}
	
	If (medname1 != "")
	{
	If ListOfMedNames not contains `%medname1`%
	ListOfMedNames .= medname1 "|"
	}
}

ListOfMedNames := RegExReplace(ListOfMedNames,"\s+$", "")
NotFoundItem := RegExReplace(NotFoundItem,"\s+$", "")
ListOfMedNames := RegExReplace(ListOfMedNames,"\|$", "")
NotFoundItem := RegExReplace(NotFoundItem,"\|$", "")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; drug interactions

RXIDLIST := RegExReplace(RXIDLIST,"\+$","")
RXIDLISTURL := "https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis=" RXIDLIST

WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("GET", RXIDLISTURL, false)
WinHttp.Send()
RXCUInteraction := WinHttp.ResponseText
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; contraindications
GuiControl, drugint:, StatusLoading, Loading Contraindications

number := 1

Loop, Parse, RXIDLIST, +
{
RXIDLISTURL := "https://rxnav.nlm.nih.gov/REST/rxclass/class/byRxcui.json?rxcui=" A_LoopField "&relaSource=MEDRT&relas=CI_with"

WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("GET", RXIDLISTURL, false)
WinHttp.Send()
RXCUContraIndications`%number`% .= WinHttp.ResponseText

number++
}

NumberOfContraindications := number * 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;  drug indications

GuiControl, drugint:, StatusLoading, Loading Indications

number := 1

Loop, Parse, RXIDLIST, +
{
RXIDLISTURL := "https://rxnav.nlm.nih.gov/REST/rxclass/class/byRxcui.json?rxcui=" A_LoopField "&relaSource=MEDRT&relas=may_treat"

WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("GET", RXIDLISTURL, false)
WinHttp.Send()
RXCUIndications`%number`% .= WinHttp.ResponseText

number++
}

NumberOfIndications := number * 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui3Width := A_ScreenWidth - 20
Gui3Height := A_ScreenHeight - 100
LVWidth := A_ScreenWidth - 100
LVHeight := A_ScreenHeight / 3.5
DescColWidth := A_ScreenWidth * 0.7
OtherColWidth := A_ScreenWidth * 0.07
DescColWidth := Round(DescColWidth) 
OtherColWidth := Round(OtherColWidth) 
LV2Width := (A_ScreenWidth / 2) - 100
LV3Width := 700
CtrDrugColWidth := OtherColWidth * 2
DrugNotFoundX := A_ScreenWidth / 7
DrugNotFoundX := Round(DrugNotFoundX)
ThirdListViewX := A_ScreenWidth / 2.25
ThirdListViewX := Round(ThirdListViewX)
FirstListViewY := A_ScreenHeight / 3.3
FirstListViewY := Round(FirstListViewY)
HeightListBox := A_ScreenHeight / 4.49
HeightListBox := Round(HeightListBox)
WidthListBox := A_ScreenWidth / 8
WidthListBox := Round(WidthListBox)

DrugInteractionTextX := A_ScreenWidth / 2.19
DrugInteractionTextX := Round(DrugInteractionTextX)
InteractionReportTextY:= A_ScreenHeight / 3.6
InteractionReportTextY := Round(InteractionReportTextY)



Gui, 3: +LastFound +AlwaysOnTop
Gui, 3: Add, Text, x5 y5, %patientdata1% %patientdata2%
Gui, 3: Font, Underline
Gui, 3: Add, Text, x5 y25, DRUGS FOUND
Gui, 3: Add, Text, x`%DrugNotFoundX`% y25, DRUGS NOT FOUND
Gui, 3: Font,
Gui, 3: Add, ListBox, x5 y45 h`%HeightListBox`% w`%WidthListBox`% vLB1, `%ListOfMedNames`%
Gui, 3: Add, ListBox, x205 y45 h`%HeightListBox`% w`%WidthListBox`% vLB2, `%NotFoundItem`%
Gui, 3: Font, Underline
Gui, 3: Add, Text, x5 y`%InteractionReportTextY`%, DRUG INTERACTIONS REPORT
Gui, 3: Font,
Gui, 3: Add, ListView, w`%LVWidth`% h`%LVHeight`% x5 y`%FirstListViewY`% vMyFirstListView, Drug1|Drug2|Description|Severity
Gui, 3: Font, Underline
Gui, 3: Add, Text, x5, DRUG CONTRAINDICATIONS REPORT
Gui, 3: Add, Text, x`%DrugInteractionTextX`% yp, DRUG INDICATIONS
Gui, 3: Font,
Gui, 3: Add, ListView, w`%LV2Width`% h`%LVHeight`% x5 vMySecondListView, Drug|Contraindication
Gui, 3: Add, ListView, w`%LV3Width`% h`%LVHeight`% x`%ThirdListViewX`% yp vMyThirdListView, Drug|Indication

Gui, 3: Default

number = 1

Loop,
{
p := 1, m := ""

while p := RegExMatch(RXCUInteraction, "\""comment\""\:\""Drug1.+?name\s+\=\s+(.+?)\,.+?Drug2.+?name\s+\=\s+(.+?)\,.+?\""severity\""\:\""(.+?)""\,\""description\""\:\""(.+?)\""", m, p + StrLen(m))
	{
	drugone`%A_Index`% := m1
	drugtwo`%A_Index`% := m2
	severity`%A_Index`% := m3
	description`%A_Index`% := m4
	
	StringUpper, drugone`%A_Index`% , drugone`%A_Index`%, T
	StringUpper, drugtwo`%A_Index`% , drugtwo`%A_Index`%, T
	
	drugone`%A_Index`% := RegExReplace(drugone`%A_Index`%,"i)Albuterol","Salbutamol")
	drugtwo`%A_Index`% := RegExReplace(drugtwo`%A_Index`%,"i)Albuterol","Salbutamol")
	description`%A_Index`% := RegExReplace(description`%A_Index`%,"i)Albuterol","Salbutamol")
	 	
	}
	
Gui, ListView, MyFirstListView	
LV_Add("",drugone`%number`%,drugtwo`%number`%,description`%number`%,severity`%number`%)
number ++
}
Until description`%number`% = ""

LV_ModifyCol(1, OtherColWidth)
LV_ModifyCol(2, OtherColWidth)
LV_ModifyCol(3, DescColWidth)
LV_ModifyCol(4, OtherColWidth)

number = 1

Loop, `%NumberOfContraindications`%
{

p := 1, m := ""

while p := RegExMatch(RXCUContraIndications`%number`%, "name\""\:\""(.+?)\"".+?.+?className\""\:""(.+?)\""", m, p + StrLen(m))
	{
	cntdrug`%A_Index`% := m1
	StringUpper, cntdrug`%A_Index`%, cntdrug`%A_Index`%, T
	
	conrtraindic`%A_Index`% := m2
	}


Gui, ListView, MySecondListView	
If (cntdrug`%A_Index`% != "") AND (conrtraindic`%A_Index`% != "")
LV_Add("",cntdrug`%A_Index`%,conrtraindic`%A_Index`%)

number++
}

LV_ModifyCol(1, CtrDrugColWidth)
LV_ModifyCol(2, DescColWidth)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; drug indications

number = 1

Loop, `%NumberOfIndications`%
{

p := 1, m := ""

while p := RegExMatch(RXCUIndications`%number`%, "name\""\:\""(.+?)\"".+?.+?className\""\:""(.+?)\""", m, p + StrLen(m))
	{
	intdrug`%A_Index`% := m1
	StringUpper, intdrug`%A_Index`%, intdrug`%A_Index`%, T
	
	indic`%A_Index`% := m2
	}


Gui, ListView, MyThirdListView	
If (intdrug`%A_Index`% != "") AND (indic`%A_Index`% != "")
LV_Add("",intdrug`%A_Index`%,indic`%A_Index`%)

number++
}

LV_ModifyCol(1, CtrDrugColWidth)
LV_ModifyCol(2, DescColWidth)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui, 3: Show, w`%Gui3Width`% h`%Gui3Height`% y5 x5, Drug Interactions
GuiControl,3: Choose,LB1, 0
GuiControl,3: Choose,LB2, 0
Gui, drugint: Destroy

ControlFocus, Button1, Drug Interactions

Gui, Default
Return

)

FileCreateDir, %A_MyDocuments%\POYC LOGIN RECORDS
FoundPos := RegExMatch(ControlListData, "Voucher Start Date:\nID Card :\n(.*)\n(.*)\n(.*)\ntoolStrip1\nmenuStrip1", logindata)



; ---- Read patient details via UIA (no clipboard needed) ----
hwnd := WinExist("ahk_exe poycclient.exe")
pPatGrid := UIA_FindGrid(g_pUIA, hwnd, "dvPatDetails", "Attribute|Value")
if pPatGrid {
    patData := UIA_ReadPatientDetails(pPatGrid)
    UIA_Release(pPatGrid)
    patientdata1 := patData.ID
    patientdata2 := patData.Name
    patientbirthday1 := RegExReplace(patData.DOB, "\s+\d{2}:\d{2}:\d{2}$", "")
    patientaddress1 := patData.Address
    ; Build fullpatientdata for backward compat with any code that uses it
    fullpatientdata := "ID " patData.ID " Name " patData.Name " Address " patData.Address " Date Of Birth " patData.DOB
} else {
    ; Fallback: should not happen, but handle gracefully
    patientdata1 := ""
    patientdata2 := ""
    patientbirthday1 := ""
    patientaddress1 := ""
    fullpatientdata := ""
}

IniWrite, ***, %A_MyDocuments%\POYC LOGIN RECORDS\Login Records.ini, %patientdata2% %patientdata1%, K*e*y

TransactionID :=
TransactionID =  %patientdata1%
TransactionID := SubStr(TransactionID, 1, 6)

FoundPos := RegExMatch(PharmacyName, "POYC Main Dispensing - (.*) \(LIVE", IsemSpizerija)

PharmacyFingerprint := IsemSpizerija1 "<br>" "PC Unique ID: " AscPCDetails "<br>" "Transaction ID: " AscTransactionID

; ---- Apply Entitlement ----
hwnd := WinExist("ahk_exe poycclient.exe")
SetControlDelay -1
ControlClick , %ToolStripAddress%, ahk_exe poycclient.exe,,,, X%AEX% Y%AEY% ; Apply entitlement

If NonAutoFill = 1
{
GoTo, SkipAutoFill
}

; ---- Wait for transaction table via UIA (fast: AutomationId only, no fallback scan) ----
pTransGrid := 0
Loop, 40
{
    Sleep, 25
    ; Quick search by AutomationId only (no expensive column-header fallback)
    pTransGrid := UIA_FindGrid(g_pUIA, hwnd, "dvPatSuppMed")
    if pTransGrid
        break
}
; If quick search failed, try once more with full fallback
if !pTransGrid
    pTransGrid := UIA_FindGrid(g_pUIA, hwnd, "dvPatSuppMed", "Supp QTY.")
if !pTransGrid {
    MsgBox, 16, UIA Error, Transaction table (dvPatSuppMed) not found after Apply Entitlement.
    GoTo, SkipAutoFill
}

; ---- Fetch rounding rules (cached 12h, plain text file to preserve = signs and newlines) ----
_roundingCacheFile := "C:\AHK\RoundingRulesCache.txt"
_roundingCacheTime := "C:\AHK\RoundingRulesCacheTime.ini"
_needFetch := true
IniRead, _cachedTime, %_roundingCacheTime%, Cache, FetchTime, 0
if (_cachedTime != 0) {
    _age := A_Now
    EnvSub, _age, %_cachedTime%, Hours
    if (_age < 12) {
        FileRead, RoundingRules, %_roundingCacheFile%
        if (RoundingRules != "")
            _needFetch := false
    }
}
if (_needFetch) {
    url := "https://pastebin.com/raw/rG9GwkEw"
    HttpRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpRequest.Open("GET", url)
    HttpRequest.Send()
    RoundingRules := HttpRequest.ResponseText
    ; Save to cache (plain text file preserves = signs and newlines)
    if (RoundingRules != "") {
        IniWrite, %A_Now%, %_roundingCacheTime%, Cache, FetchTime
        FileDelete, %_roundingCacheFile%
        FileAppend, %RoundingRules%, %_roundingCacheFile%
    }
}

FoundPos := RegExMatch(RoundingRules,"roundeduplist \= (.*)", RoundedUpList)
FoundPos := RegExMatch(RoundingRules,"hundredpack \= (.*)", HundredPack)
FoundPos := RegExMatch(RoundingRules,"fiftypacks \= (.*)", FiftyPack)
FoundPos := RegExMatch(RoundingRules,"sixtypacks \= (.*)", SixtyPack)
FoundPos := RegExMatch(RoundingRules,"fifteenpacks \= (.*)", FifteenPack)
FoundPos := RegExMatch(RoundingRules,"undouble \= (.*)", Undouble)
FoundPos := RegExMatch(RoundingRules,"thirtypacks \= (.*)", Thirty)
FoundPos := RegExMatch(RoundingRules,"fourtypacks \= (.*)", Fourty)

roundeduplist := RoundedUpList1
hundredpack := HundredPack1
fiftypacks := FiftyPack1
sixtypacks := SixtyPack1
fifteenpacks := FifteenPack1
thirtypacks := Thirty1
fourtypacks := Fourty1

; ---- Read all transaction rows via UIA (replaces Ctrl+C clipboard reads) ----
totlines := UIA_ReadTransactionRows(pTransGrid, rowCode, rowDesc, rowEnt28, rowBalance, rowSuppQty, rowSimBal, rowDays, rowRegNo, rowSuppEl, rowRegNoEl)
UIA_Release(pTransGrid)

; ---- Process each row: calculate qty and write via UIA (replaces SendInput) ----
Loop, %totlines%
{
r := A_Index
RoundedSuppliedQTY :=
SuppliedQTY :=

; Map UIA arrays to the old variable names used by rounding logic
dataset1 := rowDesc[r]       ; description
dataset2 := rowEnt28[r]      ; qty per 28 days
dataset3 := rowBalance[r]    ; stock balance
dataset4 := rowSuppQty[r]    ; supplied qty (currently 0000)
dataset5 := rowSimBal[r]     ; simulated remaining
dataset6 := rowDays[r]       ; days
dataset7 := rowRegNo[r]      ; reg no
code1    := rowCode[r]       ; stock code

FileName :=
CorrectedItem2 :=
FileName := patientdata2 " " patientdata1 " " dataset1
FileName := RegExReplace(FileName, "[\\/:*?,)(""<>|%]" , "")
FoundPos := RegExMatch(FileName, "^.{1,50}" , FileName)
CorrectedItem2 := RegExReplace(dataset1, "[\\/:*?,)(""<>|%]" , "")
CorrectedItem2 := RegExReplace(CorrectedItem2, "`n" , "")
FoundPos := RegExMatch(CorrectedItem2, "^.{1,60}" , CorrectedItem2)

;dataset1=description
;dataset2=qty per month
;dataset3=stock balance
;dataset4=supplied qty
;dataset5=simulated remaining
;dataset6=days
;dataset7=regno

SuppliedQTY := dataset2 * 2
RoundedSuppliedQTY := Round(SuppliedQTY, -1)
HundredSuppliedQTY := Round(SuppliedQTY, -2)

remainder := Mod(SuppliedQTY, 50)			;round to 50 box for europharma sticks
roundto50boxes := SuppliedQTY - remainder

remainder := Mod(SuppliedQTY, 60)	;round to 60 box for ranitidine etc
rnd_amount := 60 - remainder
If (rnd_amount=60)
  rnd_amount = 0	;so 100 stays at 100
roundto60boxes := SuppliedQTY + rnd_amount

remainder := Mod(SuppliedQTY, 15)	;round to 15 box for splits and ddas
rnd_amount := 15 - remainder
If (rnd_amount=15)
  rnd_amount = 0
roundto15 := SuppliedQTY + rnd_amount

remainder := Mod(SuppliedQTY, 30)	;round to 30
rnd_amount := 30 - remainder
If (rnd_amount=30)
  rnd_amount = 0
roundto30 := SuppliedQTY + rnd_amount

remainder := Mod(SuppliedQTY, 40)	;round to 40
rnd_amount := 40 - remainder
If (rnd_amount=40)
  rnd_amount = 0
roundto40 := SuppliedQTY + rnd_amount

	; --- Write quantity via UIA (direct 1:1 translation of original SendInput logic) ---

	If dataset1 contains %hundredpack%
	{
		If SuppliedQTY > %dataset3%
		{
		OOSQTY := SuppliedQTY - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
		{
		If HundredSuppliedQTY != 0
		UIA_SetValue(rowSuppEl[r], HundredSuppliedQTY)

		If HundredSuppliedQTY = 0
		UIA_SetValue(rowSuppEl[r], RoundedSuppliedQTY)
		}
	}

	If dataset1 contains %roundeduplist%
	{
		If RoundedSuppliedQTY > %dataset3%
		{
		OOSQTY := RoundedSuppliedQTY - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], RoundedSuppliedQTY)
	}

	If dataset1 contains %fiftypacks%
	{
	If roundto50boxes = 100
		If dataset1 contains EUROPHARMA STRIPS FOR BLOOD GLUCOSE
			roundto50boxes = 50

		If roundto50boxes > %dataset3%
		{
		OOSQTY := roundto50boxes - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], roundto50boxes)
	}

	If dataset1 contains %sixtypacks%
	{
		If roundto60boxes > %dataset3%
		{
		OOSQTY := roundto60boxes - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], roundto60boxes)
	}

	If dataset1 contains %fifteenpacks%
	{
		If roundto15 > %dataset3%
		{
		OOSQTY := roundto15 - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], roundto15)
	}

		If dataset1 contains %thirtypacks%
	{
		If roundto30 > %dataset3%
		{
		OOSQTY := roundto30 - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], roundto30)
	}

			If dataset1 contains %fourtypacks%
	{
		If roundto40 > %dataset3%
		{
		OOSQTY := roundto40 - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], roundto40)
	}

		If dataset1 contains %undouble%
	{
		If dataset2 > %dataset3%
		{
		OOSQTY := dataset2 - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], dataset2)
	}

	If dataset1 not contains %roundeduplist%
		If dataset1 not contains %fifteenpacks%
			If dataset1 not contains %fiftypacks%
				If dataset1 not contains %sixtypacks%
					If dataset1 not contains %hundredpack%
						If dataset1 not contains %undouble%
							If dataset1 not contains %thirtypacks%
								If dataset1 not contains %fourtypacks%
	{

		If SuppliedQTY > %dataset3%
		{
		OOSQTY := SuppliedQTY - dataset3
		OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)

		If dataset3 = 0
		UIA_SetValue(rowSuppEl[r], "")

		Else
		UIA_SetValue(rowSuppEl[r], dataset3)
		}
	Else
	UIA_SetValue(rowSuppEl[r], SuppliedQTY)
	}
}

; ---- Write Doctor Registration Numbers via UIA (no keyboard needed) ----
IniRead, SkipRegNumber, C:\AHK\RegNumberSettings.ini, RegNumberSettings, RegNos

If SkipRegNumber = 0
{
Loop, %totlines%
{
	UIA_SetValue(rowRegNoEl[A_Index], DoctorReg)
}
}

; ---- Release UIA cell elements ----
UIA_FreeRowElements(rowSuppEl, rowRegNoEl, totlines)

; ---- Delete zero-stock rows (Current Balance = 0) using keyboard method ----
_hasZero := false
Loop, %totlines%
{
	if (rowBalance[A_Index] = 0 || rowBalance[A_Index] = "0")
		_hasZero := true
}
if (_hasZero) {
	winactivate, ahk_exe poycclient.exe
	winwaitactive, ahk_exe poycclient.exe
	SetControlDelay -1
	ControlClick , %TransactionAddress%, ahk_exe poycclient.exe,,,, X%MLX% Y%MLY%
	Loop, 50
	{
	SendInput, {Up}
	}
	
	Loop, %totlines%
	{
		if (rowBalance[A_Index] = 0 || rowBalance[A_Index] = "0") {
			SendInput, {Del}
		} else {
			SendInput, {Down}
		}
		Sleep, 10
	}
}

SkipAutoFill:
		FileAppend,  ; The comma is required in this case.
(
#NoTrayIcon
#SingleInstance force
#Requires AutoHotkey 1.1

PharmacyName := "%IsemSpizerija1%"
PID := A_ComputerName
Transaction := %TransactionID%

try
{
Ragic(PharmacyName,PID,Transaction)
}
catch e
{
}

ExitApp

Ragic(PharmacyName,PID,Transaction){
API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="
Ragic_Date :=
Ragic_Time :=

Loop,
{
If Ragic_Date is space
FormatTime, Ragic_Date,%Ragic_Date%, yyyy/MM/dd

If Ragic_Date is not space
Break
}

Loop,
{
If Ragic_Time is space
FormatTime, Ragic_Time,%Ragic_Time%, hh:mm:ss tt

If Ragic_Time is not space
Break
}

Data = 1000012=`%PharmacyName`%&1000013=`%PID`%&1000014=`%Transaction`%&1000015=`%Ragic_Date`%&1000016=`%Ragic_Time`%&api=

WinHttp := ComObjCreate("MSXML2.XMLHTTP.6.0")
WinHttp.Open("POST", "https://www.ragic.com/masteruniversal1/masteruniversal/1", false)
WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
WinHttp.Send(Data)
}
), C:\AHK\Ragic.ahk

StartTime := A_TickCount

While !FileExist("C:\AHK\Ragic.ahk") {
    Sleep 25
    if (A_TickCount - StartTime > 100)
        break
}

try {
    Run, C:\AHK\Ragic.ahk
} catch {
}

executioner()

FileDelete, C:\AHK\Ragic.ahk
FileDelete, C:\AHK\Master Universal.ahk

OSSP0()
{
global
patientdata1 :=
patientdata2 :=
fullpatientdata :=

; Read patient details via UIA (no clipboard/focus needed)
hwnd := WinExist("ahk_exe poycclient.exe")
pPatGrid := UIA_FindGrid(g_pUIA, hwnd, "dvPatDetails", "Attribute|Value")
if pPatGrid {
    patData := UIA_ReadPatientDetails(pPatGrid)
    UIA_Release(pPatGrid)
    patientdata1 := patData.ID
    patientdata2 := patData.Name
    patientbirthday1 := RegExReplace(patData.DOB, "\s+\d{2}:\d{2}:\d{2}$", "")
    patientaddress1 := patData.Address
    fullpatientdata := "ID " patData.ID " Name " patData.Name " Address " patData.Address " Date Of Birth " patData.DOB
}

IniWrite, %patientdata1%, C:\AHK\CPD.ini, CPD, Name
IniWrite, %patientdata2%, C:\AHK\CPD.ini, CPD, ID
IniWrite, %patientaddress1%, C:\AHK\CPD.ini, CPD, Address
IniWrite, %patientbirthday1%, C:\AHK\CPD.ini, CPD, Birthday
}


OSSP1(patientdata2,patientdata1,FileName,CorrectedItem2,dataset1,OOSQTY)  ;datagathering
{
Global PharmacyEmailwTitle
Global PharmacyEmailSubject
Global PharmacyClosingEmail
Global PharmacyPictureLink
Global PharmacyEmailLink
Global PharmacyUserName
Global PharmacyPassword
Global PresOOS
Global PharmacyPasswordMangion

FileName := RegExReplace(Filename, "\n", "")
FileName := RegExReplace(Filename, "\r", "")

FileDelete, C:\AHKAHK\%FileName%.txt 
FileDelete, C:\AHK\%FileName%.ahk

CorrectedItem := RegExReplace(dataset1, "[\\/:*?,)(""<>|%]" , "")
CorrectedItem3 := RegExReplace(dataset1, "[\\/:*?,)(""<>|%]" , "")
CorrectedItem3 := RegExReplace(CorrectedItem3, "`n" , "")

PresOOS .= CorrectedItem3 "=" OOSQTY "|"

PharmacyEmailwTitleNewGMAIL := RegExReplace(PharmacyEmailwTitle, ".+?\s+","")
PharmacyPasswordMangion := RegExReplace("""" PharmacyPassword """", """","")

		FileAppend,  ; The comma is required in this case.
(
#SingleInstance force
#Requires AutoHotkey 1.1


Gui, +LastFound +AlwaysOnTop
Gui, Add, Edit, x5 y64 w270 h30 vMyEdit1, %patientdata2% %patientdata1%
Gui, Add, Text, x5 y50, Patient Name and ID Card
Gui, Add, Edit, x5 y18 w270 h30 vMyEdit5, %CorrectedItem3%
Gui, Add, Text, x5 y5, Order Items
Gui, Add, Button, x279 y17 w80 h77, Send
Gui, Add, Button, x365 y17 w80 h77, Print Only
Gui, Color, EE721C
Gui, Show, x525 y700 h100 w450, Order items
ControlClick, Edit2, Order items

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
Sleep, 50
Return

RecordOOS:
Loop,
{
If OOS_Date is space
FormatTime, OOS_Date,`%OOS_Date`%, yyyyMMdd

If OOS_Date is not space
Break
}

IniWrite, %OOSQTY%|`%OOS_Date`%, C:\AHK\OOSRecords.ini, %patientdata2%%A_Space%%patientdata1%, %CorrectedItem3%
Return

ButtonPrintOnly:
GoSub, RecordOOS
;FileCreateDir, %A_MyDocuments%\POYC OOS
;FileAppend, %patientdata2%%A_Space%%patientdata1%%A_Space%%A_Space%%A_Space%%CorrectedItem3%%A_Space%%A_Space%%A_Space%%OOSQTY%``n, %A_MyDocuments%\POYC OOS\OOS LIST.txt
IniRead,OldQty, %A_MyDocuments%\POYC OOS\OOS LIST.ini, OOS,%CorrectedItem3%,0
NewQtyOOS := OldQty + %OOSQTY%
;IniWrite, `%NewQtyOOS`%, %A_MyDocuments%\POYC OOS\OOS LIST.ini, OOS, %CorrectedItem3%
;IniWrite, `%NewQtyOOS`%, %A_MyDocuments%\POYC OOS\OOS LIST-PATIENT NAMED.ini, %patientdata2%%A_Space%%patientdata1%, %CorrectedItem3%

FileDelete, C:\AHK\%FileName%.txt
FileAppend, %patientdata1% OOS: %CorrectedItem2% QTY: %OOSQTY%, C:\AHK\%FileName%.txt

	Loop,
	{
	If !FileExist("C:\AHK\%FileName%.txt")
	{
	Sleep, 50
	}
	
	If FileExist("C:\AHK\%FileName%.txt")
	Break
	}
IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
RunWait print "C:\AHK\%FileName%.txt",, HIDE

IniRead, NumberOfOutOfStockLabels, C:\AHK\NumberOfOutOfStockLabelsSettings.ini, NumberOfOutOfStockLabelsSettings, NumberOfOutOfStockLabels
IfEqual, NumberOfOutOfStockLabels, 2
RunWait print "C:\AHK\%FileName%.txt",, HIDE
}

sleep, 100
Run, taskkill /F /IM notepad.exe, , Hide
sleep, 10

FileDelete, C:\AHK\%FileName%.txt 
FileDelete, C:\AHK\%FileName%.ahk
ExitApp

ButtonSend:
GoSub, RecordOOS
ControlGetText, orderitem, Edit2, Order items
ControlGetText, ordername, Edit1, Order items

body =Please supply the following items for the patient below;<br><br>`%ordername`%<br><strong>`%orderitem`%</strong>
from = %PharmacyEmailwTitleNewGMAIL%
receiver = orders.poyc@gov.mt
bcc =
copied = 
subject = %PharmacyEmailSubject%
closing = %PharmacyClosingEmail%

If from contains @gmail.com
EmailSupplierNewGMAIL(from,receiver,copied,bcc,subject,body,closing)

If from contains @outlook.com
EmailSupplierMangion(from,receiver,copied,bcc,subject,body,closing)

If from contains @ammangion.com
EmailSupplierMangion(from,receiver,copied,bcc,subject,body,closing)
ExitApp

EmailSupplierNewGMAIL(from,receiver,copied,bcc,subject,body,closing){
SUBJECT := SUBJECT

PSexe:="powershell.exe"
SMTPserver:="smtp.gmail.com"
SMTPport:="587"
PictureLink = %PharmacyPictureLink%
EmailLink = %PharmacyEmailLink%

FoundPos := RegExMatch(EmailLink,"[a-zA-Z0-9-_]{1,}@[a-zA-Z0-9-_]{1,}.[a-zA-Z]{1,}", foundemail)

BCC := foundemail

Head = <head><style> div {background-image: linear-gradient(#e6f0ff, white);} p {font-family: "Monospace", Andale Mono, monospace; font-size: 15px;}  </style></head>
FormatTime, EmailTime, , hh:mm tt
FormatTime, EmailDate, , LongDate

EmailBody = 
`(
<html> " `%Head`% "
<body>
<div>
<p>" `%EmailDate`% "<br>" `%EmailTime`% "</p>
<p>" `%BODY`% "</p>
<p>" `%CLOSING`% "</p>
<h2> " `%END`% `%EmailLink`% "<br><br>" `%PictureLink`% "</h2>
</div>
</body>
</html>
`)

PScmd:="""" . "Send-MailMessage -From '" . from . "' -to '" . receiver . "' -Subject '" . subject . "' -BodyAsHtml '" . EmailBody
            . "' -SmtpServer '" . SMTPserver . "' -port '" . SMTPport . "' -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ('"
            . from . "', (ConvertTo-SecureString -String '" . " %PharmacyPasswordMangion% " . "' -AsPlainText -Force)))" . """"
Run,`%PSexe`% -command `%PScmd`%,,Hide

GoSub, ButtonPrintOnly
}

EmailSupplierMangion(from,receiver,copied,bcc,subject,body,closing){
SUBJECT := SUBJECT

PSexe:="powershell.exe"
SMTPserver:="smtp.office365.com"
SMTPport:="587"
PictureLink = %PharmacyPictureLink%
EmailLink = %PharmacyEmailLink%

FoundPos := RegExMatch(EmailLink,"[a-zA-Z0-9-_]{1,}@[a-zA-Z0-9-_]{1,}.[a-zA-Z]{1,}", foundemail)

BCC := foundemail

Head = <head><style> div {background-image: linear-gradient(#e6f0ff, white);} p {font-family: "Monospace", Andale Mono, monospace; font-size: 15px;}  </style></head>
FormatTime, EmailTime, , hh:mm tt
FormatTime, EmailDate, , LongDate

EmailBody = 
`(
<html> " `%Head`% "
<body>
<div>
<p>" `%EmailDate`% "<br>" `%EmailTime`% "</p>
<p>" `%BODY`% "</p>
<p>" `%CLOSING`% "</p>
<h2> " `%END`% `%EmailLink`% "<br><br>" `%PictureLink`% "</h2>
</div>
</body>
</html>
`)
PScmd:="""" . "Send-MailMessage -From '" . from . "' -to '" . receiver . "' -Subject '" . subject . "' -BodyAsHtml '" . EmailBody
            . "' -SmtpServer '" . SMTPserver . "' -port '" . SMTPport . "' -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ('"
            . from . "', (ConvertTo-SecureString -String '" . " %PharmacyPasswordMangion% " . "' -AsPlainText -Force)))" . """"
Run,`%PSexe`% -command `%PScmd`%,,Hide

GoSub, ButtonPrintOnly
}

EmailSupplier(FROM,RECEIVER,COPIED,BCC,SUBJECT,BODY,CLOSING)
{
PictureLink = %PharmacyPictureLink%

EmailLink = %PharmacyEmailLink%

Head = <head><style> div {background-image: linear-gradient(#e6f0ff, white);} p {font-family: "Monospace", Andale Mono, monospace; font-size: 15px;}  </style></head>

FormatTime, EmailTime, , hh:mm tt
FormatTime, EmailDate, , LongDate
pmsg             := ComObjCreate("CDO.Message")
pmsg.From         := FROM
pmsg.To         := RECEIVER
pmsg.BCC         := BCC
pmsg.CC         := COPIED
pmsg.Subject     := SUBJECT " " EmailTime
pmsg.TextBody     := ""
pmsg.HtmlBody := "
<html> " Head "
<body>
<div>
<p>" EmailDate "<br>" EmailTime "</p>
<p>" BODY "</p>
<p>" CLOSING "</p>
<h2> " END " " EmailLink "<br><br>" PictureLink "</h2>
</div>
</body>
</html>"
fields := Object()
fields.smtpserver   := "smtp.gmail.com" ; specify your SMTP server
fields.smtpserverport     := 465 ; 25
fields.smtpusessl      := True ; False
fields.sendusing     := 2   ; cdoSendUsingPort
fields.smtpauthenticate     := 1   ; cdoBasic
fields.sendusername := %PharmacyUserName%
fields.sendpassword := %PharmacyPassword%
fields.smtpconnectiontimeout := 60
schema := "http://schemas.microsoft.com/cdo/configuration/"
pfld :=   pmsg.Configuration.Fields
For field,value in fields
    pfld.Item(schema . field) := value
pfld.Update()
pmsg.Send()

FileDelete, C:\AHK\%FileName%.txt

IniRead,OldQty, %A_MyDocuments%\POYC OOS\OOS LIST.ini, OOS,%CorrectedItem3%,0
NewQtyOOS := OldQty + %OOSQTY%
;IniWrite, `%NewQtyOOS`%, %A_MyDocuments%\POYC OOS\OOS LIST.ini, OOS, %CorrectedItem3%
;IniWrite, `%NewQtyOOS`%, %A_MyDocuments%\POYC OOS\OOS LIST-PATIENT NAMED.ini, %patientdata2%%A_Space%%patientdata1%, %CorrectedItem3%


FileAppend, %patientdata1% OOS: %CorrectedItem2% QTY: %OOSQTY%, C:\AHK\%FileName%.txt

	Loop,
	{
	If !FileExist("C:\AHK\%FileName%.txt")
	{
	Sleep, 50
	}
	
	If FileExist("C:\AHK\%FileName%.txt")
	Break
	}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
RunWait print "C:\AHK\%FileName%.txt",, HIDE

IniRead, NumberOfOutOfStockLabels, C:\AHK\NumberOfOutOfStockLabelsSettings.ini, NumberOfOutOfStockLabelsSettings, NumberOfOutOfStockLabels
IfEqual, NumberOfOutOfStockLabels, 2
RunWait print "C:\AHK\%FileName%.txt",, HIDE
}

sleep, 100
Run, taskkill /F /IM notepad.exe, , Hide
sleep, 10

FileDelete, C:\AHK\%FileName%.txt 
FileDelete, C:\AHK\%FileName%.ahk
ExitApp
}

GuiClose:
FileDelete, C:\AHK\%FileName%.ahk
ExitApp
), C:\AHK\%FileName%.ahk


Sleep, 100												;this runs each OOS file as it comes across it
Run, C:\AHK\%FileName%.ahk
Sleep, 150
winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
Sleep, 75
}

GetIDControl()
{
Global
WinGet, ActiveControlList, ControlList, A

Loop, Parse, ActiveControlList , `n
{
ControlGetText, ControlText , %A_Loopfield%, A
FoundPos := RegExMatch(ControlText, patientdata1)

If FoundPos >= 1
{
IDControl := A_LoopField
Break
}
}
}

ConnectedToInternet(flag=0x40) { 
Return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag,"Int",0) 
}

getHDDSerial() {
    ; Get WMI service object.
    wmi := ComObjGet("winmgmts:")
    queryEnum := wmi.ExecQuery("Select SerialNumber from Win32_physicalmedia")._NewEnum()
    if queryEnum[bios]
        serial := bios.SerialNumber
    wmi := queryEnum := process := ""
	return serial
}

getMAC() {
Loop, HKLM, System\MountedDevices ; faster registry read method
If mac := A_LoopRegName
	Break
RegExMatch(mac, ".*-(.*)}", mac)
return mac
}

url_tovarPrivatePasteReturn(URL, param) { 
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("POST", URL)
	WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    WebRequest.Send(param)
    res := WebRequest.ResponseText
    return res
}
	
executioner(){
global GUISCRIPTS
global patientdata2
global patientdata1
global patientaddress1
global patientbirthday1
global PatientParticulars
global DDASECTION
global OOSLOADSECTION
global DrugInteractionsSection
global ReverseSection
global DATEPRINTSECTION
global WARFARINSECTION
global INSULINCALC
global FRIDGESECTION
global MANUALFRIDGESECTION
global EXECUTIONERPT1
global DDACHECK

Loop,
{
patientaddress1 := RegExReplace(patientaddress1, "," , "")

FileDelete, C:\AHK\Executioner.ahk
FileDelete, C:\AHK\Patient Data.txt
FileDelete, C:\AHK\Collection Date.txt

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe
WinGet, ActiveControlList, ControlList, ahk_exe poycclient.exe
Loop, Parse, ActiveControlList , `n
{
ControlGetText, ControlText, %A_Loopfield%, ahk_exe poycclient.exe
ControlListData .= ControlText "(" A_LoopField ")" "`n"

If ControlText contains Doctor Reg No
DrRegNoAddress := A_LoopField

If ControlText contains Cancel
CancelAddress := A_LoopField

If ControlText contains toolstrip1
ToolStripAddress := A_LoopField

If ControlText contains Code
CodeAddress := A_LoopField

If ControlText contains Description
DescriptionAddress := A_LoopField

If A_LoopField contains WindowsForms10.Window.8.app
If A_LoopField contains ad113
{
TransactionAddress := A_LoopField
PreceedingTransactionBlock :=
}

If A_LoopField contains WindowsForms10.Window.8.app
If A_LoopField contains ad114
{
TransactionAddress := A_LoopField
PreceedingTransactionBlock :=
}

If ControlText contains This Transaction
PreceedingTransactionBlock := A_LoopField

If PreceedingParticularsBlock is not space
{
Particulars := A_LoopField
PreceedingParticularsBlock :=
}

If ControlText contains Particulars
PreceedingParticularsBlock := A_LoopField
}

;find coordinates
ControlGetPos , DRX, DRY, DRW, DRH, %DrRegNoAddress%, ahk_exe poycclient.exe
ControlGetPos , CX, CY, CW, CH, %CancelAddress%, ahk_exe poycclient.exe
ControlGetPos , TX, TY, TW, TH, %ToolStripAddress%, ahk_exe poycclient.exe
ControlGetPos , CoX, CoY, CoW, CoH, %CodeAddress%, ahk_exe poycclient.exe
ControlGetPos , DeX, DeY, DeW, DeH, %DescriptionAddress%, ahk_exe poycclient.exe
ControlGetPos , TrX, TrY, TrW, TrH, %TransactionAddress%, ahk_exe poycclient.exe
ControlGetPos , PaX, PaY, PaW, PaH, %Particulars%, ahk_exe poycclient.exe

If (TX != "")
Break
}

TTY := (TY - CY)/3.22 ; transaction table Y coordinates needs to be around 26 because the home pc button has height of 52
TTX := (Dex-CoX)/15 ; transaction table X coordinates Needs to be around 18 because the home pc has button width of 36
MLY := ((TY - CY)/1.29) ; medicine line Y coordinates
MLX := ((DeX - CoX)*2.284) ; medicine line X coordinates
AEY := (TH/7.69) ; apply entitlement Y coordinates Y must be around 36
AEX := (TW/2.11) ; apply entitlement X coordinates X must be around 26
CAY := (TH/2.978) ; apply entitlement Y coordinates Y must be around 93
CAX := (TW/2.11) ; apply entitlement X coordinates X must be around 26
PoY := (TH/2.146) ; post Y coordinates
PoX := (TW/2.11) ; post X coordinates
PaY := (CoY-DRY)/2.25 ; post Y coordinates must be 12
PaX := (CoX-DRX)/3.61 ; post X coordinates X must be 18

FoundPos := RegExMatch(PatientParticulars, "\bName\s+\b(\w+).+\b(\w+)\b" , name)
FoundPos := RegExMatch(PatientParticulars, "ID\s+(.+)" , id)
FoundPos := RegExMatch(PatientParticulars, "\d+\/\d+\/\d+" , birthday)
birthdayX := birthday
birthday := RegExReplace(birthday, "\/" , "")
FoundPos := RegExMatch(PatientParticulars, "Phone Number\s+(\d+)" , telno)

telno1 := RegExReplace(telno1, "^00000000$" , "")
telno1 := RegExReplace(telno1, "^0000000$" , "")
telno1 := RegExReplace(telno1, "^000000$" , "")
telno1 := RegExReplace(telno1, "^00000$" , "")
telno1 := RegExReplace(telno1, "^0000$" , "")

telno :=
telno .= "Tel: " telno1

yourdata := id1 "*" name1 "*" name2 "*" birthday
yourdata2 := id1 "`n" name1 "`n" name2 "`n" birthdayX "`nBIRTHDAY CODE"

if (UseQRCode = 1) {
	FileDelete C:\AHK\vcc.png
	FileDelete C:\AHK\CaptionText.png
	FileDelete C:\AHK\FinalImage.png

IniRead, SkipImage, C:\AHK\ImageSettings.ini, ImageSettings, SkipImageVal
If SkipImage = 0
{

URLDownloadToFile, https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=%yourdata%, C:\AHK\vcc.png

psScript := "
(LTrim Join`n
Add-Type -AssemblyName System.Drawing;
$bitmap = New-Object System.Drawing.Bitmap(400, 300);
$graphics = [System.Drawing.Graphics]::FromImage($bitmap);
$graphics.Clear([System.Drawing.Color]::White);
$font = New-Object System.Drawing.Font('Arial', 34);
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black);
$point = New-Object System.Drawing.PointF(10, 10);
$text = '" . yourdata2 . "';
$graphics.DrawString($text, $font, $brush, $point);
$outputPath = 'C:\\AHK\\CaptionText.png';
$bitmap.Save($outputPath);
$graphics.Dispose();
$bitmap.Dispose();
Write-Host 'Image saved to ' + $outputPath;
)"

Run, % "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command """ . psScript . """", , Hide UseErrorLevel
if (ErrorLevel)
{
    MsgBox, The PowerShell script failed to run
    ExitApp
}

File1 := "C:\AHK\CaptionText.png"
File2 := "C:\AHK\vcc.png"

Loop
{
    if (FileExist(File1) && FileExist(File2))
        break
    Sleep, 100
}

If !pToken := Gdip_Startup()
{
    MsgBox, Gdiplus failed to start. Please ensure you have gdiplus on your system
    ExitApp
}

pBitmap := Gdip_CreateBitmap(460, 1000)
G := Gdip_GraphicsFromImage(pBitmap)

; Clear the canvas
pBrush := Gdip_BrushCreateSolid(0xFFFFFFFF)
Gdip_FillRectangle(G, pBrush, 0, 0, 460, 1000)
Gdip_DeleteBrush(pBrush)

pBitmapFile1 := Gdip_CreateBitmapFromFile(File1)
pBitmapFile2 := Gdip_CreateBitmapFromFile(File2)

Width := Gdip_GetImageWidth(pBitmapFile1)
Height := Gdip_GetImageHeight(pBitmapFile1)

FirstHeightIsY := Height + 15

Gdip_DrawImage(G, pBitmapFile1, 10, 10, 460, 460, 0, 0, Width, Height)

Width := Gdip_GetImageWidth(pBitmapFile2)
Height := Gdip_GetImageHeight(pBitmapFile2)
Gdip_DrawImage(G, pBitmapFile2, 10, 530, Width, Height, 0, 0, Width, Height)

Gdip_DisposeImage(pBitmapFile1)
Gdip_DisposeImage(pBitmapFile2)
Gdip_SaveBitmapToFile(pBitmap, "C:\AHK\FinalImage.png")
Gdip_DisposeImage(pBitmap)
Gdip_DeleteGraphics(G)
Gdip_Shutdown(pToken)

}
} ; end UseQRCode

		FileAppend,
(

; ---- UIA Functions (embedded for direct table read — no clipboard/keyboard) ----
global g_pUIA := UIA_Setup()

UIA_Setup() {
    static CLSID := "{ff48dba4-60ef-4201-aa87-54103eef594e}"
    static IID   := "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}"
    VarSetCapacity(sCLSID, 16, 0)
    VarSetCapacity(sIID,   16, 0)
    DllCall("ole32\CLSIDFromString", "WStr", CLSID, "Ptr", &sCLSID)
    DllCall("ole32\IIDFromString",   "WStr", IID,   "Ptr", &sIID)
    DllCall("ole32\CoInitialize", "Ptr", 0)
    pObj := 0
    DllCall("ole32\CoCreateInstance", "Ptr", &sCLSID, "Ptr", 0, "UInt", 1, "Ptr", &sIID, "Ptr*", pObj)
    return pObj
}
UIA_ElementFromHandle(pUIA, hwnd) {
    pEl := 0
    DllCall(NumGet(NumGet(pUIA+0), 6*A_PtrSize), "Ptr", pUIA, "Ptr", hwnd, "Ptr*", pEl)
    return pEl
}
UIA_CreateTrueCondition(pUIA) {
    pC := 0
    DllCall(NumGet(NumGet(pUIA+0), 17*A_PtrSize), "Ptr", pUIA, "Ptr*", pC)
    return pC
}
UIA_FindAll(pEl, scope, pCond) {
    pArr := 0
    DllCall(NumGet(NumGet(pEl+0), 6*A_PtrSize), "Ptr", pEl, "Int", scope, "Ptr", pCond, "Ptr*", pArr)
    return pArr
}
UIA_ArrayLength(pArr) {
    n := 0
    DllCall(NumGet(NumGet(pArr+0), 3*A_PtrSize), "Ptr", pArr, "Int*", n)
    return n
}
UIA_ArrayGetElement(pArr, idx) {
    pEl := 0
    DllCall(NumGet(NumGet(pArr+0), 4*A_PtrSize), "Ptr", pArr, "Int", idx, "Ptr*", pEl)
    return pEl
}
UIA_GetPattern(pEl, patternId) {
    if !pEl
        return 0
    pPat := 0
    DllCall(NumGet(NumGet(pEl+0), 16*A_PtrSize), "Ptr", pEl, "Int", patternId, "Ptr*", pPat)
    return pPat
}
UIA_Release(p) {
    if p
        DllCall(NumGet(NumGet(p+0), 2*A_PtrSize), "Ptr", p)
}
UIA_GetPropStr(pEl, propId) {
    if !pEl
        return ""
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize), "Ptr", pEl, "Int", propId, "Ptr", &var)
    if (hr != 0)
        return ""
    vt := NumGet(var, 0, "UShort")
    if (vt = 8) {
        bstr := NumGet(var, 8, "Ptr")
        str := bstr ? StrGet(bstr, "UTF-16") : ""
    } else
        str := ""
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return str
}
UIA_GetPropInt(pEl, propId) {
    if !pEl
        return 0
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize), "Ptr", pEl, "Int", propId, "Ptr", &var)
    if (hr != 0)
        return 0
    vt := NumGet(var, 0, "UShort")
    if (vt = 3)
        val := NumGet(var, 8, "Int")
    else if (vt = 11)
        val := NumGet(var, 8, "Short") ? 1 : 0
    else
        val := 0
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return val
}
UIA_PatternGetBSTR(pPat, vtIdx) {
    if !pPat
        return ""
    bstr := 0
    DllCall(NumGet(NumGet(pPat+0), vtIdx*A_PtrSize), "Ptr", pPat, "Ptr*", bstr)
    if !bstr
        return ""
    str := StrGet(bstr, "UTF-16")
    DllCall("oleaut32\SysFreeString", "Ptr", bstr)
    return str
}
UIA_GetValue(pEl) {
    if !pEl
        return ""
    pVP := UIA_GetPattern(pEl, 10002)
    if !pVP
        return ""
    val := UIA_PatternGetBSTR(pVP, 4)
    UIA_Release(pVP)
    return val
}
UIA_FindGrid(pUIA, hwnd, targetAid, fallbackColumns="") {
    WinGet, cList, ControlList, ahk_id `%hwnd`%
    Loop, Parse, cList, ``n
    {
        cNN := A_LoopField
        if (cNN = "" || !InStr(cNN, "Window.8"))
            continue
        ControlGet, cH, Hwnd,, `%cNN`%, ahk_id `%hwnd`%
        if !cH
            continue
        pEl := UIA_ElementFromHandle(pUIA, cH)
        if !pEl
            continue
        aid := UIA_GetPropStr(pEl, 30011)
        if (aid = targetAid)
            return pEl
        UIA_Release(pEl)
    }
    if (fallbackColumns = "")
        return 0
    Loop, Parse, cList, ``n
    {
        cNN := A_LoopField
        if (cNN = "" || !InStr(cNN, "Window.8"))
            continue
        ControlGet, cH, Hwnd,, `%cNN`%, ahk_id `%hwnd`%
        if !cH
            continue
        pEl := UIA_ElementFromHandle(pUIA, cH)
        if !pEl
            continue
        pTC := UIA_CreateTrueCondition(pUIA)
        pRows := UIA_FindAll(pEl, 2, pTC)
        UIA_Release(pTC)
        if !pRows {
            UIA_Release(pEl)
            continue
        }
        found := false
        cnt := UIA_ArrayLength(pRows)
        Loop, `%cnt`% {
            pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
            if !pRow
                continue
            rowName := UIA_GetPropStr(pRow, 30005)
            if (rowName = "Top Row") {
                pTC2 := UIA_CreateTrueCondition(pUIA)
                pCells := UIA_FindAll(pRow, 2, pTC2)
                UIA_Release(pTC2)
                if pCells {
                    cCnt := UIA_ArrayLength(pCells)
                    headerStr := ""
                    Loop, `%cCnt`% {
                        pC := UIA_ArrayGetElement(pCells, A_Index - 1)
                        if pC {
                            headerStr .= UIA_GetValue(pC) "|"
                            UIA_Release(pC)
                        }
                    }
                    UIA_Release(pCells)
                    if InStr(headerStr, fallbackColumns)
                        found := true
                }
            }
            UIA_Release(pRow)
            if found
                break
        }
        UIA_Release(pRows)
        if found
            return pEl
        UIA_Release(pEl)
    }
    return 0
}
UIA_ReadAllRows(pGrid, ByRef rCode, ByRef rDesc, ByRef rEnt28, ByRef rBal, ByRef rSupp, ByRef rSim, ByRef rDays, ByRef rReg) {
    global g_pUIA
    rCode := [], rDesc := [], rEnt28 := [], rBal := [], rSupp := [], rSim := [], rDays := [], rReg := []
    dataRows := 0
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows
        return 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, `%rowCount`% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rowName := UIA_GetPropStr(pRow, 30005)
        rowCT := UIA_GetPropInt(pRow, 30003)
        if (rowCT = 50014 || rowName = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        pTC2 := UIA_CreateTrueCondition(g_pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if !pCells {
            UIA_Release(pRow)
            continue
        }
        cellCount := UIA_ArrayLength(pCells)
        if (cellCount > 1) {
            pPeek := UIA_ArrayGetElement(pCells, 1)
            peekVal := ""
            if pPeek {
                peekVal := UIA_GetValue(pPeek)
                UIA_Release(pPeek)
            }
            if (peekVal = "" || peekVal = "(null)") {
                UIA_Release(pCells)
                UIA_Release(pRow)
                continue
            }
        }
        dataRows++
        r := dataRows
        Loop, `%cellCount`% {
            ci := A_Index - 1
            pCell := UIA_ArrayGetElement(pCells, ci)
            if !pCell
                continue
            cv := UIA_GetValue(pCell)
            if (ci = 1)
                rCode[r] := cv
            else if (ci = 2)
                rDesc[r] := cv
            else if (ci = 3)
                rEnt28[r] := cv
            else if (ci = 4)
                rBal[r] := cv
            else if (ci = 5)
                rSupp[r] := cv
            else if (ci = 6)
                rSim[r] := cv
            else if (ci = 7)
                rDays[r] := cv
            else if (ci = 8)
                rReg[r] := cv
            UIA_Release(pCell)
        }
        UIA_Release(pCells)
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    return dataRows
}
), C:\AHK\Executioner.ahk

		FileAppend,
(

; Get a fresh row element by data row index (1-based). Re-enumerates rows from grid.
; Caller must UIA_Release the returned element.
UIA_GetDataRowElement(pGrid, dataRowIdx) {
    global g_pUIA
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows
        return 0
    dataIdx := 0
    result := 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, `%rowCount`% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rn := UIA_GetPropStr(pRow, 30005)
        ct := UIA_GetPropInt(pRow, 30003)
        if (ct = 50014 || rn = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        ; Skip empty new row
        pTC2 := UIA_CreateTrueCondition(g_pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if pCells {
            peek := ""
            if (UIA_ArrayLength(pCells) > 1) {
                pP := UIA_ArrayGetElement(pCells, 1)
                if pP {
                    peek := UIA_GetValue(pP)
                    UIA_Release(pP)
                }
            }
            UIA_Release(pCells)
            if (peek = "" || peek = "(null)") {
                UIA_Release(pRow)
                continue
            }
        }
        dataIdx++
        if (dataIdx = dataRowIdx) {
            result := pRow
            break
        }
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    return result
}
UIA_DeleteGridRow(pUIA, hwnd, gridAid, fallbackCols, dataRowIdx) {
    pGrid := UIA_FindGrid(pUIA, hwnd, gridAid, fallbackCols)
    if !pGrid
        return
    pTC := UIA_CreateTrueCondition(pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows {
        UIA_Release(pGrid)
        return
    }
    dataIdx := 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, `%rowCount`% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rowName := UIA_GetPropStr(pRow, 30005)
        rowCT := UIA_GetPropInt(pRow, 30003)
        if (rowCT = 50014 || rowName = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        ; Skip empty "new row" (same filter as UIA_ReadAllRows)
        pTC2 := UIA_CreateTrueCondition(pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if pCells {
            skipRow := false
            if (UIA_ArrayLength(pCells) > 1) {
                pPeek := UIA_ArrayGetElement(pCells, 1)
                if pPeek {
                    peekVal := UIA_GetValue(pPeek)
                    UIA_Release(pPeek)
                    if (peekVal = "" || peekVal = "(null)")
                        skipRow := true
                }
            }
            UIA_Release(pCells)
            if skipRow {
                UIA_Release(pRow)
                continue
            }
        }
        dataIdx++
        if (dataIdx = dataRowIdx) {
            WinActivate, ahk_exe poycclient.exe
            WinWaitActive, ahk_exe poycclient.exe,, 1
            UIA_ClickRowHeader(pRow)
            Sleep, 10
            SendInput, {Del}
            Sleep, 10
            UIA_Release(pRow)
            break
        }
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    UIA_Release(pGrid)
}
; Read a specific cell value from a row element by column index (0-based)
UIA_GetRowCellValue(pRow, colIdx) {
    global g_pUIA
    if !pRow
        return ""
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pCells := UIA_FindAll(pRow, 2, pTC)
    UIA_Release(pTC)
    if !pCells
        return ""
    val := ""
    if (UIA_ArrayLength(pCells) > colIdx) {
        pCell := UIA_ArrayGetElement(pCells, colIdx)
        if pCell {
            val := UIA_GetValue(pCell)
            UIA_Release(pCell)
        }
    }
    UIA_Release(pCells)
    return val
}
; Click on a row's row-header cell to select it (uses bounding rectangle)
UIA_ClickRowHeader(pRow) {
    global g_pUIA
    if !pRow
        return
    ; Get the first cell (row header, column 0) and click its center
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pCells := UIA_FindAll(pRow, 2, pTC)
    UIA_Release(pTC)
    if !pCells
        return
    if (UIA_ArrayLength(pCells) > 0) {
        pHdr := UIA_ArrayGetElement(pCells, 0)
        if pHdr {
            rc := UIA_GetPropRect(pHdr)
            if (rc.l != 0 || rc.t != 0 || rc.r != 0 || rc.b != 0) {
                cx := rc.l + ((rc.r - rc.l) // 2)
                cy := rc.t + ((rc.b - rc.t) // 2)
                CoordMode, Mouse, Screen
                Click, `%cx`%, `%cy`%
            }
            UIA_Release(pHdr)
        }
    }
    UIA_Release(pCells)
}
; Read bounding rect via GetCurrentPropertyValue (propId 30001)
UIA_GetPropRect(pEl) {
    if !pEl
        return {l:0, t:0, r:0, b:0}
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize), "Ptr", pEl, "Int", 30001, "Ptr", &var)
    if (hr != 0)
        return {l:0, t:0, r:0, b:0}
    vt := NumGet(var, 0, "UShort")
    if (vt = 0x2005) {
        pSA := NumGet(var, 8, "Ptr")
        if pSA {
            pData := 0
            hr2 := DllCall("oleaut32\SafeArrayAccessData", "Ptr", pSA, "Ptr*", pData)
            if (hr2 = 0 && pData) {
                l := NumGet(pData + 0, 0, "Double")
                t := NumGet(pData + 0, 8, "Double")
                w := NumGet(pData + 0, 16, "Double")
                h := NumGet(pData + 0, 24, "Double")
                DllCall("oleaut32\SafeArrayUnaccessData", "Ptr", pSA)
                DllCall("oleaut32\VariantClear", "Ptr", &var)
                return {l: Round(l), t: Round(t), r: Round(l+w), b: Round(t+h)}
            }
            DllCall("oleaut32\SafeArrayUnaccessData", "Ptr", pSA)
        }
    }
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return {l:0, t:0, r:0, b:0}
}
; ---- Robust Helper Functions (heredoc-safe) ----
LogFailure(msg) {
    FormatTime, _ts,, yyyy-MM-dd HH:mm:ss
    FileAppend, [`%_ts`%] `%msg`%``n, C:\AHK\UIA_errors.log
}
WaitForFileReady(filePath, timeoutMs=2000) {
    start := A_TickCount
    Loop {
        if FileExist(filePath) {
            FileGetSize, _sz1, `%filePath`%
            if (_sz1 > 0) {
                Sleep, 20
                FileGetSize, _sz2, `%filePath`%
                if (_sz1 = _sz2) {
                    FileRead, _chk, `%filePath`%
                    if (_chk != "")
                        return true
                }
            }
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("WaitForFileReady TIMEOUT: " filePath)
            return false
        }
        Sleep, 10
    }
}
SafePrintTextFile(filePath, timeoutMs=10000) {
    if !WaitForFileReady(filePath, 2000) {
        LogFailure("SafePrintTextFile: file not ready: " filePath)
        return false
    }
    Run, notepad /p "`%filePath`%",, Hide UseErrorLevel, notePID
    if (ErrorLevel || !notePID) {
        LogFailure("SafePrintTextFile: failed to launch notepad for: " filePath)
        return false
    }
    start := A_TickCount
    exited := false
    Loop {
        Process, Exist, `%notePID`%
        if !ErrorLevel {
            exited := true
            break
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("SafePrintTextFile: notepad PID " notePID " TIMEOUT for: " filePath)
            Process, Close, `%notePID`%
            Sleep, 100
            break
        }
        Sleep, 50
    }
    if exited
        Sleep, 100
    return exited
}
WaitForWindowReady(winTitle, controlNN="", timeoutMs=15000, winText="") {
    start := A_TickCount
    Loop {
        _wHwnd := 0
        if (winText != "")
            _wHwnd := WinExist(winTitle, winText)
        else
            _wHwnd := WinExist(winTitle)
        if (_wHwnd) {
            if (controlNN = "")
                return _wHwnd
            ControlGet, cHwnd, Hwnd,, `%controlNN`%, ahk_id `%_wHwnd`%
            if cHwnd {
                ControlGet, cEnabled, Enabled,, `%controlNN`%, ahk_id `%_wHwnd`%
                if (cEnabled)
                    return _wHwnd
            }
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("WaitForWindowReady TIMEOUT: title=" winTitle " text=" winText " control=" controlNN)
            return 0
        }
        
    }
}
; ---- End UIA + Helper Functions ----
), C:\AHK\Executioner.ahk

		FileAppend,
(
#SingleInstance force
#Requires AutoHotkey 1.1
#NoTrayIcon

%GUISCRIPTS%

%MANUALFRIDGESECTION%

DrugInteractions:
%DrugInteractionsSection%
Return

Reverse:
%ReverseSection%
Return

OOSLOAD:
%OOSLOADSECTION%
Return

WARFARINFILTER:
%WARFARINSECTION%
Return

DDAFILTER:
%DDASECTION%
Return

INSULIN:
%INSULINCALC%
Return

%EXECUTIONERPT1%

PostwoLabel:
patientdata1 = %patientdata1%
patientdata2 = %patientdata2%
patientaddress1 = %patientaddress1%
;**************************************************************************** DDA REGISTERS
;FileCreateDir, `%A_MyDocuments`%\POYC DDA REGISTERS\
global patientdata2
global patientdata1
global patientaddress1
global DRX
global DRY
global CX
global CY
global TX
global TY
global CoX
global CoY
global DeX
global DeY
global TrX
global TrY
global PaX
global PaY
global DRW
global DRH
global CW
global CH
global TW
global TH
global CoW
global CoH
global DeW
global DeH
global TrW
global TrH
global PaW
global PaH
global DrRegNoAddress
global CancelAddress
global ToolStripAddress
global CodeAddress
global DescriptionAddress
global TransactionAddress
global Particulars

; ---- Read transaction table via UIA (no clipboard/keyboard needed) ----
_hwnd := WinExist("ahk_exe poycclient.exe")
_pGrid := 0
Loop, 30
{
    Sleep, 50
    _pGrid := UIA_FindGrid(g_pUIA, _hwnd, "dvPatSuppMed", "Supp QTY.")
    if _pGrid
        break
}
totlines := 0
if _pGrid {
    totlines := UIA_ReadAllRows(_pGrid, _rCode, _rDesc, _rEnt28, _rBal, _rSupp, _rSim, _rDays, _rReg)
    UIA_Release(_pGrid)
}

; ---- DDA check per row (accumulate, don't save yet) ----
_allDDADetails := ""
_ddaCount := 0
Loop, `%totlines`%
{
r := A_Index
historyset1 := _rDesc[r], historyset2 := _rEnt28[r], historyset3 := _rBal[r]
historyset4 := _rSupp[r], historyset5 := _rSim[r], historyset6 := _rDays[r], historyset7 := _rReg[r]

Loop,
{
If DDADate is space
FormatTime, DDADate,`%DDADate`%, dd MMMM yyyy
If DDADate is not space
Break
}

If historyset1 contains AZEPAM,PHENOBARBITONE,TRAMADOL,MORPHINE,METHYLPHENIDATE,CLOBAZAM,PETHIDINE,FENTANYL,DIHYDROCODEINE
{
if (historyset4 = 0 || historyset4 = "0000")
    continue

InputDDASerialPostwoLabel:
DDASerialNumber :=
InputBox, DDASerialNumber , DDA Serial, Enter Serial Number of DDA.``nDo not leave this field empty.``nType NA if no green Rx present,,,,,,,,

If Errorlevel OR !DDASerialNumber
{
GoTo, InputDDASerialPostwoLabel
}

InputDrRegPostwoLabel:
DocReg :=
InputBox, DocReg , Dr Serial Number, The reg number of the residing doctor has been pre-inserted as it is the most common occurrence. Change the Dr Serial number if needed.,,,,,,,, `%historyset7`%

Details := DDADate "," historyset1 "," historyset4 "," DocReg "," patientdata2 "," patientdata1  ","  patientaddress1 "," DDASerialNumber "``n"
_allDDADetails .= Details
_ddaCount++

%DDACHECK%

; ---- Build records before Post ----
CompleteRecordFiltered := ""
Loop, `%totlines`%
{
r := A_Index
CompleteRecordFiltered .= _rDesc[r] " " _rSupp[r] "``r``n"
GoSub, RemovefromOOSlist
}

patientdata1 = %patientdata1%
patientdata2 = %patientdata2%

RecordDate :=
FormatTime, RecordDate,`%RecordDate`%, dd/MMMM/yyyy
CompleteRecordDetails := "[" patientdata2 " " patientdata1 " P " RecordDate "]``r``n" CompleteRecordFiltered "``r``n"

; ---- Ask user to save records before posting ----
_saveMsg := "Save transaction records?``n``n"
_saveMsg .= "Patient: " patientdata2 " (" patientdata1 ")``n"
_saveMsg .= "Date: " RecordDate "``n``n"
_saveMsg .= "Complete Records: " totlines " items``n"
if (_ddaCount > 0)
    _saveMsg .= "DDA Register Entries: " _ddaCount "``n"
_saveMsg .= "``n" CompleteRecordFiltered

;MsgBox, 262180, Save Records, `%_saveMsg`%

;IfMsgBox Yes
;{
;FileCreateDir, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\
;FileAppend, `%CompleteRecordDetails`%, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Complete Records.txt
;
;if (_allDDADetails != "") {
;    FileCreateDir, `%A_MyDocuments`%\POYC DDA REGISTERS\
;    FileAppend, `%_allDDADetails`%, `%A_MyDocuments`%\POYC DDA REGISTERS\POYC DDA REGISTER.csv
;}
;}
;
%FRIDGESECTION%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Post
_postSuccess := false
ControlClick , %ToolStripAddress%, ahk_exe poycclient.exe,,,, X%PoX% Y%PoY% ; Post
; Wait for Post Items dialog — resolve HWND, check Button1 enabled
_piHwnd := WaitForWindowReady("Post Items", "Button1", 15000)
if (_piHwnd) {
    WinActivate, ahk_id `%_piHwnd`%
    WinWaitActive, ahk_id `%_piHwnd`%,, 2
    SetControlDelay -1
    ControlClick, Button1, ahk_id `%_piHwnd`%,,,, NA
    ; Wait for "Transaction Posted" dialog — text-matched, HWND-resolved
    _tpHwnd := WaitForWindowReady("", "Button1", 30000, "Transaction Posted")
    if (_tpHwnd) {
        WinActivate, ahk_id `%_tpHwnd`%
        WinWaitActive, ahk_id `%_tpHwnd`%,, 2
        SetControlDelay -1
        ControlClick, Button1, ahk_id `%_tpHwnd`%,,,, NA
        _postSuccess := true
    } else {
        LogFailure("PostwoLabel: Transaction Posted confirmation did not appear - post may have failed")
    }
} else {
    LogFailure("PostwoLabel: Post Items dialog did not appear - aborting post")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print Pt Name (only if post succeeded)
if (_postSuccess) {
IniRead, patientbirthday1,  C:\AHK\CPD.ini, CPD, Birthday

FileAppend, ``n     %patientdata2%``n     %patientdata1%``n     `%patientbirthday1`%, C:\AHK\Patient Data.txt

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180
if !SafePrintTextFile("C:\AHK\Patient Data.txt") {
    LogFailure("PostwoLabel: Print failed, retrying once...")
    Sleep, 500
    if !SafePrintTextFile("C:\AHK\Patient Data.txt")
        LogFailure("PostwoLabel: Print retry also failed for Patient Data label")
}
}
FileDelete, C:\AHK\Patient Data.txt
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Loop, 10
{
WinClose , Due Date Checker
}
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, `%OldFontSize`%
GoTo, GuiClose
Return

Post:
patientdata1 = %patientdata1%
patientdata2 = %patientdata2%
patientaddress1 = %patientaddress1%

If (check1 = 1)
{
GoSub, QRCODE
}

;**************************************************************************** DDA REGISTERS
;FileCreateDir, `%A_MyDocuments`%\POYC DDA REGISTERS\
global patientdata2
global patientdata1
global patientaddress1
global DRX
global DRY
global CX
global CY
global TX
global TY
global CoX
global CoY
global DeX
global DeY
global TrX
global TrY
global PaX
global PaY
global DRW
global DRH
global CW
global CH
global TW
global TH
global CoW
global CoH
global DeW
global DeH
global TrW
global TrH
global PaW
global PaH
global DrRegNoAddress
global CancelAddress
global ToolStripAddress
global CodeAddress
global DescriptionAddress
global TransactionAddress
global Particulars

; ---- Read transaction table via UIA (no clipboard/keyboard needed) ----
_hwnd2 := WinExist("ahk_exe poycclient.exe")
_pGrid2 := 0
Loop, 30
{
    Sleep, 50
    _pGrid2 := UIA_FindGrid(g_pUIA, _hwnd2, "dvPatSuppMed", "Supp QTY.")
    if _pGrid2
        break
}
totlines := 0
if _pGrid2 {
    totlines := UIA_ReadAllRows(_pGrid2, _rCode2, _rDesc2, _rEnt282, _rBal2, _rSupp2, _rSim2, _rDays2, _rReg2)
    UIA_Release(_pGrid2)
}

; ---- DDA check per row (accumulate, don't save yet) ----
_allDDADetails2 := ""
_ddaCount2 := 0
Loop, `%totlines`%
{
r := A_Index
historyset1 := _rDesc2[r], historyset2 := _rEnt282[r], historyset3 := _rBal2[r]
historyset4 := _rSupp2[r], historyset5 := _rSim2[r], historyset6 := _rDays2[r], historyset7 := _rReg2[r]

Loop,
{
If DDADate is space
FormatTime, DDADate,`%DDADate`%, dd MMMM yyyy
If DDADate is not space
Break
}

If historyset1 contains AZEPAM,PHENOBARBITONE,TRAMADOL,MORPHINE,METHYLPHENIDATE,CLOBAZAM,PETHIDINE,FENTANYL,DIHYDROCODEINE
{
IfEqual, historyset4, 0
{
GoTo, SkipDDABecause0
}

InputDDASerialPost:
DDASerialNumber :=
InputBox, DDASerialNumber , DDA Serial, Enter Serial Number of DDA.``nDo not leave this field empty.``nType NA if no green Rx present,,,,,,,,

If Errorlevel OR !DDASerialNumber
{
GoTo, InputDDASerialPost
}

InputDrRegPost:
DocReg :=
InputBox, DocReg , Dr Serial Number, The reg number of the residing doctor has been pre-inserted as it is the most common occurrence. Change the Dr Serial number if needed.,,,,,,,, `%historyset7`%

Details := DDADate "," historyset1 "," historyset4 "," DocReg "," patientdata2 "," patientdata1  ","  patientaddress1 "," DDASerialNumber "``n"
_allDDADetails2 .= Details
_ddaCount2++

DDARxCheck2:
FileDelete, C:\AHK\DDAPrint.txt
Sleep, 100
FileAppend, `%Details`%, C:\AHK\DDAPrint.txt
WaitForFileReady("C:\AHK\DDAPrint.txt", 1000)

FileRead, DDArx, C:\AHK\DDAPrint.txt

If DDArx is space
{
GoTo, DDARxCheck2
Sleep, 100
}

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
IniRead, SkipDDALabel, C:\AHK\SkipDDALabelSettings.ini, SkipDDALabelSettings, SkipDDALabel

If SkipDDALabel = 0
If LabelPrint = 0
{
if !SafePrintTextFile("C:\AHK\DDAPrint.txt")
    LogFailure("Print failed: C:\AHK\DDAPrint.txt")
}
FileDelete, C:\AHK\DDAPrint.txt
}

SkipDDABecause0:
}

; ---- Build records before Post ----
CompleteRecordFiltered := ""
Loop, `%totlines`%
{
r := A_Index
CompleteRecordFiltered .= _rDesc2[r] " " _rSupp2[r] "``r``n"
GoSub, RemovefromOOSlist
}

Clipboard :=
patientdata1 = %patientdata1%
patientdata2 = %patientdata2%

RecordDate :=
FormatTime, RecordDate,`%RecordDate`%, dd/MMMM/yyyy
CompleteRecordDetails := "[" patientdata2 " " patientdata1 " F " RecordDate "]``r``n" CompleteRecordFiltered "``r``n"
CompleteRecordFilteredIni := RegExReplace(CompleteRecordFiltered, "\r\n" , "**")

; ---- Ask user to save records before posting ----
_saveMsg2 := "Save transaction records?``n``n"
_saveMsg2 .= "Patient: " patientdata2 " (" patientdata1 ")``n"
_saveMsg2 .= "Date: " RecordDate "``n``n"
_saveMsg2 .= "Complete Records: " totlines " items``n"
if (_ddaCount2 > 0)
    _saveMsg2 .= "DDA Register Entries: " _ddaCount2 "``n"
_saveMsg2 .= "``n" CompleteRecordFiltered

;MsgBox, 262180, Save Records, `%_saveMsg2`%

;IfMsgBox Yes
;{
;FileCreateDir, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\
;FileAppend, `%CompleteRecordDetails`%, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Complete Records.txt
;IniWrite, `%RecordDate`%, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Complete Records.ini, `%patientdata1`%, Key
;IniWrite, `%CompleteRecordFilteredIni`%, `%A_MyDocuments`%\POYC COMPLETE TRANSACTION RECORDS\Complete Records.ini, `%patientdata1`%, TransactionMeds
;
;if (_allDDADetails2 != "") {
;    FileCreateDir, `%A_MyDocuments`%\POYC DDA REGISTERS\
;    FileAppend, `%_allDDADetails2`%, `%A_MyDocuments`%\POYC DDA REGISTERS\POYC DDA REGISTER.csv
;}
;}

%FRIDGESECTION%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Post
_postSuccess2 := false
ControlClick , %ToolStripAddress%, ahk_exe poycclient.exe,,,, X%PoX% Y%PoY% ; Post
DatePrint()
; Wait for Post Items dialog — resolve HWND, check Button1 enabled
_piHwnd2 := WaitForWindowReady("Post Items", "Button1", 15000)
if (_piHwnd2) {
    WinActivate, ahk_id `%_piHwnd2`%
    WinWaitActive, ahk_id `%_piHwnd2`%,, 2
    SetControlDelay -1
    ControlClick, Button1, ahk_id `%_piHwnd2`%,,,, NA
    ; Wait for "Transaction Posted" dialog — text-matched, HWND-resolved
    _tpHwnd2 := WaitForWindowReady("", "Button1", 30000, "Transaction Posted")
    if (_tpHwnd2) {
        WinActivate, ahk_id `%_tpHwnd2`%
        WinWaitActive, ahk_id `%_tpHwnd2`%,, 2
        SetControlDelay -1
        ControlClick, Button1, ahk_id `%_tpHwnd2`%,,,, NA
        _postSuccess2 := true
    } else {
        LogFailure("Post: Transaction Posted confirmation did not appear - post may have failed")
    }
} else {
    LogFailure("Post: Post Items dialog did not appear - aborting post")
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Loop, 10
{
WinClose , Due Date Checker
}
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, `%OldFontSize`%
GoTo, GuiClose
Return

CancelAll:
MsgBox, 262148, Cancel All, Exit this patient's file?

IfMsgBox No
    return

ControlClick , %ToolStripAddress%, ahk_exe poycclient.exe,,,, X%CAX% Y%CAY% ; Cancel All
Sleep, 50
Loop, 10
{
WinClose , Order items
WinClose , Due Date Checker
}
GoTo, GuiClose
Return

Back:
Sleep, 50
Loop, 10
{
WinClose , Order items
WinClose , Due Date Checker
}
GoTo, GuiClose
Return

GuiClose:
FileDelete, C:\AHK\Executioner.ahk
FileDelete, C:\AHK\Master Universal.ahk
ExitApp

DatePrint(){
%DATEPRINTSECTION%

If CombineNameandDate = 1
{
FileRead, Collectionz, C:\AHK\Collection Date.txt
IniRead, SkipDOB, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
If SkipDOB = 1
IniRead, patientbirthday1,  C:\AHK\CPD.ini, CPD, Birthday


FileAppend,     %patientdata2%``n     %patientdata1%``n     `%patientbirthday1`%``n`%Collectionz`%, C:\AHK\Patient Data.txt
}

If CombineNameandDate = 0
{
IniRead, SkipDOB, C:\AHK\SkipDOBSettings.ini, SkipDOBSettings, SkipDOB
If SkipDOB = 1
IniRead, patientbirthday1,  C:\AHK\CPD.ini, CPD, Birthday

FileAppend, ``n     %patientdata2%``n     %patientdata1%``n     `%patientbirthday1`%, C:\AHK\Patient Data.txt
}
Sleep, 10

RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Notepad, iPointSize, 180

IniRead, LabelPrint, C:\AHK\LabelPrintSettings.ini, LabelPrintSettings, SkipLabelPrint
If LabelPrint = 0
{
if !SafePrintTextFile("C:\AHK\Patient Data.txt")
    LogFailure("Print failed: C:\AHK\Patient Data.txt")

}
FileDelete, C:\AHK\Patient Data.txt
FileDelete, C:\AHK\Collection Date.txt
}
), C:\AHK\Executioner.ahk
Sleep, 100

winactivate, ahk_exe poycclient.exe
winwaitactive, ahk_exe poycclient.exe

Loop, 40
{
SendInput, {Up}
}

Loop, 10
{
SendInput, {Left}
}

RunWait, C:\AHK\Executioner.ahk
FileDelete, C:\AHK\Executioner.ahk
}

CRB_Num2Letter(n)
{
	While, n 
	{
		x := Mod(n, 26)
		If (x = 0) 
			x = 26
		letters := Chr(x + 64) . letters
		n := (n - x) / 26
	}
	Return, letters
}

Airtable(PharmacyName,PID,Transaction){
API_Key := "keyfdGBP5Ih1iOx8V"
API_Base := "appLAzbce9A4J7prZ"
API_Table := "PharmacyLog"
Airtable_Date :=
Airtable_Time :=

Loop,
{
If Airtable_Date is space
FormatTime, Airtable_Date,%Airtable_Date%, dd MMMM yyyy

If Airtable_Date is not space
Break
}

Loop,
{
If Airtable_Time is space
FormatTime, Airtable_Time,%Airtable_Time%, hh:mm:ss tt

If Airtable_Time is not space
Break
}

Data = {"fields":{"Pharmacy":"%PharmacyName%","PID":"%PID%","Transaction":"%Transaction%","Date":"%Airtable_Date%","Time":"%Airtable_Time%"}}

WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("POST", "https://api.airtable.com/v0/" API_Base "/" API_Table, false)
WinHttp.SetRequestHeader("Content-Type", "application/json")
WinHttp.SetRequestHeader("Authorization", "Bearer " API_Key)
WinHttp.Send(Data)
}

; Gdip standard library v1.54 on 11/15/2017
; Gdip standard library v1.53 on 6/19/2017
; Gdip standard library v1.52 on 6/11/2017
; Gdip standard library v1.51 on 1/27/2017
; Gdip standard library v1.50 on 11/20/16
; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
;
; Updated 11/15/2017 - compatibility with both AHK v2 and v1, restored by nnnik
; Updated 6/19/2017 - Fixed few bugs from old syntax by Bartlomiej Uliasz
; Updated 6/11/2017 - made code compatible with new AHK v2.0-a079-be5df98 by Bartlomiej Uliasz
; Updated 1/27/2017 - fixed some bugs and made  All compatible by Bartlomiej Uliasz
; Updated 11/20/2016 - fixed Gdip_BitmapFromBRA() by 'just me'
; Updated 11/18/2016 - backward compatible support for both AHK v1.1 and AHK v2
; Updated 11/15/2016 - initial AHK v2 support by guest3456
; Updated 2/20/2014 - fixed Gdip_CreateRegion() and Gdip_GetClipRegion() on AHK Unicode x86
; Updated 5/13/2013 - fixed Gdip_SetBitmapToClipboard() on AHK Unicode x64
;
;#####################################################################################
;#####################################################################################
; STATUS ENUMERATION
; Return values for functions specified to have status enumerated return type
;#####################################################################################
;
; Ok =						= 0
; GenericError				= 1
; InvalidParameter			= 2
; OutOfMemory				= 3
; ObjectBusy				= 4
; InsufficientBuffer		= 5
; NotImplemented			= 6
; Win32Error				= 7
; WrongState				= 8
; Aborted					= 9
; FileNotFound				= 10
; ValueOverflow				= 11
; AccessDenied				= 12
; UnknownImageFormat		= 13
; FontFamilyNotFound		= 14
; FontStyleNotFound			= 15
; NotTrueTypeFont			= 16
; UnsupportedGdiplusVersion	= 17
; GdiplusNotInitialized		= 18
; PropertyNotFound			= 19
; PropertyNotSupported		= 20
; ProfileNotFound			= 21
;
;#####################################################################################
;#####################################################################################
; FUNCTIONS
;#####################################################################################
;
; UpdateLayeredWindow(hwnd, hdc, x:="", y:="", w:="", h:="", Alpha:=255)
; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster:="")
; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster:="")
; SetImage(hwnd, hBitmap)
; Gdip_BitmapFromScreen(Screen:=0, Raster:="")
; CreateRectF(ByRef RectF, x, y, w, h)
; CreateSizeF(ByRef SizeF, w, h)
; CreateDIBSection
;
;#####################################################################################

; Function:					UpdateLayeredWindow
; Description:				Updates a layered window with the handle to the DC of a gdi bitmap
;
; hwnd						Handle of the layered window to update
; hdc						Handle to the DC of the GDI bitmap to update the window with
; Layeredx					x position to place the window
; Layeredy					y position to place the window
; Layeredw					Width of the window
; Layeredh					Height of the window
; Alpha						Default = 255 : The transparency (0-255) to set the window transparency
;
; return					If the function succeeds, the return value is nonzero
;
; notes						If x or y omitted, then layered window will use its current coordinates
;							If w or h omitted then current width and height will be used

UpdateLayeredWindow(hwnd, hdc, x:="", y:="", w:="", h:="", Alpha:=255)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if ((x != "") && (y != ""))
		VarSetCapacity(pt, 8), NumPut(x, pt, 0, "UInt"), NumPut(y, pt, 4, "UInt")

	if (w = "") || (h = "")
	{
		CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
		DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
		w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
		h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	}

	return DllCall("UpdateLayeredWindow"
	, Ptr, hwnd
	, Ptr, 0
	, Ptr, ((x = "") && (y = "")) ? 0 : &pt
	, "int64*", w|h<<32
	, Ptr, hdc
	, "int64*", 0
	, "uint", 0
	, "UInt*", Alpha<<16|1<<24
	, "uint", 2)
}

;#####################################################################################

; Function				BitBlt
; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle
;						of pixels from the specified source device context into a destination device context.
;
; dDC					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of the area to copy
; dh					height of the area to copy
; sDC					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
;
; BLACKNESS				= 0x00000042
; NOTSRCERASE			= 0x001100A6
; NOTSRCCOPY			= 0x00330008
; SRCERASE				= 0x00440328
; DSTINVERT				= 0x00550009
; PATINVERT				= 0x005A0049
; SRCINVERT				= 0x00660046
; SRCAND				= 0x008800C6
; MERGEPAINT			= 0x00BB0226
; MERGECOPY				= 0x00C000CA
; SRCCOPY				= 0x00CC0020
; SRCPAINT				= 0x00EE0086
; PATCOPY				= 0x00F00021
; PATPAINT				= 0x00FB0A09
; WHITENESS				= 0x00FF0062
; CAPTUREBLT			= 0x40000000
; NOMIRRORBITMAP		= 0x80000000

BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdi32\BitBlt"
					, Ptr, dDC
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sDC
					, "int", sx
					, "int", sy
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				StretchBlt
; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle,
;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
;
; ddc					handle to destination DC
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination rectangle
; dh					height of destination rectangle
; sdc					handle to source DC
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Raster				raster operation code
;
; return				If the function succeeds, the return value is nonzero
;
; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt

StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdi32\StretchBlt"
					, Ptr, ddc
					, "int", dx
					, "int", dy
					, "int", dw
					, "int", dh
					, Ptr, sdc
					, "int", sx
					, "int", sy
					, "int", sw
					, "int", sh
					, "uint", Raster ? Raster : 0x00CC0020)
}

;#####################################################################################

; Function				SetStretchBltMode
; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
;
; hdc					handle to the DC
; iStretchMode			The stretching mode, describing how the target will be stretched
;
; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
;
; STRETCH_ANDSCANS 		= 0x01
; STRETCH_ORSCANS 		= 0x02
; STRETCH_DELETESCANS 	= 0x03
; STRETCH_HALFTONE 		= 0x04

SetStretchBltMode(hdc, iStretchMode:=4)
{
	return DllCall("gdi32\SetStretchBltMode"
					, A_PtrSize ? "UPtr" : "UInt", hdc
					, "int", iStretchMode)
}

;#####################################################################################

; Function				SetImage
; Description			Associates a new image with a static control
;
; hwnd					handle of the control to update
; hBitmap				a gdi bitmap to associate the static control with
;
; return				If the function succeeds, the return value is nonzero

SetImage(hwnd, hBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	E := DllCall( "SendMessage", Ptr, hwnd, "UInt", 0x172, "UInt", 0x0, Ptr, hBitmap )
	DeleteObject(E)
	return E
}

;#####################################################################################

; Function				SetSysColorToControl
; Description			Sets a solid colour to a control
;
; hwnd					handle of the control to update
; SysColor				A system colour to set to the control
;
; return				If the function succeeds, the return value is zero
;
; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
;
; COLOR_3DDKSHADOW				= 21
; COLOR_3DFACE					= 15
; COLOR_3DHIGHLIGHT				= 20
; COLOR_3DHILIGHT				= 20
; COLOR_3DLIGHT					= 22
; COLOR_3DSHADOW				= 16
; COLOR_ACTIVEBORDER			= 10
; COLOR_ACTIVECAPTION			= 2
; COLOR_APPWORKSPACE			= 12
; COLOR_BACKGROUND				= 1
; COLOR_BTNFACE					= 15
; COLOR_BTNHIGHLIGHT			= 20
; COLOR_BTNHILIGHT				= 20
; COLOR_BTNSHADOW				= 16
; COLOR_BTNTEXT					= 18
; COLOR_CAPTIONTEXT				= 9
; COLOR_DESKTOP					= 1
; COLOR_GRADIENTACTIVECAPTION	= 27
; COLOR_GRADIENTINACTIVECAPTION	= 28
; COLOR_GRAYTEXT				= 17
; COLOR_HIGHLIGHT				= 13
; COLOR_HIGHLIGHTTEXT			= 14
; COLOR_HOTLIGHT				= 26
; COLOR_INACTIVEBORDER			= 11
; COLOR_INACTIVECAPTION			= 3
; COLOR_INACTIVECAPTIONTEXT		= 19
; COLOR_INFOBK					= 24
; COLOR_INFOTEXT				= 23
; COLOR_MENU					= 4
; COLOR_MENUHILIGHT				= 29
; COLOR_MENUBAR					= 30
; COLOR_MENUTEXT				= 7
; COLOR_SCROLLBAR				= 0
; COLOR_WINDOW					= 5
; COLOR_WINDOWFRAME				= 6
; COLOR_WINDOWTEXT				= 8

SetSysColorToControl(hwnd, SysColor:=15)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
	DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
	w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
	h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
	pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
	pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	SetImage(hwnd, hBitmap)
	Gdip_DeleteBrush(pBrushClear)
	Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
	return 0
}

;#####################################################################################

; Function				Gdip_BitmapFromScreen
; Description			Gets a gdi+ bitmap from the screen
;
; Screen				0 = All screens
;						Any numerical value = Just that screen
;						x|y|w|h = Take specific coordinates with a width and height
; Raster				raster operation code
;
; return					If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1:		one or more of x,y,w,h not passed properly
;
; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

Gdip_BitmapFromScreen(Screen:=0, Raster:="")
{
	hhdc := 0
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if (Screen = 0)
	{
		_x := DllCall( "GetSystemMetrics", "Int", 76 )
		_y := DllCall( "GetSystemMetrics", "Int", 77 )
		_w := DllCall( "GetSystemMetrics", "Int", 78 )
		_h := DllCall( "GetSystemMetrics", "Int", 79 )
	}
	else if (SubStr(Screen, 1, 5) = "hwnd:")
	{
		Screen := SubStr(Screen, 6)
		if !WinExist("ahk_id " Screen)
			return -2
		CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
		DllCall( "GetWindowRect", Ptr, Screen, Ptr, &winRect )
		_w := NumGet(winRect, 8, "UInt")  - NumGet(winRect, 0, "UInt")
		_h := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
		_x := _y := 0
		hhdc := GetDCEx(Screen, 3)
	}
	else if IsInteger(Screen)
	{
		M := GetMonitorInfo(Screen)
		_x := M.Left, _y := M.Top, _w := M.Right-M.Left, _h := M.Bottom-M.Top
	}
	else
	{
		S := StrSplit(Screen, "|")
		_x := S[1], _y := S[2], _w := S[3], _h := S[4]
	}

	if (_x = "") || (_y = "") || (_w = "") || (_h = "")
		return -1

	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(_w, _h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, _w, _h, hhdc, _x, _y, Raster)
	ReleaseDC(hhdc)

	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}

;#####################################################################################

; Function				Gdip_BitmapFromHWND
; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
;
; hwnd					handle to the window to get a bitmap from
;
; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
;
; notes					Window must not be not minimised in order to get a handle to it's client area

Gdip_BitmapFromHWND(hwnd)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	CreateRect( winRect, 0, 0, 0, 0 ) ;is 16 on both 32 and 64
	DllCall( "GetWindowRect", Ptr, hwnd, Ptr, &winRect )
	Width := NumGet(winRect, 8, "UInt") - NumGet(winRect, 0, "UInt")
	Height := NumGet(winRect, 12, "UInt") - NumGet(winRect, 4, "UInt")
	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
	PrintWindow(hwnd, hdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
	return pBitmap
}

;#####################################################################################

; Function				CreateRectF
; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
;
; RectF					Name to call the RectF object
; x						x-coordinate of the upper left corner of the rectangle
; y						y-coordinate of the upper left corner of the rectangle
; w						Width of the rectangle
; h						Height of the rectangle
;
; return				No return value

CreateRectF(ByRef RectF, x, y, w, h)
{
	VarSetCapacity(RectF, 16)
	NumPut(x, RectF, 0, "float"), NumPut(y, RectF, 4, "float"), NumPut(w, RectF, 8, "float"), NumPut(h, RectF, 12, "float")
}

;#####################################################################################

; Function				CreateRect
; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
;
; RectF		 			Name to call the RectF object
; x						x-coordinate of the upper left corner of the rectangle
; y						y-coordinate of the upper left corner of the rectangle
; w						Width of the rectangle
; h						Height of the rectangle
;
; return				No return value

CreateRect(ByRef Rect, x, y, w, h)
{
	VarSetCapacity(Rect, 16)
	NumPut(x, Rect, 0, "uint"), NumPut(y, Rect, 4, "uint"), NumPut(w, Rect, 8, "uint"), NumPut(h, Rect, 12, "uint")
}
;#####################################################################################

; Function				CreateSizeF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF					Name to call the SizeF object
; w						w-value for the SizeF object
; h						h-value for the SizeF object
;
; return				No Return value

CreateSizeF(ByRef SizeF, w, h)
{
	VarSetCapacity(SizeF, 8)
	NumPut(w, SizeF, 0, "float"), NumPut(h, SizeF, 4, "float")
}
;#####################################################################################

; Function				CreatePointF
; Description			Creates a SizeF object, containing an 2 values
;
; SizeF					Name to call the SizeF object
; w						w-value for the SizeF object
; h						h-value for the SizeF object
;
; return				No Return value

CreatePointF(ByRef PointF, x, y)
{
	VarSetCapacity(PointF, 8)
	NumPut(x, PointF, 0, "float"), NumPut(y, PointF, 4, "float")
}
;#####################################################################################

; Function				CreateDIBSection
; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
;
; w						width of the bitmap to create
; h						height of the bitmap to create
; hdc					a handle to the device context to use the palette from
; bpp					bits per pixel (32 = ARGB)
; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
;
; return				returns a DIB. A gdi bitmap
;
; notes					ppvBits will receive the location of the pixels in the DIB

CreateDIBSection(w, h, hdc:="", bpp:=32, ByRef ppvBits:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)

	NumPut(w, bi, 4, "uint")
	, NumPut(h, bi, 8, "uint")
	, NumPut(40, bi, 0, "uint")
	, NumPut(1, bi, 12, "ushort")
	, NumPut(0, bi, 16, "uInt")
	, NumPut(bpp, bi, 14, "ushort")

	hbm := DllCall("CreateDIBSection"
					, Ptr, hdc2
					, Ptr, &bi
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "uint*", ppvBits
					, Ptr, 0
					, "uint", 0, Ptr)

	if !hdc
		ReleaseDC(hdc2)
	return hbm
}

;#####################################################################################

; Function				PrintWindow
; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
;
; hwnd					A handle to the window that will be copied
; hdc					A handle to the device context
; Flags					Drawing options
;
; return				If the function succeeds, it returns a nonzero value
;
; PW_CLIENTONLY			= 1

PrintWindow(hwnd, hdc, Flags:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("PrintWindow", Ptr, hwnd, Ptr, hdc, "uint", Flags)
}

;#####################################################################################

; Function				DestroyIcon
; Description			Destroys an icon and frees any memory the icon occupied
;
; hIcon					Handle to the icon to be destroyed. The icon must not be in use
;
; return				If the function succeeds, the return value is nonzero

DestroyIcon(hIcon)
{
	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
}

;#####################################################################################

; Function:				GetIconDimensions
; Description:			Retrieves a given icon/cursor's width and height
;
; hIcon					Pointer to an icon or cursor
; Width					ByRef variable. This variable is set to the icon's width
; Height				ByRef variable. This variable is set to the icon's height
;
; return				If the function succeeds, the return value is zero, otherwise:
;						-1 = Could not retrieve the icon's info. Check A_LastError for extended information
;						-2 = Could not delete the icon's bitmask bitmap
;						-3 = Could not delete the icon's color bitmap

GetIconDimensions(hIcon, ByRef Width, ByRef Height) {
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	Width := Height := 0

	VarSetCapacity(ICONINFO, size := 16 + 2 * A_PtrSize, 0)

	if !DllCall("user32\GetIconInfo", Ptr, hIcon, Ptr, &ICONINFO)
		return -1

	hbmMask := NumGet(&ICONINFO, 16, Ptr)
	hbmColor := NumGet(&ICONINFO, 16 + A_PtrSize, Ptr)
	VarSetCapacity(BITMAP, size, 0)

	if DllCall("gdi32\GetObject", Ptr, hbmColor, "Int", size, Ptr, &BITMAP)
	{
		Width := NumGet(&BITMAP, 4, "Int")
		Height := NumGet(&BITMAP, 8, "Int")
	}

	if !DllCall("gdi32\DeleteObject", Ptr, hbmMask)
		return -2

	if !DllCall("gdi32\DeleteObject", Ptr, hbmColor)
		return -3

	return 0
}

;#####################################################################################

PaintDesktop(hdc)
{
	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

CreateCompatibleBitmap(hdc, w, h)
{
	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "int", w, "int", h)
}

;#####################################################################################

; Function				CreateCompatibleDC
; Description			This function creates a memory device context (DC) compatible with the specified device
;
; hdc					Handle to an existing device context
;
; return				returns the handle to a device context or 0 on failure
;
; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen

CreateCompatibleDC(hdc:=0)
{
	return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}

;#####################################################################################

; Function				SelectObject
; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
;
; hdc					Handle to a DC
; hgdiobj				A handle to the object to be selected into the DC
;
; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
;
; notes					The specified object must have been created by using one of the following functions
;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
;						Font - CreateFont, CreateFontIndirect
;						Pen - CreatePen, CreatePenIndirect
;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
;
; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
;
; SIMPLEREGION			= 2 Region consists of a single rectangle
; COMPLEXREGION			= 3 Region consists of more than one rectangle
; NULLREGION			= 1 Region is empty

SelectObject(hdc, hgdiobj)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}

;#####################################################################################

; Function				DeleteObject
; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
;						After the object is deleted, the specified handle is no longer valid
;
; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
;
; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context

DeleteObject(hObject)
{
	return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}

;#####################################################################################

; Function				GetDC
; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window.
;
; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen
;
; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure

GetDC(hwnd:=0)
{
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}

;#####################################################################################

; DCX_CACHE = 0x2
; DCX_CLIPCHILDREN = 0x8
; DCX_CLIPSIBLINGS = 0x10
; DCX_EXCLUDERGN = 0x40
; DCX_EXCLUDEUPDATE = 0x100
; DCX_INTERSECTRGN = 0x80
; DCX_INTERSECTUPDATE = 0x200
; DCX_LOCKWINDOWUPDATE = 0x400
; DCX_NORECOMPUTE = 0x100000
; DCX_NORESETATTRS = 0x4
; DCX_PARENTCLIP = 0x20
; DCX_VALIDATE = 0x200000
; DCX_WINDOW = 0x1

GetDCEx(hwnd, flags:=0, hrgnClip:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}

;#####################################################################################

; Function				ReleaseDC
; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
;
; hdc					Handle to the device context to be released
; hwnd					Handle to the window whose device context is to be released
;
; return				1 = released
;						0 = not released
;
; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function.

ReleaseDC(hdc, hwnd:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}

;#####################################################################################

; Function				DeleteDC
; Description			The DeleteDC function deletes the specified device context (DC)
;
; hdc					A handle to the device context
;
; return				If the function succeeds, the return value is nonzero
;
; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC

DeleteDC(hdc)
{
	return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
;#####################################################################################

; Function				Gdip_LibraryVersion
; Description			Get the current library version
;
; return				the library version
;
; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts

Gdip_LibraryVersion()
{
	return 1.45
}

;#####################################################################################

; Function				Gdip_LibrarySubVersion
; Description			Get the current library sub version
;
; return				the library sub version
;
; notes					This is the sub-version currently maintained by Rseding91
; 					Updated by guest3456 preliminary AHK v2 support
Gdip_LibrarySubVersion()
{
	return 1.54
}

;#####################################################################################

; Function:				Gdip_BitmapFromBRA
; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
;
; BRAFromMemIn			The variable for a BRA file read to memory
; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; Alternate				Changes whether the File parameter is the file name or its number
;
; return					If the function succeeds, the return value is a pointer to a gdi+ bitmap
;						-1 = The BRA variable is empty
;						-2 = The BRA has an incorrect header
;						-3 = The BRA has information missing
;						-4 = Could not find file inside the BRA

Gdip_BitmapFromBRA(ByRef BRAFromMemIn, File, Alternate := 0) {
	pBitmap := 0
	pStream := 0

	If !(BRAFromMemIn)
		Return -1
	Headers := StrSplit(StrGet(&BRAFromMemIn, 256, "CP0"), "`n")
	Header := StrSplit(Headers[1], "|")
	HeaderLength := (A_AhkVersion < "2") ? Header.Length() : Header.Length
	If (HeaderLength != 4) || (Header[2] != "BRA!")
		Return -2
	_Info := StrSplit(Headers[2], "|")
	_InfoLength := (A_AhkVersion < "2") ? _Info.Length() : _Info.Length
	If (_InfoLength != 3)
		Return -3
	OffsetTOC := StrPut(Headers[1], "CP0") + StrPut(Headers[2], "CP0") ;  + 2
	OffsetData := _Info[2]
	SearchIndex := Alternate ? 1 : 2
	TOC := StrGet(&BRAFromMemIn + OffsetTOC, OffsetData - OffsetTOC - 1, "CP0")
	RX1 := A_AhkVersion < "2" ? "mi`nO)^" : "mi`n)^"
	Offset := Size := 0
	If RegExMatch(TOC, RX1 . (Alternate ? File "\|.+?" : "\d+\|" . File) . "\|(\d+)\|(\d+)$", FileInfo) {
		Offset := OffsetData + FileInfo[1]
		Size := FileInfo[2]
	}
	If (Size = 0)
		Return -4
	hData := DllCall("GlobalAlloc", "UInt", 2, "UInt", Size, "UPtr")
	pData := DllCall("GlobalLock", "Ptr", hData, "UPtr")
	DllCall("RtlMoveMemory", "Ptr", pData, "Ptr", &BRAFromMemIn + Offset, "Ptr", Size)
	DllCall("GlobalUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", 1, "PtrP", pStream)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "PtrP", pBitmap)
	ObjRelease(pStream)
	Return pBitmap
}

;#####################################################################################

; Function:				Gdip_BitmapFromBase64
; Description:			Creates a bitmap from a Base64 encoded string
;
; Base64				ByRef variable. Base64 encoded string. Immutable, ByRef to avoid performance overhead of passing long strings.
;
; return				If the function succeeds, the return value is a pointer to a bitmap, otherwise:
;						-1 = Could not calculate the length of the required buffer
;						-2 = Could not decode the Base64 encoded string
;						-3 = Could not create a memory stream

Gdip_BitmapFromBase64(ByRef Base64)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DecLen := 0
	pBitmap := 0

	; calculate the length of the buffer needed
	if !(DllCall("crypt32\CryptStringToBinary", Ptr, &Base64, "UInt", 0, "UInt", 0x01, Ptr, 0, "UIntP", DecLen, Ptr, 0, Ptr, 0))
		return -1

	VarSetCapacity(Dec, DecLen, 0)

	; decode the Base64 encoded string
	if !(DllCall("crypt32\CryptStringToBinary", Ptr, &Base64, "UInt", 0, "UInt", 0x01, Ptr, &Dec, "UIntP", DecLen, Ptr, 0, Ptr, 0))
		return -2

	; create a memory stream
	if !(pStream := DllCall("shlwapi\SHCreateMemStream", Ptr, &Dec, "UInt", DecLen, "UPtr"))
		return -3

	DllCall("gdiplus\GdipCreateBitmapFromStreamICM", Ptr, pStream, "PtrP", pBitmap)
	ObjRelease(pStream)

	return pBitmap
}

;#####################################################################################

; Function				Gdip_DrawRectangle
; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawRectangle", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawRoundedRectangle
; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
{
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	_E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
	Gdip_ResetClip(pGraphics)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_ResetClip(pGraphics)
	return _E
}

;#####################################################################################

; Function				Gdip_DrawEllipse
; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawEllipse", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_DrawBezier
; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the bezier
; y1					y-coordinate of the start of the bezier
; x2					x-coordinate of the first arc of the bezier
; y2					y-coordinate of the first arc of the bezier
; x3					x-coordinate of the second arc of the bezier
; y3					y-coordinate of the second arc of the bezier
; x4					x-coordinate of the end of the bezier
; y4					y-coordinate of the end of the bezier
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawBezier"
					, Ptr, pgraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2
					, "float", x3
					, "float", y3
					, "float", x4
					, "float", y4)
}

;#####################################################################################

; Function				Gdip_DrawArc
; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the arc
; y						y-coordinate of the start of the arc
; w						width of the arc
; h						height of the arc
; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; SweepAngle			specifies the angle between the starting and ending points of the arc
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawArc"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawPie
; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x						x-coordinate of the start of the pie
; y						y-coordinate of the start of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success
;
; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width

Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawPie", Ptr, pGraphics, Ptr, pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_DrawLine
; Description			This function uses a pen to draw a line into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; x1					x-coordinate of the start of the line
; y1					y-coordinate of the start of the line
; x2					x-coordinate of the end of the line
; y2					y-coordinate of the end of the line
;
; return				status enumeration. 0 = success

Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipDrawLine"
					, Ptr, pGraphics
					, Ptr, pPen
					, "float", x1
					, "float", y1
					, "float", x2
					, "float", y2)
}

;#####################################################################################

; Function				Gdip_DrawLines
; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pPen					Pointer to a pen
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success

Gdip_DrawLines(pGraphics, pPen, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	Points := StrSplit(Points, "|")
	PointsLength := (A_AhkVersion < "2") ? Points.Length() : Points.Length
	VarSetCapacity(PointF, 8*PointsLength)
	for eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipDrawLines", Ptr, pGraphics, Ptr, pPen, Ptr, &PointF, "int", PointsLength)
}

;#####################################################################################

; Function				Gdip_FillRectangle
; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rectangle
; y						y-coordinate of the top left of the rectangle
; w						width of the rectanlge
; h						height of the rectangle
;
; return				status enumeration. 0 = success

Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillRectangle"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRoundedRectangle
; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the rounded rectangle
; y						y-coordinate of the top left of the rounded rectangle
; w						width of the rectanlge
; h						height of the rectangle
; r						radius of the rounded corners
;
; return				status enumeration. 0 = success

Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
{
	Region := Gdip_GetClipRegion(pGraphics)
	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
	_E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
	Gdip_SetClipRegion(pGraphics, Region, 0)
	Gdip_DeleteRegion(Region)
	return _E
}

;#####################################################################################

; Function				Gdip_FillPolygon
; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
;
; return				status enumeration. 0 = success
;
; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; Alternate 			= 0
; Winding 				= 1

Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	PointsLength := (A_AhkVersion < "2") ? Points.Length() : Points.Length
	VarSetCapacity(PointF, 8*PointsLength)
	For eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}
	return DllCall("gdiplus\GdipFillPolygon", Ptr, pGraphics, Ptr, pBrush, Ptr, &PointF, "int", PointsLength, "int", FillMode)
}

;#####################################################################################

; Function				Gdip_FillPie
; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the pie
; y						y-coordinate of the top left of the pie
; w						width of the pie
; h						height of the pie
; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; SweepAngle			specifies the angle between the starting and ending points of the pie
;
; return				status enumeration. 0 = success

Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillPie"
					, Ptr, pGraphics
					, Ptr, pBrush
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "float", StartAngle
					, "float", SweepAngle)
}

;#####################################################################################

; Function				Gdip_FillEllipse
; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; x						x-coordinate of the top left of the ellipse
; y						y-coordinate of the top left of the ellipse
; w						width of the ellipse
; h						height of the ellipse
;
; return				status enumeration. 0 = success

Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillEllipse", Ptr, pGraphics, Ptr, pBrush, "float", x, "float", y, "float", w, "float", h)
}

;#####################################################################################

; Function				Gdip_FillRegion
; Description			This function uses a brush to fill a region in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Region
;
; return				status enumeration. 0 = success
;
; notes					You can create a region Gdip_CreateRegion() and then add to this

Gdip_FillRegion(pGraphics, pBrush, Region)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillRegion", Ptr, pGraphics, Ptr, pBrush, Ptr, Region)
}

;#####################################################################################

; Function				Gdip_FillPath
; Description			This function uses a brush to fill a path in the Graphics of a bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBrush				Pointer to a brush
; Region				Pointer to a Path
;
; return				status enumeration. 0 = success

Gdip_FillPath(pGraphics, pBrush, pPath)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipFillPath", Ptr, pGraphics, Ptr, pBrush, Ptr, pPath)
}

;#####################################################################################

; Function				Gdip_DrawImagePointsRect
; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source rectangle
; sh					height of source rectangle
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter

Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx:="", sy:="", sw:="", sh:="", Matrix:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	PointsLength := (A_AhkVersion < "2") ? Points.Length() : Points.Length
	VarSetCapacity(PointF, 8*PointsLength)
	For eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}

	if !IsNumber(Matrix)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		sx := 0, sy := 0
		sw := Gdip_GetImageWidth(pBitmap)
		sh := Gdip_GetImageHeight(pBitmap)
	}

	_E := DllCall("gdiplus\GdipDrawImagePointsRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, Ptr, &PointF
				, "int", PointsLength
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return _E
}

;#####################################################################################

; Function				Gdip_DrawImage
; Description			This function draws a bitmap into the Graphics of another bitmap
;
; pGraphics				Pointer to the Graphics of a bitmap
; pBitmap				Pointer to a bitmap to be drawn
; dx					x-coord of destination upper-left corner
; dy					y-coord of destination upper-left corner
; dw					width of destination image
; dh					height of destination image
; sx					x-coordinate of source upper-left corner
; sy					y-coordinate of source upper-left corner
; sw					width of source image
; sh					height of source image
; Matrix				a matrix used to alter image attributes when drawing
;
; return				status enumeration. 0 = success
;
; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
;						Gdip_DrawImage performs faster
;						Matrix can be omitted to just draw with no alteration to ARGB
;						Matrix may be passed as a digit from 0 - 1 to change just transparency
;						Matrix can be passed as a matrix with any delimiter. For example:
;						MatrixBright=
;						(
;						1.5		|0		|0		|0		|0
;						0		|1.5	|0		|0		|0
;						0		|0		|1.5	|0		|0
;						0		|0		|0		|1		|0
;						0.05	|0.05	|0.05	|0		|1
;						)
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1

Gdip_DrawImage(pGraphics, pBitmap, dx:="", dy:="", dw:="", dh:="", sx:="", sy:="", sw:="", sh:="", Matrix:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if !IsNumber(Matrix)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
	else if (Matrix != 1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

	if (sx = "" && sy = "" && sw = "" && sh = "")
	{
		if (dx = "" && dy = "" && dw = "" && dh = "")
		{
			sx := dx := 0, sy := dy := 0
			sw := dw := Gdip_GetImageWidth(pBitmap)
			sh := dh := Gdip_GetImageHeight(pBitmap)
		}
		else
		{
			sx := sy := 0
			sw := Gdip_GetImageWidth(pBitmap)
			sh := Gdip_GetImageHeight(pBitmap)
		}
	}

	_E := DllCall("gdiplus\GdipDrawImageRectRect"
				, Ptr, pGraphics
				, Ptr, pBitmap
				, "float", dx
				, "float", dy
				, "float", dw
				, "float", dh
				, "float", sx
				, "float", sy
				, "float", sw
				, "float", sh
				, "int", 2
				, Ptr, ImageAttr ? ImageAttr : 0
				, Ptr, 0
				, Ptr, 0)
	if ImageAttr
		Gdip_DisposeImageAttributes(ImageAttr)
	return _E
}

;#####################################################################################

; Function				Gdip_SetImageAttributesColorMatrix
; Description			This function creates an image matrix ready for drawing
;
; Matrix				a matrix used to alter image attributes when drawing
;						passed with any delimeter
;
; return				returns an image matrix on sucess or 0 if it fails
;
; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|1|1|1|0|1

Gdip_SetImageAttributesColorMatrix(Matrix)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	ImageAttr := 0
	VarSetCapacity(ColourMatrix, 100, 0)
	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", , 1), "[^\d-\.]+", "|")
	Matrix := StrSplit(Matrix, "|")
	Loop 25
	{
		M := (Matrix[A_Index] != "") ? Matrix[A_Index] : Mod(A_Index-1, 6) ? 0 : 1
		NumPut(M, ColourMatrix, (A_Index-1)*4, "float")
	}
	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", ImageAttr)
	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", Ptr, ImageAttr, "int", 1, "int", 1, Ptr, &ColourMatrix, Ptr, 0, "int", 0)
	return ImageAttr
}

;#####################################################################################

; Function				Gdip_GraphicsFromImage
; Description			This function gets the graphics for a bitmap used for drawing functions
;
; pBitmap				Pointer to a bitmap to get the pointer to its graphics
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					a bitmap can be drawn into the graphics of another bitmap

Gdip_GraphicsFromImage(pBitmap)
{
	pGraphics := 0
	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;#####################################################################################

; Function				Gdip_GraphicsFromHDC
; Description			This function gets the graphics from the handle to a device context
;
; hdc					This is the handle to the device context
;
; return				returns a pointer to the graphics of a bitmap
;
; notes					You can draw a bitmap into the graphics of another bitmap

Gdip_GraphicsFromHDC(hdc)
{
	pGraphics := 0

	DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", pGraphics)
	return pGraphics
}

;#####################################################################################

; Function				Gdip_GetDC
; Description			This function gets the device context of the passed Graphics
;
; hdc					This is the handle to the device context
;
; return				returns the device context for the graphics of a bitmap

Gdip_GetDC(pGraphics)
{
	hdc := 0
	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", hdc)
	return hdc
}

;#####################################################################################

; Function				Gdip_ReleaseDC
; Description			This function releases a device context from use for further use
;
; pGraphics				Pointer to the graphics of a bitmap
; hdc					This is the handle to the device context
;
; return				status enumeration. 0 = success

Gdip_ReleaseDC(pGraphics, hdc)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipReleaseDC", Ptr, pGraphics, Ptr, hdc)
}

;#####################################################################################

; Function				Gdip_GraphicsClear
; Description			Clears the graphics of a bitmap ready for further drawing
;
; pGraphics				Pointer to the graphics of a bitmap
; ARGB					The colour to clear the graphics to
;
; return				status enumeration. 0 = success
;
; notes					By default this will make the background invisible
;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics

Gdip_GraphicsClear(pGraphics, ARGB:=0x00ffffff)
{
	return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_BlurBitmap
; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
;
; pBitmap				Pointer to a bitmap to be blurred
; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
;
; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
;						-1 = The blur parameter is outside the range 1-100
;
; notes					This function will not dispose of the original bitmap

Gdip_BlurBitmap(pBitmap, Blur)
{
	if (Blur > 100) || (Blur < 1)
		return -1

	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
	dWidth := sWidth//Blur, dHeight := sHeight//Blur

	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
	G1 := Gdip_GraphicsFromImage(pBitmap1)
	Gdip_SetInterpolationMode(G1, 7)
	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

	Gdip_DeleteGraphics(G1)

	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
	G2 := Gdip_GraphicsFromImage(pBitmap2)
	Gdip_SetInterpolationMode(G2, 7)
	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

	Gdip_DeleteGraphics(G2)
	Gdip_DisposeImage(pBitmap1)
	return pBitmap2
}

;#####################################################################################

; Function:				Gdip_SaveBitmapToFile
; Description:			Saves a bitmap to a file in any supported format onto disk
;
; pBitmap				Pointer to a bitmap
; sOutput				The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; Quality				If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
;
; return				If the function succeeds, the return value is zero, otherwise:
;						-1 = Extension supplied is not a supported file format
;						-2 = Could not get a list of encoders on system
;						-3 = Could not find matching encoder for specified file format
;						-4 = Could not get WideChar name of output file
;						-5 = Could not save file to disk
;
; notes					This function will use the extension supplied from the sOutput parameter to determine the output format

Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality:=75)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	nCount := 0
	nSize := 0
	_p := 0

	SplitPath sOutput,,, Extension
	if !RegExMatch(Extension, "^(?i:BMP|DIB|RLE|JPG|JPEG|JPE|JFIF|GIF|TIF|TIFF|PNG)$")
		return -1
	Extension := "." Extension

	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2

	If (A_IsUnicode){
		StrGet_Name := "StrGet"

		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue

			pCodec := &ci+idx
			break
		}
	} else {
		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
		{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue

			pCodec := &ci+76*(A_Index-1)
			break
		}
	}

	if !pCodec
		return -3

	if (Quality != 75)
	{
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if RegExMatch(Extension, "^\.(?i:JPG|JPEG|JPE|JFIF)$")
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			nCount := NumGet(EncoderParameters, "UInt")
			N := (A_AhkVersion < 2) ? nCount : "nCount"
			Loop %N%
			{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
				{
					_p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, _p+0)+20, "UInt")), "UInt")
					break
				}
			}
		}
	}

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		_E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", _p ? _p : 0)
	}
	else
		_E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", _p ? _p : 0)
	return _E ? -5 : 0
}

;#####################################################################################

; Function				Gdip_GetPixel
; Description			Gets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				Returns the ARGB value of the pixel

Gdip_GetPixel(pBitmap, x, y)
{
	ARGB := 0

	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "uint*", ARGB)
	return ARGB
}

;#####################################################################################

; Function				Gdip_SetPixel
; Description			Sets the ARGB of a pixel in a bitmap
;
; pBitmap				Pointer to a bitmap
; x						x-coordinate of the pixel
; y						y-coordinate of the pixel
;
; return				status enumeration. 0 = success

Gdip_SetPixel(pBitmap, x, y, ARGB)
{
	return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", x, "int", y, "int", ARGB)
}

;#####################################################################################

; Function				Gdip_GetImageWidth
; Description			Gives the width of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the width in pixels of the supplied bitmap

Gdip_GetImageWidth(pBitmap)
{
	Width := 0
	DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
	return Width
}

;#####################################################################################

; Function				Gdip_GetImageHeight
; Description			Gives the height of a bitmap
;
; pBitmap				Pointer to a bitmap
;
; return				Returns the height in pixels of the supplied bitmap

Gdip_GetImageHeight(pBitmap)
{
	Height := 0
	DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
	return Height
}

;#####################################################################################

; Function				Gdip_GetDimensions
; Description			Gives the width and height of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetImageDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Width := 0
	Height := 0
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipGetImageWidth", Ptr, pBitmap, "uint*", Width)
	DllCall("gdiplus\GdipGetImageHeight", Ptr, pBitmap, "uint*", Height)
}

;#####################################################################################

Gdip_GetDimensions(pBitmap, ByRef Width, ByRef Height)
{
	Gdip_GetImageDimensions(pBitmap, Width, Height)
}

;#####################################################################################

Gdip_GetImagePixelFormat(pBitmap)
{
	Format := 0
	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", Format)
	return Format
}

;#####################################################################################

; Function				Gdip_GetDpiX
; Description			Gives the horizontal dots per inch of the graphics of a bitmap
;
; pBitmap				Pointer to a bitmap
; Width					ByRef variable. This variable will be set to the width of the bitmap
; Height				ByRef variable. This variable will be set to the height of the bitmap
;
; return				No return value
;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

Gdip_GetDpiX(pGraphics)
{
	dpix := 0
	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetDpiY(pGraphics)
{
	dpiy := 0
	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "uint", pGraphics, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_GetImageHorizontalResolution(pBitmap)
{
	dpix := 0
	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpix)
	return Round(dpix)
}

;#####################################################################################

Gdip_GetImageVerticalResolution(pBitmap)
{
	dpiy := 0
	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float*", dpiy)
	return Round(dpiy)
}

;#####################################################################################

Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
{
	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "uint", pBitmap, "float", dpix, "float", dpiy)
}

;#####################################################################################

Gdip_CreateBitmapFromFile(sFile, IconNumber:=1, IconSize:="")
{
	pBitmap := 0
	pBitmapOld := 0
	hIcon := 0
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"

	SplitPath sFile,,, Extension
	if RegExMatch(Extension, "^(?i:exe|dll)$")
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))

		VarSetCapacity(buf, BufSize, 0)
		For eachSize, Size in StrSplit( Sizes, "|" )
		{
			DllCall("PrivateExtractIcons", "str", sFile, "int", IconNumber-1, "int", Size, "int", Size, PtrA, hIcon, PtrA, 0, "uint", 1, "uint", 0)

			if !hIcon
				continue

			if !DllCall("GetIconInfo", Ptr, hIcon, Ptr, &buf)
			{
				DestroyIcon(hIcon)
				continue
			}

			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4))
			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4))
			if !(hbmColor && DllCall("GetObject", Ptr, hbmColor, "int", BufSize, Ptr, &buf))
			{
				DestroyIcon(hIcon)
				continue
			}
			break
		}
		if !hIcon
			return -1

		Width := NumGet(buf, 4, "int"), Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", Ptr, hdc, "int", 0, "int", 0, Ptr, hIcon, "uint", Width, "uint", Height, "uint", 0, Ptr, 0, "uint", 3)
		{
			DestroyIcon(hIcon)
			return -2
		}

		VarSetCapacity(dib, 104)
		DllCall("GetObject", Ptr, hbm, "int", A_PtrSize = 8 ? 104 : 84, Ptr, &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", Stride, "int", 0x26200A, Ptr, Bits, PtrA, pBitmapOld)
		pBitmap := Gdip_CreateBitmap(Width, Height)
		_G := Gdip_GraphicsFromImage(pBitmap)
		, Gdip_DrawImage(_G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
		Gdip_DeleteGraphics(_G), Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
	}
	else
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wFile, 1024)
			DllCall("kernel32\MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sFile, "int", -1, Ptr, &wFile, "int", 512)
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &wFile, PtrA, pBitmap)
		}
		else
			DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	}

	return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	pBitmap := 0

	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHBITMAPFromBitmap(pBitmap, Background:=0xffffffff)
{
        hbm := 0
	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hbm, "int", Background)
	return hbm
}

;#####################################################################################

Gdip_CreateARGBBitmapFromHBITMAP(ByRef hBitmap) {
	; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
	DllCall("GetObject"
				,    "ptr", hBitmap
				,    "int", VarSetCapacity(dib, 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize)
				,    "ptr", &dib) ; sizeof(DIBSECTION) = 84, 104
		, width  := NumGet(dib, 4, "uint")
		, height := NumGet(dib, 8, "uint")
		, bpp    := NumGet(dib, 18, "ushort")

	; Fallback to built-in method if pixels are not 32-bit ARGB.
	if (bpp != 32) { ; This built-in version is 120% faster but ignores transparency.
		DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hBitmap, "ptr", 0, "ptr*", pBitmap:=0)
		return pBitmap
	}

	; Create a handle to a device context and associate the image.
	hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")             ; Creates a memory DC compatible with the current screen.
	obm := DllCall("SelectObject", "ptr", hdc, "ptr", hBitmap, "ptr") ; Put the (hBitmap) image onto the device context.

	; Create a device independent bitmap with negative height. All DIBs use the screen pixel format (pARGB).
	; Use hbm to buffer the image such that top-down and bottom-up images are mapped to this top-down buffer.
	cdc := DllCall("CreateCompatibleDC", "ptr", hdc, "ptr")
	VarSetCapacity(bi, 40, 0)               ; sizeof(bi) = 40
		, NumPut(      40, bi,  0,   "uint") ; Size
		, NumPut(   width, bi,  4,   "uint") ; Width
		, NumPut( -height, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
		, NumPut(       1, bi, 12, "ushort") ; Planes
		, NumPut(      32, bi, 14, "ushort") ; BitCount / BitsPerPixel
	hbm := DllCall("CreateDIBSection", "ptr", cdc, "ptr", &bi, "uint", 0
				, "ptr*", pBits:=0  ; pBits is the pointer to (top-down) pixel values.
				, "ptr", 0, "uint", 0, "ptr")
	ob2 := DllCall("SelectObject", "ptr", cdc, "ptr", hbm, "ptr")

	; This is the 32-bit ARGB pBitmap (different from an hBitmap) that will receive the final converted pixels.
	DllCall("gdiplus\GdipCreateBitmapFromScan0"
				, "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", pBitmap:=0)

	; Create a Scan0 buffer pointing to pBits. The buffer has pixel format pARGB.
	VarSetCapacity(Rect, 16, 0)              ; sizeof(Rect) = 16
		, NumPut(  width, Rect,  8,   "uint") ; Width
		, NumPut( height, Rect, 12,   "uint") ; Height
	VarSetCapacity(BitmapData, 16+2*A_PtrSize, 0)     ; sizeof(BitmapData) = 24, 32
		, NumPut(     width, BitmapData,  0,   "uint") ; Width
		, NumPut(    height, BitmapData,  4,   "uint") ; Height
		, NumPut( 4 * width, BitmapData,  8,    "int") ; Stride
		, NumPut(   0xE200B, BitmapData, 12,    "int") ; PixelFormat
		, NumPut(     pBits, BitmapData, 16,    "ptr") ; Scan0

	; Use LockBits to create a writable buffer that converts pARGB to ARGB.
	DllCall("gdiplus\GdipBitmapLockBits"
				,    "ptr", pBitmap
				,    "ptr", &Rect
				,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
				,    "int", 0xE200B      ; Format32bppPArgb
				,    "ptr", &BitmapData) ; Contains the pointer (pBits) to the hbm.

	; Copies the image (hBitmap) to a top-down bitmap. Removes bottom-up-ness if present.
	DllCall("gdi32\BitBlt"
				, "ptr", cdc, "int", 0, "int", 0, "int", width, "int", height
				, "ptr", hdc, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY

	; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
	DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", &BitmapData)

	; Cleanup the buffer and device contexts.
	DllCall("SelectObject", "ptr", cdc, "ptr", ob2)
	DllCall("DeleteObject", "ptr", hbm)
	DllCall("DeleteDC",     "ptr", cdc)
	DllCall("SelectObject", "ptr", hdc, "ptr", obm)
	DllCall("DeleteDC",     "ptr", hdc)

	return pBitmap
}

;#####################################################################################

Gdip_CreateARGBHBITMAPFromBitmap(ByRef pBitmap) {
   ; This version is about 25% faster than Gdip_CreateHBITMAPFromBitmap().
	; Get Bitmap width and height.
	DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", width:=0)
	DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", height:=0)

	; Convert the source pBitmap into a hBitmap manually.
	; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
	hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	VarSetCapacity(bi, 40, 0)               ; sizeof(bi) = 40
		, NumPut(      40, bi,  0,   "uint") ; Size
		, NumPut(   width, bi,  4,   "uint") ; Width
		, NumPut( -height, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
		, NumPut(       1, bi, 12, "ushort") ; Planes
		, NumPut(      32, bi, 14, "ushort") ; BitCount / BitsPerPixel
	hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", &bi, "uint", 0, "ptr*", pBits:=0, "ptr", 0, "uint", 0, "ptr")
	obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

	; Transfer data from source pBitmap to an hBitmap manually.
	VarSetCapacity(Rect, 16, 0)              ; sizeof(Rect) = 16
		, NumPut(  width, Rect,  8,   "uint") ; Width
		, NumPut( height, Rect, 12,   "uint") ; Height
	VarSetCapacity(BitmapData, 16+2*A_PtrSize, 0)     ; sizeof(BitmapData) = 24, 32
		, NumPut(     width, BitmapData,  0,   "uint") ; Width
		, NumPut(    height, BitmapData,  4,   "uint") ; Height
		, NumPut( 4 * width, BitmapData,  8,    "int") ; Stride
		, NumPut(   0xE200B, BitmapData, 12,    "int") ; PixelFormat
		, NumPut(     pBits, BitmapData, 16,    "ptr") ; Scan0
	DllCall("gdiplus\GdipBitmapLockBits"
				,    "ptr", pBitmap
				,    "ptr", &Rect
				,   "uint", 5            ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
				,    "int", 0xE200B      ; Format32bppPArgb
				,    "ptr", &BitmapData) ; Contains the pointer (pBits) to the hbm.
	DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", &BitmapData)

	; Cleanup the hBitmap and device contexts.
	DllCall("SelectObject", "ptr", hdc, "ptr", obm)
	DllCall("DeleteDC",     "ptr", hdc)

	return hbm
}

;#####################################################################################

Gdip_CreateBitmapFromHICON(hIcon)
{
	pBitmap := 0

	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_CreateHICONFromBitmap(pBitmap)
{
	hIcon := 0

	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", hIcon)
	return hIcon
}

;#####################################################################################

Gdip_CreateBitmap(Width, Height, Format:=0x26200A)
{
	pBitmap := 0

	DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", Width, "int", Height, "int", 0, "int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	Return pBitmap
}

;#####################################################################################

Gdip_CreateBitmapFromClipboard()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if !DllCall("IsClipboardFormatAvailable", "uint", 8)
		return -2
	if !DllCall("OpenClipboard", Ptr, 0)
		return -1
	hBitmap := DllCall("GetClipboardData", "uint", 2, Ptr)
	if !DllCall("CloseClipboard")
		return -5
	if !hBitmap
		return -3
	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
		return -4
	DeleteObject(hBitmap)
	return pBitmap
}

;#####################################################################################

Gdip_SetBitmapToClipboard(pBitmap)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	DllCall("GetObject", Ptr, hBitmap, "int", VarSetCapacity(oi, A_PtrSize = 8 ? 104 : 84, 0), Ptr, &oi)
	hdib := DllCall("GlobalAlloc", "uint", 2, Ptr, 40+NumGet(oi, off1, "UInt"), Ptr)
	pdib := DllCall("GlobalLock", Ptr, hdib, Ptr)
	DllCall("RtlMoveMemory", Ptr, pdib, Ptr, &oi+off2, Ptr, 40)
	DllCall("RtlMoveMemory", Ptr, pdib+40, Ptr, NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4), Ptr), Ptr, NumGet(oi, off1, "UInt"))
	DllCall("GlobalUnlock", Ptr, hdib)
	DllCall("DeleteObject", Ptr, hBitmap)
	DllCall("OpenClipboard", Ptr, 0)
	DllCall("EmptyClipboard")
	DllCall("SetClipboardData", "uint", 8, Ptr, hdib)
	DllCall("CloseClipboard")
}

;#####################################################################################

Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format:=0x26200A)
{
	pBitmapDest := 0
	DllCall("gdiplus\GdipCloneBitmapArea"
					, "float", x
					, "float", y
					, "float", w
					, "float", h
					, "int", Format
					, A_PtrSize ? "UPtr" : "UInt", pBitmap
					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
	return pBitmapDest
}

;#####################################################################################
; Create resources
;#####################################################################################

Gdip_CreatePen(ARGB, w)
{
	pPen := 0
	DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}

;#####################################################################################

Gdip_CreatePenFromBrush(pBrush, w)
{
	pPen := 0

	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "int", 2, A_PtrSize ? "UPtr*" : "UInt*", pPen)
	return pPen
}

;#####################################################################################

Gdip_BrushCreateSolid(ARGB:=0xff000000)
{
	pBrush := 0

	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

; HatchStyleHorizontal = 0
; HatchStyleVertical = 1
; HatchStyleForwardDiagonal = 2
; HatchStyleBackwardDiagonal = 3
; HatchStyleCross = 4
; HatchStyleDiagonalCross = 5
; HatchStyle05Percent = 6
; HatchStyle10Percent = 7
; HatchStyle20Percent = 8
; HatchStyle25Percent = 9
; HatchStyle30Percent = 10
; HatchStyle40Percent = 11
; HatchStyle50Percent = 12
; HatchStyle60Percent = 13
; HatchStyle70Percent = 14
; HatchStyle75Percent = 15
; HatchStyle80Percent = 16
; HatchStyle90Percent = 17
; HatchStyleLightDownwardDiagonal = 18
; HatchStyleLightUpwardDiagonal = 19
; HatchStyleDarkDownwardDiagonal = 20
; HatchStyleDarkUpwardDiagonal = 21
; HatchStyleWideDownwardDiagonal = 22
; HatchStyleWideUpwardDiagonal = 23
; HatchStyleLightVertical = 24
; HatchStyleLightHorizontal = 25
; HatchStyleNarrowVertical = 26
; HatchStyleNarrowHorizontal = 27
; HatchStyleDarkVertical = 28
; HatchStyleDarkHorizontal = 29
; HatchStyleDashedDownwardDiagonal = 30
; HatchStyleDashedUpwardDiagonal = 31
; HatchStyleDashedHorizontal = 32
; HatchStyleDashedVertical = 33
; HatchStyleSmallConfetti = 34
; HatchStyleLargeConfetti = 35
; HatchStyleZigZag = 36
; HatchStyleWave = 37
; HatchStyleDiagonalBrick = 38
; HatchStyleHorizontalBrick = 39
; HatchStyleWeave = 40
; HatchStylePlaid = 41
; HatchStyleDivot = 42
; HatchStyleDottedGrid = 43
; HatchStyleDottedDiamond = 44
; HatchStyleShingle = 45
; HatchStyleTrellis = 46
; HatchStyleSphere = 47
; HatchStyleSmallGrid = 48
; HatchStyleSmallCheckerBoard = 49
; HatchStyleLargeCheckerBoard = 50
; HatchStyleOutlinedDiamond = 51
; HatchStyleSolidDiamond = 52
; HatchStyleTotal = 53
Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle:=0)
{
	pBrush := 0

	DllCall("gdiplus\GdipCreateHatchBrush", "int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", pBrush)
	return pBrush
}

;#####################################################################################

Gdip_CreateTextureBrush(pBitmap, WrapMode:=1, x:=0, y:=0, w:="", h:="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	pBrush := 0

	if !(w && h)
		DllCall("gdiplus\GdipCreateTexture", Ptr, pBitmap, "int", WrapMode, PtrA, pBrush)
	else
		DllCall("gdiplus\GdipCreateTexture2", Ptr, pBitmap, "int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
	return pBrush
}

;#####################################################################################

; WrapModeTile = 0
; WrapModeTileFlipX = 1
; WrapModeTileFlipY = 2
; WrapModeTileFlipXY = 3
; WrapModeClamp = 4
Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode:=1)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	LGpBrush := 0

	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
	DllCall("gdiplus\GdipCreateLineBrush", Ptr, &PointF1, Ptr, &PointF2, "Uint", ARGB1, "Uint", ARGB2, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

; LinearGradientModeHorizontal = 0
; LinearGradientModeVertical = 1
; LinearGradientModeForwardDiagonal = 2
; LinearGradientModeBackwardDiagonal = 3
Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode:=1, WrapMode:=1)
{
	CreateRectF(RectF, x, y, w, h)
	LGpBrush := 0
	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", &RectF, "int", ARGB1, "int", ARGB2, "int", LinearGradientMode, "int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", LGpBrush)
	return LGpBrush
}

;#####################################################################################

Gdip_CloneBrush(pBrush)
{
	pBrushClone := 0
	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", pBrushClone)
	return pBrushClone
}

;#####################################################################################
; Delete resources
;#####################################################################################

Gdip_DeletePen(pPen)
{
	return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
}

;#####################################################################################

Gdip_DeleteBrush(pBrush)
{
	return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
}

;#####################################################################################

Gdip_DisposeImage(pBitmap)
{
	return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}

;#####################################################################################

Gdip_DeleteGraphics(pGraphics)
{
	return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

;#####################################################################################

Gdip_DisposeImageAttributes(ImageAttr)
{
	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
}

;#####################################################################################

Gdip_DeleteFont(hFont)
{
	return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
}

;#####################################################################################

Gdip_DeleteStringFormat(hFormat)
{
	return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
}

;#####################################################################################

Gdip_DeleteFontFamily(hFamily)
{
	return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
}

;#####################################################################################

Gdip_DeleteMatrix(Matrix)
{
	return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
}

;#####################################################################################
; Text functions
;#####################################################################################

Gdip_TextToGraphics(pGraphics, Text, Options, Font:="Arial", Width:="", Height:="", Measure:=0)
{
	IWidth := Width, IHeight:= Height

	pattern_opts := (A_AhkVersion < "2") ? "iO)" : "i)"
	RegExMatch(Options, pattern_opts "X([\-\d\.]+)(p*)", xpos)
	RegExMatch(Options, pattern_opts "Y([\-\d\.]+)(p*)", ypos)
	RegExMatch(Options, pattern_opts "W([\-\d\.]+)(p*)", Width)
	RegExMatch(Options, pattern_opts "H([\-\d\.]+)(p*)", Height)
	RegExMatch(Options, pattern_opts "C(?!(entre|enter))([a-f\d]+)", Colour)
	RegExMatch(Options, pattern_opts "Top|Up|Bottom|Down|vCentre|vCenter", vPos)
	RegExMatch(Options, pattern_opts "NoWrap", NoWrap)
	RegExMatch(Options, pattern_opts "R(\d)", Rendering)
	RegExMatch(Options, pattern_opts "S(\d+)(p*)", Size)

	if Colour && IsInteger(Colour[2]) && !Gdip_DeleteBrush(Gdip_CloneBrush(Colour[2]))
		PassBrush := 1, pBrush := Colour[2]

	if !(IWidth && IHeight) && ((xpos && xpos[2]) || (ypos && ypos[2]) || (Width && Width[2]) || (Height && Height[2]) || (Size && Size[2]))
		return -1

	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
	For eachStyle, valStyle in StrSplit( Styles, "|" )
	{
		if RegExMatch(Options, "\b" valStyle)
			Style |= (valStyle != "StrikeOut") ? (A_Index-1) : 8
	}

	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
	For eachAlignment, valAlignment in StrSplit( Alignments, "|" )
	{
		if RegExMatch(Options, "\b" valAlignment)
			Align |= A_Index//2.1	; 0|0|1|1|2|2
	}

	xpos := (xpos && (xpos[1] != "")) ? xpos[2] ? IWidth*(xpos[1]/100) : xpos[1] : 0
	ypos := (ypos && (ypos[1] != "")) ? ypos[2] ? IHeight*(ypos[1]/100) : ypos[1] : 0
	Width := (Width && Width[1]) ? Width[2] ? IWidth*(Width[1]/100) : Width[1] : IWidth
	Height := (Height && Height[1]) ? Height[2] ? IHeight*(Height[1]/100) : Height[1] : IHeight
	if !PassBrush
		Colour := "0x" (Colour && Colour[2] ? Colour[2] : "ff000000")
	Rendering := (Rendering && (Rendering[1] >= 0) && (Rendering[1] <= 5)) ? Rendering[1] : 4
	Size := (Size && (Size[1] > 0)) ? Size[2] ? IHeight*(Size[1]/100) : Size[1] : 12

	hFamily := Gdip_FontFamilyCreate(Font)
	hFont := Gdip_FontCreate(hFamily, Size, Style)
	FormatStyle := NoWrap ? 0x4000 | 0x1000 : 0x4000
	hFormat := Gdip_StringFormatCreate(FormatStyle)
	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour)
	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0

	CreateRectF(RC, xpos, ypos, Width, Height)
	Gdip_SetStringFormatAlign(hFormat, Align)
	Gdip_SetTextRenderingHint(pGraphics, Rendering)
	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

	if vPos
	{
		ReturnRC := StrSplit(ReturnRC, "|")

		if (vPos[0] = "vCentre") || (vPos[0] = "vCenter")
			ypos += (Height-ReturnRC[4])//2
		else if (vPos[0] = "Top") || (vPos[0] = "Up")
			ypos := 0
		else if (vPos[0] = "Bottom") || (vPos[0] = "Down")
			ypos := Height-ReturnRC[4]

		CreateRectF(RC, xpos, ypos, Width, ReturnRC[4])
		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
	}

	if !Measure
		_E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

	if !PassBrush
		Gdip_DeleteBrush(pBrush)
	Gdip_DeleteStringFormat(hFormat)
	Gdip_DeleteFont(hFont)
	Gdip_DeleteFontFamily(hFamily)
	return _E ? _E : ReturnRC
}

;#####################################################################################

Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}

	return DllCall("gdiplus\GdipDrawString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, pBrush)
}

;#####################################################################################

Gdip_MeasureString(pGraphics, sString, hFont, hFormat, ByRef RectF)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	VarSetCapacity(RC, 16)
	if !A_IsUnicode
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wString, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sString, "int", -1, Ptr, &wString, "int", nSize)
	}

	Chars := 0
	Lines := 0
	DllCall("gdiplus\GdipMeasureString"
					, Ptr, pGraphics
					, Ptr, A_IsUnicode ? &sString : &wString
					, "int", -1
					, Ptr, hFont
					, Ptr, &RectF
					, Ptr, hFormat
					, Ptr, &RC
					, "uint*", Chars
					, "uint*", Lines)

	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
}

; Near = 0
; Center = 1
; Far = 2
Gdip_SetStringFormatAlign(hFormat, Align)
{
	return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "int", Align)
}

; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; StringFormatFlagsDirectionVertical       = 0x00000002
; StringFormatFlagsNoFitBlackBox           = 0x00000004
; StringFormatFlagsDisplayFormatControl    = 0x00000020
; StringFormatFlagsNoFontFallback          = 0x00000400
; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; StringFormatFlagsNoWrap                  = 0x00001000
; StringFormatFlagsLineLimit               = 0x00002000
; StringFormatFlagsNoClip                  = 0x00004000
Gdip_StringFormatCreate(Format:=0, Lang:=0)
{
	hFormat := 0
	DllCall("gdiplus\GdipCreateStringFormat", "int", Format, "int", Lang, A_PtrSize ? "UPtr*" : "UInt*", hFormat)
	return hFormat
}

; Regular = 0
; Bold = 1
; Italic = 2
; BoldItalic = 3
; Underline = 4
; Strikeout = 8
Gdip_FontCreate(hFamily, Size, Style:=0)
{
	hFont := 0
	DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size, "int", Style, "int", 0, A_PtrSize ? "UPtr*" : "UInt*", hFont)
	return hFont
}

Gdip_FontFamilyCreate(Font)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!A_IsUnicode)
	{
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, "uint", 0, "int", 0)
		VarSetCapacity(wFont, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &Font, "int", -1, Ptr, &wFont, "int", nSize)
	}

	hFamily := 0
	DllCall("gdiplus\GdipCreateFontFamilyFromName"
					, Ptr, A_IsUnicode ? &Font : &wFont
					, "uint", 0
					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)

	return hFamily
}

;#####################################################################################
; Matrix functions
;#####################################################################################

Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
{
	Matrix := 0
	DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", Matrix)
	return Matrix
}

Gdip_CreateMatrix()
{
	Matrix := 0
	DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", Matrix)
	return Matrix
}

;#####################################################################################
; GraphicsPath functions
;#####################################################################################

; Alternate = 0
; Winding = 1
Gdip_CreatePath(BrushMode:=0)
{
	pPath := 0
	DllCall("gdiplus\GdipCreatePath", "int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", pPath)
	return pPath
}

Gdip_AddPathEllipse(pPath, x, y, w, h)
{
	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", pPath, "float", x, "float", y, "float", w, "float", h)
}

Gdip_AddPathPolygon(pPath, Points)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	Points := StrSplit(Points, "|")
	PointsLength := (A_AhkVersion < "2") ? Points.Length() : Points.Length
	VarSetCapacity(PointF, 8*PointsLength)
	for eachPoint, Point in Points
	{
		Coord := StrSplit(Point, ",")
		NumPut(Coord[1], PointF, 8*(A_Index-1), "float"), NumPut(Coord[2], PointF, (8*(A_Index-1))+4, "float")
	}

	return DllCall("gdiplus\GdipAddPathPolygon", Ptr, pPath, Ptr, &PointF, "int", PointsLength)
}

Gdip_DeletePath(pPath)
{
	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", pPath)
}

;#####################################################################################
; Quality functions
;#####################################################################################

; SystemDefault = 0
; SingleBitPerPixelGridFit = 1
; SingleBitPerPixel = 2
; AntiAliasGridFit = 3
; AntiAlias = 4
Gdip_SetTextRenderingHint(pGraphics, RenderingHint)
{
	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", RenderingHint)
}

; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
{
	return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", InterpolationMode)
}

; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
{
	return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", SmoothingMode)
}

; CompositingModeSourceOver = 0 (blended)
; CompositingModeSourceCopy = 1 (overwrite)
Gdip_SetCompositingMode(pGraphics, CompositingMode:=0)
{
	return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "int", CompositingMode)
}

;#####################################################################################
; Extra functions
;#####################################################################################

Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	pToken := 0

	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

; Prepend = 0; The new operation is applied before the old operation.
; Append = 1; The new operation is applied after the old operation.
Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "int", MatrixOrder)
}

Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder:=0)
{
	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "int", MatrixOrder)
}

Gdip_ResetWorldTransform(pGraphics)
{
	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetRotatedTranslation(Width, Height, Angle, ByRef xTranslation, ByRef yTranslation)
{
	pi := 3.14159, TAngle := Angle*(pi/180)

	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
	if ((Bound >= 0) && (Bound <= 90))
		xTranslation := Height*Sin(TAngle), yTranslation := 0
	else if ((Bound > 90) && (Bound <= 180))
		xTranslation := (Height*Sin(TAngle))-(Width*Cos(TAngle)), yTranslation := -Height*Cos(TAngle)
	else if ((Bound > 180) && (Bound <= 270))
		xTranslation := -(Width*Cos(TAngle)), yTranslation := -(Height*Cos(TAngle))-(Width*Sin(TAngle))
	else if ((Bound > 270) && (Bound <= 360))
		xTranslation := 0, yTranslation := -Width*Sin(TAngle)
}

Gdip_GetRotatedDimensions(Width, Height, Angle, ByRef RWidth, ByRef RHeight)
{
	pi := 3.14159, TAngle := Angle*(pi/180)
	if !(Width && Height)
		return -1
	RWidth := Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
	RHeight := Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}

; RotateNoneFlipNone   = 0
; Rotate90FlipNone     = 1
; Rotate180FlipNone    = 2
; Rotate270FlipNone    = 3
; RotateNoneFlipX      = 4
; Rotate90FlipX        = 5
; Rotate180FlipX       = 6
; Rotate270FlipX       = 7
; RotateNoneFlipY      = Rotate180FlipX
; Rotate90FlipY        = Rotate270FlipX
; Rotate180FlipY       = RotateNoneFlipX
; Rotate270FlipY       = Rotate90FlipX
; RotateNoneFlipXY     = Rotate180FlipNone
; Rotate90FlipXY       = Rotate270FlipNone
; Rotate180FlipXY      = RotateNoneFlipNone
; Rotate270FlipXY      = Rotate90FlipNone

Gdip_ImageRotateFlip(pBitmap, RotateFlipType:=1)
{
	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "int", RotateFlipType)
}

; Replace = 0
; Intersect = 1
; Union = 2
; Xor = 3
; Exclude = 4
; Complement = 5
Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode:=0)
{
	return DllCall("gdiplus\GdipSetClipRect",  A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "int", CombineMode)
}

Gdip_SetClipPath(pGraphics, pPath, CombineMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdiplus\GdipSetClipPath", Ptr, pGraphics, Ptr, pPath, "int", CombineMode)
}

Gdip_ResetClip(pGraphics)
{
	return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
}

Gdip_GetClipRegion(pGraphics)
{
	Region := Gdip_CreateRegion()
	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt", Region)
	return Region
}

Gdip_SetClipRegion(pGraphics, Region, CombineMode:=0)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("gdiplus\GdipSetClipRegion", Ptr, pGraphics, Ptr, Region, "int", CombineMode)
}

Gdip_CreateRegion()
{
	Region := 0
	DllCall("gdiplus\GdipCreateRegion", "UInt*", Region)
	return Region
}

Gdip_DeleteRegion(Region)
{
	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
}

;#####################################################################################
; BitmapLockBits
;#####################################################################################

Gdip_LockBits(pBitmap, x, y, w, h, ByRef Stride, ByRef Scan0, ByRef BitmapData, LockMode := 3, PixelFormat := 0x26200a)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	CreateRect(_Rect, x, y, w, h)
	VarSetCapacity(BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4), 0)
	_E := DllCall("Gdiplus\GdipBitmapLockBits", Ptr, pBitmap, Ptr, &_Rect, "uint", LockMode, "int", PixelFormat, Ptr, &BitmapData)
	Stride := NumGet(BitmapData, 8, "Int")
	Scan0 := NumGet(BitmapData, 16, Ptr)
	return _E
}

;#####################################################################################

Gdip_UnlockBits(pBitmap, ByRef BitmapData)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"

	return DllCall("Gdiplus\GdipBitmapUnlockBits", Ptr, pBitmap, Ptr, &BitmapData)
}

;#####################################################################################

Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
{
	Numput(ARGB, Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_GetLockBitPixel(Scan0, x, y, Stride)
{
	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
}

;#####################################################################################

Gdip_PixelateBitmap(pBitmap, ByRef pBitmapOut, BlockSize)
{
	static PixelateBitmap

	Ptr := A_PtrSize ? "UPtr" : "UInt"

	if (!PixelateBitmap)
	{
		if A_PtrSize != 8 ; x86 machine code
		MCode_PixelateBitmap := "
		(LTrim Join
		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
		)"
		else ; x64 machine code
		MCode_PixelateBitmap := "
		(LTrim Join
		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
		)"

		VarSetCapacity(PixelateBitmap, StrLen(MCode_PixelateBitmap)//2)
		nCount := StrLen(MCode_PixelateBitmap)//2
		N := (A_AhkVersion < 2) ? nCount : "nCount"
		Loop %N%
			NumPut("0x" SubStr(MCode_PixelateBitmap, (2*A_Index)-1, 2), PixelateBitmap, A_Index-1, "UChar")
		DllCall("VirtualProtect", Ptr, &PixelateBitmap, Ptr, VarSetCapacity(PixelateBitmap), "uint", 0x40, A_PtrSize ? "UPtr*" : "UInt*", 0)
	}

	Gdip_GetImageDimensions(pBitmap, Width, Height)

	if (Width != Gdip_GetImageWidth(pBitmapOut) || Height != Gdip_GetImageHeight(pBitmapOut))
		return -1
	if (BlockSize > Width || BlockSize > Height)
		return -2

	E1 := Gdip_LockBits(pBitmap, 0, 0, Width, Height, Stride1, Scan01, BitmapData1)
	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width, Height, Stride2, Scan02, BitmapData2)
	if (E1 || E2)
		return -3

	; E := - unused exit code
	DllCall(&PixelateBitmap, Ptr, Scan01, Ptr, Scan02, "int", Width, "int", Height, "int", Stride1, "int", BlockSize)

	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
	return 0
}

;#####################################################################################

Gdip_ToARGB(A, R, G, B)
{
	return (A << 24) | (R << 16) | (G << 8) | B
}

;#####################################################################################

Gdip_FromARGB(ARGB, ByRef A, ByRef R, ByRef G, ByRef B)
{
	A := (0xff000000 & ARGB) >> 24
	R := (0x00ff0000 & ARGB) >> 16
	G := (0x0000ff00 & ARGB) >> 8
	B := 0x000000ff & ARGB
}

;#####################################################################################

Gdip_AFromARGB(ARGB)
{
	return (0xff000000 & ARGB) >> 24
}

;#####################################################################################

Gdip_RFromARGB(ARGB)
{
	return (0x00ff0000 & ARGB) >> 16
}

;#####################################################################################

Gdip_GFromARGB(ARGB)
{
	return (0x0000ff00 & ARGB) >> 8
}

;#####################################################################################

Gdip_BFromARGB(ARGB)
{
	return 0x000000ff & ARGB
}

;#####################################################################################

StrGetB(Address, Length:=-1, Encoding:=0)
{
	; Flexible parameter handling:
	if !IsInteger(Length)
		Encoding := Length,  Length := -1

	; Check for obvious errors.
	if (Address+0 < 1024)
		return

	; Ensure 'Encoding' contains a numeric identifier.
	if (Encoding = "UTF-16")
		Encoding := 1200
	else if (Encoding = "UTF-8")
		Encoding := 65001
	else if SubStr(Encoding,1,2)="CP"
		Encoding := SubStr(Encoding,3)

	if !Encoding ; "" or 0
	{
		; No conversion necessary, but we might not want the whole string.
		if (Length == -1)
			Length := DllCall("lstrlen", "uint", Address)
		VarSetCapacity(String, Length)
		DllCall("lstrcpyn", "str", String, "uint", Address, "int", Length + 1)
	}
	else if (Encoding = 1200) ; UTF-16
	{
		char_count := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "uint", 0, "uint", 0, "uint", 0, "uint", 0)
		VarSetCapacity(String, char_count)
		DllCall("WideCharToMultiByte", "uint", 0, "uint", 0x400, "uint", Address, "int", Length, "str", String, "int", char_count, "uint", 0, "uint", 0)
	}
	else if IsInteger(Encoding)
	{
		; Convert from target encoding to UTF-16 then to the active code page.
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", 0, "int", 0)
		VarSetCapacity(String, char_count * 2)
		char_count := DllCall("MultiByteToWideChar", "uint", Encoding, "uint", 0, "uint", Address, "int", Length, "uint", &String, "int", char_count * 2)
		String := StrGetB(&String, char_count, 1200)
	}

	return String
}


;#####################################################################################
; in AHK v1: uses normal 'if var is' command
; in AHK v2: all if's are expression-if, so the Integer variable is dereferenced to the string
;#####################################################################################
IsInteger(Var) {
	Static Integer := "Integer"
	If Var Is Integer
		Return True
	Return False
}

IsNumber(Var) {
	Static number := "number"
	If Var Is number
		Return True
	Return False
}



; ======================================================================================================================
; Multiple Display Monitors Functions -> msdn.microsoft.com/en-us/library/dd145072(v=vs.85).aspx
; by 'just me'
; https://autohotkey.com/boards/viewtopic.php?f=6&t=4606
; ======================================================================================================================
GetMonitorCount()
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		count := A_Index
	return count
}

GetMonitorInfo(MonitorNum)
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		if (v.Num = MonitorNum)
			return v
}

GetPrimaryMonitor()
{
	Monitors := MDMF_Enum()
	for k,v in Monitors
		If (v.Primary)
			return v.Num
}
; ----------------------------------------------------------------------------------------------------------------------
; Name ..........: MDMF - Multiple Display Monitor Functions
; Description ...: Various functions for multiple display monitor environments
; Tested with ...: AHK 1.1.32.00 (A32/U32/U64) and 2.0-a108-a2fa0498 (U32/U64)
; Original Author: just me (https://www.autohotkey.com/boards/viewtopic.php?f=6&t=4606)
; Mod Authors ...: iPhilip, guest3456
; Changes .......: Modified to work with v2.0-a108 and changed 'Count' key to 'TotalCount' to avoid conflicts
; ................ Modified MDMF_Enum() so that it works under both AHK v1 and v2.
; ................ Modified MDMF_EnumProc() to provide Count and Primary keys to the Monitors array.
; ................ Modified MDMF_FromHWND() to allow flag values that determine the function's return value if the
; ................    window does not intersect any display monitor.
; ................ Modified MDMF_FromPoint() to allow the cursor position to be returned ByRef if not specified and
; ................    allow flag values that determine the function's return value if the point is not contained within
; ................    any display monitor.
; ................ Modified MDMF_FromRect() to allow flag values that determine the function's return value if the
; ................    rectangle does not intersect any display monitor.
;................. Modified MDMF_GetInfo() with minor changes.
; ----------------------------------------------------------------------------------------------------------------------
;
; ======================================================================================================================
; Multiple Display Monitors Functions -> msdn.microsoft.com/en-us/library/dd145072(v=vs.85).aspx =======================
; ======================================================================================================================
; Enumerates display monitors and returns an object containing the properties of all monitors or the specified monitor.
; ======================================================================================================================
MDMF_Enum(HMON := "") {
	Static CallbackFunc := Func(A_AhkVersion < "2" ? "RegisterCallback" : "CallbackCreate")
	Static EnumProc := CallbackFunc.Call("MDMF_EnumProc")
	Static Obj := (A_AhkVersion < "2") ? "Object" : "Map"
	Static Monitors := {}
	If (HMON = "") ; new enumeration
	{
		Monitors := %Obj%("TotalCount", 0)
		If !DllCall("User32.dll\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", &Monitors, "Int")
			Return False
	}
	Return (HMON = "") ? Monitors : Monitors.HasKey(HMON) ? Monitors[HMON] : False
}
; ======================================================================================================================
;  Callback function that is called by the MDMF_Enum function.
; ======================================================================================================================
MDMF_EnumProc(HMON, HDC, PRECT, ObjectAddr) {
	Monitors := Object(ObjectAddr)
	Monitors[HMON] := MDMF_GetInfo(HMON)
	Monitors["TotalCount"]++
	If (Monitors[HMON].Primary)
		Monitors["Primary"] := HMON
	Return True
}
; ======================================================================================================================
; Retrieves the display monitor that has the largest area of intersection with a specified window.
; The following flag values determine the function's return value if the window does not intersect any display monitor:
;    MONITOR_DEFAULTTONULL    = 0 - Returns NULL.
;    MONITOR_DEFAULTTOPRIMARY = 1 - Returns a handle to the primary display monitor.
;    MONITOR_DEFAULTTONEAREST = 2 - Returns a handle to the display monitor that is nearest to the window.
; ======================================================================================================================
MDMF_FromHWND(HWND, Flag := 0) {
	Return DllCall("User32.dll\MonitorFromWindow", "Ptr", HWND, "UInt", Flag, "Ptr")
}
; ======================================================================================================================
; Retrieves the display monitor that contains a specified point.
; If either X or Y is empty, the function will use the current cursor position for this value and return it ByRef.
; The following flag values determine the function's return value if the point is not contained within any
; display monitor:
;    MONITOR_DEFAULTTONULL    = 0 - Returns NULL.
;    MONITOR_DEFAULTTOPRIMARY = 1 - Returns a handle to the primary display monitor.
;    MONITOR_DEFAULTTONEAREST = 2 - Returns a handle to the display monitor that is nearest to the point.
; ======================================================================================================================
MDMF_FromPoint(ByRef X := "", ByRef Y := "", Flag := 0) {
	If (X = "") || (Y = "") {
		VarSetCapacity(PT, 8, 0)
		DllCall("User32.dll\GetCursorPos", "Ptr", &PT, "Int")
		If (X = "")
			X := NumGet(PT, 0, "Int")
		If (Y = "")
			Y := NumGet(PT, 4, "Int")
	}
	Return DllCall("User32.dll\MonitorFromPoint", "Int64", (X & 0xFFFFFFFF) | (Y << 32), "UInt", Flag, "Ptr")
}
; ======================================================================================================================
; Retrieves the display monitor that has the largest area of intersection with a specified rectangle.
; Parameters are consistent with the common AHK definition of a rectangle, which is X, Y, W, H instead of
; Left, Top, Right, Bottom.
; The following flag values determine the function's return value if the rectangle does not intersect any
; display monitor:
;    MONITOR_DEFAULTTONULL    = 0 - Returns NULL.
;    MONITOR_DEFAULTTOPRIMARY = 1 - Returns a handle to the primary display monitor.
;    MONITOR_DEFAULTTONEAREST = 2 - Returns a handle to the display monitor that is nearest to the rectangle.
; ======================================================================================================================
MDMF_FromRect(X, Y, W, H, Flag := 0) {
	VarSetCapacity(RC, 16, 0)
	NumPut(X, RC, 0, "Int"), NumPut(Y, RC, 4, "Int"), NumPut(X + W, RC, 8, "Int"), NumPut(Y + H, RC, 12, "Int")
	Return DllCall("User32.dll\MonitorFromRect", "Ptr", &RC, "UInt", Flag, "Ptr")
}
; ======================================================================================================================
; Retrieves information about a display monitor.
; ======================================================================================================================
MDMF_GetInfo(HMON) {
	NumPut(VarSetCapacity(MIEX, 40 + (32 << !!A_IsUnicode)), MIEX, 0, "UInt")
	If DllCall("User32.dll\GetMonitorInfo", "Ptr", HMON, "Ptr", &MIEX, "Int")
		Return {Name:      (Name := StrGet(&MIEX + 40, 32))  ; CCHDEVICENAME = 32
		      , Num:       RegExReplace(Name, ".*(\d+)$", "$1")
		      , Left:      NumGet(MIEX, 4, "Int")    ; display rectangle
		      , Top:       NumGet(MIEX, 8, "Int")    ; "
		      , Right:     NumGet(MIEX, 12, "Int")   ; "
		      , Bottom:    NumGet(MIEX, 16, "Int")   ; "
		      , WALeft:    NumGet(MIEX, 20, "Int")   ; work area
		      , WATop:     NumGet(MIEX, 24, "Int")   ; "
		      , WARight:   NumGet(MIEX, 28, "Int")   ; "
		      , WABottom:  NumGet(MIEX, 32, "Int")   ; "
		      , Primary:   NumGet(MIEX, 36, "UInt")} ; contains a non-zero value for the primary monitor.
	Return False
}

PatientInfo:
WinClose , Invalid Entry
WinClose , Patient Information
Return

RagicCounterfeit(PharmacyName,PID,Transaction){
API_Key := "TW91dEJnbHdJVU1JNXY3eHNtZnpxb1lUWDlERkE5eU9Yc1VBU1lNRHpXZFNucnk0dDRMZDJNVWVreFZybG9PQQ=="
Ragic_Date :=
Ragic_Time :=

Loop,
{
If Ragic_Date is space
FormatTime, Ragic_Date,%Ragic_Date%, yyyy/MM/dd

If Ragic_Date is not space
Break
}

Loop,
{
If Ragic_Time is space
FormatTime, Ragic_Time,%Ragic_Time%, hh:mm:ss tt

If Ragic_Time is not space
Break
}

Data = 1000012=%PharmacyName%&1000013=%PID%&1000014=%Transaction%&1000015=%Ragic_Date%&1000016=%Ragic_Time%&api=

WinHttp := ComObjCreate("MSXML2.XMLHTTP.6.0")
WinHttp.Open("POST", "https://www.ragic.com/masteruniversal1/masteruniversal/1", false)
WinHttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
WinHttp.SetRequestHeader("Authorization", "Basic " API_Key)
WinHttp.Send(Data)
}

; ============================================================================
; ============================================================================
;  UIA FUNCTIONS — Read/Write DataGridView cells without clipboard or keyboard
;  Finds grids by AutomationId first, falls back to column header matching.
;  Immune to ClassNN changes when the third-party software is updated.
; ============================================================================
; ============================================================================

UIA_Setup() {
    static CLSID := "{ff48dba4-60ef-4201-aa87-54103eef594e}"
    static IID   := "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}"
    VarSetCapacity(sCLSID, 16, 0)
    VarSetCapacity(sIID,   16, 0)
    DllCall("ole32\CLSIDFromString", "WStr", CLSID, "Ptr", &sCLSID)
    DllCall("ole32\IIDFromString",   "WStr", IID,   "Ptr", &sIID)
    DllCall("ole32\CoInitialize", "Ptr", 0)
    pObj := 0
    DllCall("ole32\CoCreateInstance"
        , "Ptr", &sCLSID, "Ptr", 0, "UInt", 1
        , "Ptr", &sIID, "Ptr*", pObj)
    return pObj
}

UIA_ElementFromHandle(pUIA, hwnd) {
    pEl := 0
    DllCall(NumGet(NumGet(pUIA+0), 6*A_PtrSize)
        , "Ptr", pUIA, "Ptr", hwnd, "Ptr*", pEl)
    return pEl
}

UIA_CreateTrueCondition(pUIA) {
    pC := 0
    DllCall(NumGet(NumGet(pUIA+0), 17*A_PtrSize)
        , "Ptr", pUIA, "Ptr*", pC)
    return pC
}

UIA_FindAll(pEl, scope, pCond) {
    pArr := 0
    DllCall(NumGet(NumGet(pEl+0), 6*A_PtrSize)
        , "Ptr", pEl, "Int", scope, "Ptr", pCond, "Ptr*", pArr)
    return pArr
}

UIA_ArrayLength(pArr) {
    n := 0
    DllCall(NumGet(NumGet(pArr+0), 3*A_PtrSize)
        , "Ptr", pArr, "Int*", n)
    return n
}

UIA_ArrayGetElement(pArr, idx) {
    pEl := 0
    DllCall(NumGet(NumGet(pArr+0), 4*A_PtrSize)
        , "Ptr", pArr, "Int", idx, "Ptr*", pEl)
    return pEl
}

UIA_GetPattern(pEl, patternId) {
    if !pEl
        return 0
    pPat := 0
    DllCall(NumGet(NumGet(pEl+0), 16*A_PtrSize)
        , "Ptr", pEl, "Int", patternId, "Ptr*", pPat)
    return pPat
}

UIA_Release(p) {
    if p
        DllCall(NumGet(NumGet(p+0), 2*A_PtrSize), "Ptr", p)
}

UIA_GetPropStr(pEl, propId) {
    if !pEl
        return ""
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize)
        , "Ptr", pEl, "Int", propId, "Ptr", &var)
    if (hr != 0)
        return ""
    vt := NumGet(var, 0, "UShort")
    if (vt = 8) {
        bstr := NumGet(var, 8, "Ptr")
        str := bstr ? StrGet(bstr, "UTF-16") : ""
    } else
        str := ""
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return str
}

UIA_GetPropInt(pEl, propId) {
    if !pEl
        return 0
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize)
        , "Ptr", pEl, "Int", propId, "Ptr", &var)
    if (hr != 0)
        return 0
    vt := NumGet(var, 0, "UShort")
    if (vt = 3)
        val := NumGet(var, 8, "Int")
    else if (vt = 11)
        val := NumGet(var, 8, "Short") ? 1 : 0
    else
        val := 0
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return val
}

UIA_PatternGetBSTR(pPat, vtIdx) {
    if !pPat
        return ""
    bstr := 0
    DllCall(NumGet(NumGet(pPat+0), vtIdx*A_PtrSize)
        , "Ptr", pPat, "Ptr*", bstr)
    if !bstr
        return ""
    str := StrGet(bstr, "UTF-16")
    DllCall("oleaut32\SysFreeString", "Ptr", bstr)
    return str
}

UIA_SetValue(pEl, newValue) {
    if !pEl
        return false
    pVP := UIA_GetPattern(pEl, 10002)
    if !pVP
        return false
    hr := DllCall(NumGet(NumGet(pVP+0), 3*A_PtrSize)
        , "Ptr", pVP, "WStr", newValue)
    UIA_Release(pVP)
    return (hr = 0)
}

UIA_GetValue(pEl) {
    if !pEl
        return ""
    pVP := UIA_GetPattern(pEl, 10002)
    if !pVP
        return ""
    val := UIA_PatternGetBSTR(pVP, 4)
    UIA_Release(pVP)
    return val
}

; Find grid by AutomationId first, fallback to column header matching
; Optimized: only checks Window.8 controls (grids are always this class)
UIA_FindGrid(pUIA, hwnd, targetAid, fallbackColumns="") {
    WinGet, cList, ControlList, ahk_id %hwnd%
    ; Method 1: AutomationId (only Window.8 controls — skips BUTTON/EDIT/STATIC/etc)
    Loop, Parse, cList, `n
    {
        cNN := A_LoopField
        if (cNN = "" || !InStr(cNN, "Window.8"))
            continue
        ControlGet, cH, Hwnd,, %cNN%, ahk_id %hwnd%
        if !cH
            continue
        pEl := UIA_ElementFromHandle(pUIA, cH)
        if !pEl
            continue
        aid := UIA_GetPropStr(pEl, 30011)
        if (aid = targetAid)
            return pEl
        UIA_Release(pEl)
    }
    ; Method 2: Column header matching
    if (fallbackColumns = "")
        return 0
    Loop, Parse, cList, `n
    {
        cNN := A_LoopField
        if (cNN = "" || !InStr(cNN, "Window.8"))
            continue
        ControlGet, cH, Hwnd,, %cNN%, ahk_id %hwnd%
        if !cH
            continue
        pEl := UIA_ElementFromHandle(pUIA, cH)
        if !pEl
            continue
        pTC := UIA_CreateTrueCondition(pUIA)
        pRows := UIA_FindAll(pEl, 2, pTC)
        UIA_Release(pTC)
        if !pRows {
            UIA_Release(pEl)
            continue
        }
        found := false
        cnt := UIA_ArrayLength(pRows)
        Loop, %cnt% {
            pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
            if !pRow
                continue
            rowName := UIA_GetPropStr(pRow, 30005)
            if (rowName = "Top Row") {
                pTC2 := UIA_CreateTrueCondition(pUIA)
                pCells := UIA_FindAll(pRow, 2, pTC2)
                UIA_Release(pTC2)
                if pCells {
                    cCnt := UIA_ArrayLength(pCells)
                    headerStr := ""
                    Loop, %cCnt% {
                        pC := UIA_ArrayGetElement(pCells, A_Index - 1)
                        if pC {
                            headerStr .= UIA_GetValue(pC) "|"
                            UIA_Release(pC)
                        }
                    }
                    UIA_Release(pCells)
                    if InStr(headerStr, fallbackColumns)
                        found := true
                }
            }
            UIA_Release(pRow)
            if found
                break
        }
        UIA_Release(pRows)
        if found
            return pEl
        UIA_Release(pEl)
    }
    return 0
}

; Read all rows from transaction DataGridView into arrays + keep cell elements for writing
UIA_ReadTransactionRows(pGrid, ByRef rowCode, ByRef rowDesc, ByRef rowEnt28, ByRef rowBalance, ByRef rowSuppQty, ByRef rowSimBal, ByRef rowDays, ByRef rowRegNo, ByRef rowSuppEl, ByRef rowRegNoEl) {
    global g_pUIA
    rowCode := [], rowDesc := [], rowEnt28 := [], rowBalance := []
    rowSuppQty := [], rowSimBal := [], rowDays := [], rowRegNo := []
    rowSuppEl := [], rowRegNoEl := []
    dataRows := 0
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows
        return 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, %rowCount% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rowName := UIA_GetPropStr(pRow, 30005)
        rowCT := UIA_GetPropInt(pRow, 30003)
        if (rowCT = 50014 || rowName = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        pTC2 := UIA_CreateTrueCondition(g_pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if !pCells {
            UIA_Release(pRow)
            continue
        }
        cellCount := UIA_ArrayLength(pCells)
        ; 0=RowHdr 1=Code 2=Desc 3=Ent28 4=Balance 5=SuppQty 6=SimBal 7=Days 8=RegNo
        ; First, peek at the Code cell (ci=1) to skip empty "new row" placeholder
        if (cellCount > 1) {
            pPeek := UIA_ArrayGetElement(pCells, 1)
            peekVal := ""
            if pPeek {
                peekVal := UIA_GetValue(pPeek)
                UIA_Release(pPeek)
            }
            if (peekVal = "" || peekVal = "(null)") {
                ; Empty row — skip (this is the DataGridView "add new" row)
                UIA_Release(pCells)
                UIA_Release(pRow)
                continue
            }
        }
        dataRows++
        r := dataRows
        Loop, %cellCount% {
            ci := A_Index - 1
            pCell := UIA_ArrayGetElement(pCells, ci)
            if !pCell
                continue
            cellVal := UIA_GetValue(pCell)
            if (ci = 1)
                rowCode[r] := cellVal
            else if (ci = 2)
                rowDesc[r] := cellVal
            else if (ci = 3)
                rowEnt28[r] := cellVal
            else if (ci = 4)
                rowBalance[r] := cellVal
            else if (ci = 5) {
                rowSuppQty[r] := cellVal
                rowSuppEl[r] := pCell
                continue
            } else if (ci = 6)
                rowSimBal[r] := cellVal
            else if (ci = 7)
                rowDays[r] := cellVal
            else if (ci = 8) {
                rowRegNo[r] := cellVal
                rowRegNoEl[r] := pCell
                continue
            }
            UIA_Release(pCell)
        }
        UIA_Release(pCells)
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    return dataRows
}

UIA_FreeRowElements(ByRef rowSuppEl, ByRef rowRegNoEl, count) {
    Loop, %count% {
        if rowSuppEl[A_Index]
            UIA_Release(rowSuppEl[A_Index])
        if rowRegNoEl[A_Index]
            UIA_Release(rowRegNoEl[A_Index])
    }
    rowSuppEl := [], rowRegNoEl := []
}

; Get a fresh row element by data row index (1-based). Re-enumerates rows from grid.
UIA_GetDataRowElement(pGrid, dataRowIdx) {
    global g_pUIA
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows
        return 0
    dataIdx := 0
    result := 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, %rowCount% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rn := UIA_GetPropStr(pRow, 30005)
        ct := UIA_GetPropInt(pRow, 30003)
        if (ct = 50014 || rn = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        pTC2 := UIA_CreateTrueCondition(g_pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if pCells {
            peek := ""
            if (UIA_ArrayLength(pCells) > 1) {
                pP := UIA_ArrayGetElement(pCells, 1)
                if pP {
                    peek := UIA_GetValue(pP)
                    UIA_Release(pP)
                }
            }
            UIA_Release(pCells)
            if (peek = "" || peek = "(null)") {
                UIA_Release(pRow)
                continue
            }
        }
        dataIdx++
        if (dataIdx = dataRowIdx) {
            result := pRow
            break
        }
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    return result
}

; Delete a specific data row (1-based index) from a grid.
; Finds grid once, walks to the row, SetFocus, sends {Del}.
UIA_DeleteGridRow(pUIA, hwnd, gridAid, fallbackCols, dataRowIdx) {
    pGrid := UIA_FindGrid(pUIA, hwnd, gridAid, fallbackCols)
    if !pGrid
        return
    pTC := UIA_CreateTrueCondition(pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows {
        UIA_Release(pGrid)
        return
    }
    dataIdx := 0
    rowCount := UIA_ArrayLength(pRows)
    Loop, %rowCount% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rowName := UIA_GetPropStr(pRow, 30005)
        rowCT := UIA_GetPropInt(pRow, 30003)
        if (rowCT = 50014 || rowName = "Top Row") {
            UIA_Release(pRow)
            continue
        }
        ; Skip empty "new row" (same filter as ReadTransactionRows)
        pTC2 := UIA_CreateTrueCondition(pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if pCells {
            skipRow := false
            if (UIA_ArrayLength(pCells) > 1) {
                pPeek := UIA_ArrayGetElement(pCells, 1)
                if pPeek {
                    peekVal := UIA_GetValue(pPeek)
                    UIA_Release(pPeek)
                    if (peekVal = "" || peekVal = "(null)")
                        skipRow := true
                }
            }
            UIA_Release(pCells)
            if skipRow {
                UIA_Release(pRow)
                continue
            }
        }
        dataIdx++
        if (dataIdx = dataRowIdx) {
            ; Activate window (needed for SendInput), SetFocus on row, then {Del}
            WinActivate, ahk_id %hwnd%
            WinWaitActive, ahk_id %hwnd%,, 1
            UIA_ClickRowHeader(pRow)
            Sleep, 10
            SendInput, {Del}
            Sleep, 10
            UIA_Release(pRow)
            break
        }
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    UIA_Release(pGrid)
}

UIA_ClickRowHeader(pRow) {
    global g_pUIA
    if !pRow
        return
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pCells := UIA_FindAll(pRow, 2, pTC)
    UIA_Release(pTC)
    if !pCells
        return
    if (UIA_ArrayLength(pCells) > 0) {
        pHdr := UIA_ArrayGetElement(pCells, 0)
        if pHdr {
            rc := UIA_GetPropRect(pHdr)
            if (rc.l != 0 || rc.t != 0 || rc.r != 0 || rc.b != 0) {
                cx := rc.l + ((rc.r - rc.l) // 2)
                cy := rc.t + ((rc.b - rc.t) // 2)
                CoordMode, Mouse, Screen
                Click, %cx%, %cy%
            }
            UIA_Release(pHdr)
        }
    }
    UIA_Release(pCells)
}

UIA_GetPropRect(pEl) {
    if !pEl
        return {l:0, t:0, r:0, b:0}
    VarSetCapacity(var, 24, 0)
    hr := DllCall(NumGet(NumGet(pEl+0), 10*A_PtrSize), "Ptr", pEl, "Int", 30001, "Ptr", &var)
    if (hr != 0)
        return {l:0, t:0, r:0, b:0}
    vt := NumGet(var, 0, "UShort")
    if (vt = 0x2005) {
        pSA := NumGet(var, 8, "Ptr")
        if pSA {
            pData := 0
            hr2 := DllCall("oleaut32\SafeArrayAccessData", "Ptr", pSA, "Ptr*", pData)
            if (hr2 = 0 && pData) {
                l := NumGet(pData + 0, 0, "Double")
                t := NumGet(pData + 0, 8, "Double")
                w := NumGet(pData + 0, 16, "Double")
                h := NumGet(pData + 0, 24, "Double")
                DllCall("oleaut32\SafeArrayUnaccessData", "Ptr", pSA)
                DllCall("oleaut32\VariantClear", "Ptr", &var)
                return {l: Round(l), t: Round(t), r: Round(l+w), b: Round(t+h)}
            }
            DllCall("oleaut32\SafeArrayUnaccessData", "Ptr", pSA)
        }
    }
    DllCall("oleaut32\VariantClear", "Ptr", &var)
    return {l:0, t:0, r:0, b:0}
}

UIA_ReadPatientDetails(pGrid) {
    global g_pUIA
    result := {}
    pTC := UIA_CreateTrueCondition(g_pUIA)
    pRows := UIA_FindAll(pGrid, 2, pTC)
    UIA_Release(pTC)
    if !pRows
        return result
    rowCount := UIA_ArrayLength(pRows)
    Loop, %rowCount% {
        pRow := UIA_ArrayGetElement(pRows, A_Index - 1)
        if !pRow
            continue
        rowName := UIA_GetPropStr(pRow, 30005)
        if (rowName = "Top Row" || UIA_GetPropInt(pRow, 30003) = 50014) {
            UIA_Release(pRow)
            continue
        }
        pTC2 := UIA_CreateTrueCondition(g_pUIA)
        pCells := UIA_FindAll(pRow, 2, pTC2)
        UIA_Release(pTC2)
        if pCells {
            cCnt := UIA_ArrayLength(pCells)
            attr := "", val := ""
            Loop, %cCnt% {
                pC := UIA_ArrayGetElement(pCells, A_Index - 1)
                if !pC
                    continue
                ci := A_Index - 1
                cv := UIA_GetValue(pC)
                if (ci = 1)
                    attr := cv
                else if (ci = 2)
                    val := cv
                UIA_Release(pC)
            }
            UIA_Release(pCells)
            if (attr = "ID")
                result.ID := val
            else if (attr = "Name")
                result.Name := val
            else if (attr = "Address")
                result.Address := val
            else if (attr = "Gender")
                result.Gender := val
            else if (attr = "Age")
                result.Age := val
            else if (attr = "Date Of Birth")
                result.DOB := val
            else if (attr = "Phone Number")
                result.Phone := val
        }
        UIA_Release(pRow)
    }
    UIA_Release(pRows)
    return result
}

; ============================================================================
;  ROBUST HELPER FUNCTIONS — state-based waits, failure logging, abort-safe
; ============================================================================

; Log a failure message to C:\AHK\UIA_errors.log with timestamp
LogFailure(msg) {
    FormatTime, _ts,, yyyy-MM-dd HH:mm:ss
    FileAppend, [%_ts%] %msg%`n, C:\AHK\UIA_errors.log
}

; Wait for file to exist. Polls every 5ms, gives up after timeoutMs.
WaitForFile(filePath, timeoutMs=500) {
    start := A_TickCount
    Loop {
        if FileExist(filePath)
            return true
        if (A_TickCount - start > timeoutMs) {
            LogFailure("WaitForFile TIMEOUT: " filePath " after " timeoutMs "ms")
            return false
        }
        Sleep, 5
    }
}

; Wait for file to exist, be non-empty, and be STABLE (same size on two
; reads 20ms apart). This confirms the file is fully written and flushed.
; minSize=0 means any non-empty file; set minSize>0 to require minimum bytes.
WaitForFileReady(filePath, timeoutMs=2000, minSize=0) {
    start := A_TickCount
    Loop {
        if FileExist(filePath) {
            FileGetSize, _sz1, %filePath%
            if (_sz1 > minSize) {
                Sleep, 20
                FileGetSize, _sz2, %filePath%
                if (_sz1 = _sz2) {
                    FileRead, _chk, %filePath%
                    if (_chk != "")
                        return true
                }
            }
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("WaitForFileReady TIMEOUT: " filePath " after " timeoutMs "ms")
            return false
        }
        Sleep, 10
    }
}

; Safe text file print: waits for file to be truly ready, prints via
; notepad, tracks PID, waits for process exit + extra settle time to
; ensure print job is handed off to spooler, then kills only our instance.
; Returns true on success, false on failure (logged).
SafePrintTextFile(filePath, timeoutMs=10000) {
    if !WaitForFileReady(filePath, 2000) {
        LogFailure("SafePrintTextFile: file not ready: " filePath)
        return false
    }
    Run, notepad /p "%filePath%",, Hide UseErrorLevel, notePID
    if (ErrorLevel || !notePID) {
        LogFailure("SafePrintTextFile: failed to launch notepad for: " filePath)
        return false
    }
    start := A_TickCount
    exited := false
    Loop {
        Process, Exist, %notePID%
        if !ErrorLevel {
            exited := true
            break
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("SafePrintTextFile: notepad PID " notePID " TIMEOUT after " timeoutMs "ms for: " filePath)
            Process, Close, %notePID%
            Sleep, 100
            break
        }
        Sleep, 50
    }
    if exited
        Sleep, 100
    return exited
}

; Wait for a window with specific TEXT content and a control ready+enabled.
; Resolves the actual window HWND and checks the control against that exact
; instance so the readiness check is tied to the correct dialog.
; Returns the HWND on success, 0 on timeout.
; NOTE: WaitForFileReady assumes a non-empty readable text file. If reused
; for binary files, set minSize and skip the FileRead check.
WaitForWindowReady(winTitle, controlNN="", timeoutMs=15000, winText="") {
    start := A_TickCount
    Loop {
        _wHwnd := 0
        if (winText != "")
            _wHwnd := WinExist(winTitle, winText)
        else
            _wHwnd := WinExist(winTitle)
        if (_wHwnd) {
            if (controlNN = "")
                return _wHwnd
            ControlGet, cHwnd, Hwnd,, %controlNN%, ahk_id %_wHwnd%
            if cHwnd {
                ControlGet, cEnabled, Enabled,, %controlNN%, ahk_id %_wHwnd%
                if (cEnabled)
                    return _wHwnd
            }
        }
        if (A_TickCount - start > timeoutMs) {
            LogFailure("WaitForWindowReady TIMEOUT: title=" winTitle " text=" winText " control=" controlNN " after " timeoutMs "ms")
            return 0
        }
        Sleep, 25
    }
}

; Write a file and wait for it to be ready. Returns true if file is confirmed ready.
WriteAndWaitReady(content, filePath, timeoutMs=2000) {
    FileAppend, %content%, %filePath%
    return WaitForFileReady(filePath, timeoutMs)
}
