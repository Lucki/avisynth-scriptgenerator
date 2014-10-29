#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#Include <WinAPI.au3>
#include <Array.au3>

dim $Resize = False
dim $ChangeFPS = False
dim $Speicherort
dim $Dateien
dim $VideoFPS
dim $RenderFPS
dim $Fehler = 0
dim $geaendert = False

#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("AviSynth Scripterzeuger", 610, 133)
$Input1 = GUICtrlCreateInput("", 104, 40, 377, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("...", 560, 40, 33, 25)
$Input2 = GUICtrlCreateInput("", 504, 40, 49, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSendMsg($Input2, 0x1501, 0, "FPS")
$Label1 = GUICtrlCreateLabel("@", 488, 40, 15, 17)
$Checkbox1 = GUICtrlCreateCheckbox("Größe ändern", 24, 64, 81, 25)
$Input3 = GUICtrlCreateInput("", 112, 64, 97, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSendMsg($Input3, 0x1501, 0, "Breite")
$Input4 = GUICtrlCreateInput("", 232, 64, 81, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSendMsg($Input4, 0x1501, 0, "Höhe")
$Label2 = GUICtrlCreateLabel("x", 216, 64, 9, 17)
$Label3 = GUICtrlCreateLabel("@", 320, 64, 15, 17)
$Input5 = GUICtrlCreateInput("", 336, 64, 57, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSendMsg($Input5, 0x1501, 0, "FPS")
$Checkbox2 = GUICtrlCreateCheckbox("Framerate ändern", 400, 64, 105, 17)
$Input6 = GUICtrlCreateInput("", 144, 8, 409, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button2 = GUICtrlCreateButton("...", 560, 8, 33, 25)
$Button3 = GUICtrlCreateButton("Script erzeugen", 24, 96, 281, 25)
$Button4 = GUICtrlCreateButton("Beenden", 312, 96, 281, 25)
$Label4 = GUICtrlCreateLabel("Speicherort und -name:", 24, 8, 114, 17)
$Label5 = GUICtrlCreateLabel("Videodateien:", 24, 40, 69, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button4
			Exit
		Case $CheckBox1
			If GUICtrlRead($Checkbox1) = 1 Then
				GUICtrlSetState($Input3, $GUI_ENABLE)
				GUICtrlSetState($Input4, $GUI_ENABLE)
				$Resize = True
			ElseIf GUICtrlRead($Checkbox1) = 4 Then
				GUICtrlSetState($Input3, $GUI_DISABLE)
				GUICtrlSetState($Input4, $GUI_DISABLE)
				$Resize = False
			EndIf
		Case $Checkbox2
			If GUICtrlRead($Checkbox2) = 1 Then
				$ChangeFPS = True
				GUICtrlSetState($Input5, $GUI_ENABLE)
			ElseIf GUICtrlRead($Checkbox2) = 4 Then
				GUICtrlSetState($Input5, $GUI_DISABLE)
				$ChangeFPS = False
			EndIf
		Case $Button1
			$Dateien = _WinAPI_GetOpenFileName("Videodateien","Videos (*.avi)",@WorkingDir & "","",".avi",0,BitOR($OFN_ALLOWMULTISELECT, $OFN_HIDEREADONLY, $OFN_EXPLORER))
			$Anzeige = $Dateien[1]
			For $i = 2 To UBound($Dateien)-1
				$Anzeige = $Anzeige & "|" & $Dateien[$i]
			Next
			GUICtrlSetData($Input1,$Anzeige)
		Case $Button2
			$Speicherort = _WinAPI_GetSaveFileName("Speicherort","AviSynth Scriptdateien (*.avs)",@WorkingDir,"Mein erstes Avisynthscript.avs",".avs",0,BitOR($OFN_OVERWRITEPROMPT, $OFN_HIDEREADONLY, $OFN_EXPLORER))
			GUICtrlSetData($Input6,$Speicherort[1] & "\" & $Speicherort[2])
			$geaendert = False
		Case $Button3
			If $Dateien = "" Then
				MsgBox(0,"Vervollständigen","Bitte trage einen korrekten Pfad für die Videodateien ein.")
				; Hier muss Fertigstellen() übersprungen werden!!!!
				$Fehler = $Fehler + 1
			EndIf
			
			If $Speicherort = "" Then
				MsgBox(0,"Vervollständigen","Bitte trage einen korrekten Pfad für den Speicherort ein.")
				; Hier muss Fertigstellen() übersprungen werden!!!!
				$Fehler = $Fehler + 1
			EndIf
			
			If $Resize = True And GUICtrlRead($Input3) > 0 And GUICtrlRead($Input4) > 0 And StringIsDigit(GUICtrlRead($Input3)) = 1 And StringIsDigit(GUICtrlRead($Input4)) = 1 Then
				$Breite = GUICtrlRead($Input3)
				$Hoehe = GUICtrlRead($Input4)
			ElseIf $Resize = True Then
				MsgBox(0,"Vervollständigen","Bitte trage eine Zahl für die Auflösung ein.")
				; Hier muss Fertigstellen() übersprungen werden!!!!
				$Fehler = $Fehler + 1
			EndIf
			
			If $ChangeFPS = True And GUICtrlRead($Input5) > 0 And StringIsDigit(GUICtrlRead($Input5)) = 1 Then
				$RenderFPS = GUICtrlRead($Input5)
			ElseIf $ChangeFPS = True Then
				MsgBox(0,"Vervollständigen","Bitte trage eine Zahl für die gewünschte Framerate ein.")
				; Hier muss Fertigstellen() übersprungen werden!!!!
				$Fehler = $Fehler + 1
			EndIf
			
			If GUICtrlRead($Input2) <= 0 Or StringIsDigit(GUICtrlRead($Input2)) <> 1 Then
				MsgBox(0,"Vervollständigen","Bitte trage eine Zahl für die vorhandene Framerate ein.")
				; Hier muss Fertigstellen() übersprungen werden!!!!
				$Fehler = $Fehler + 1
			EndIf
			
			$VideoFPS = GUICtrlRead($Input2)
			
			If $Fehler = 0 And $geaendert = False Then
				Fertigstellen()
			ElseIf $Fehler = 0 And $geaendert = True Then
				If MsgBox(0x4,"Änderung","Der Speicherort wurde nicht geändert." & @CRLF & "Fortfahren?")<>7 Then
					Fertigstellen()
				EndIf
			EndIf
			
			$Fehler = 0
	EndSwitch
WEnd

Func Fertigstellen()
	$geaendert = True
	$Datei = $Speicherort[1] & "\" & $Speicherort[2]
	;_FileCreate($Datei)
	FileOpen($Datei,2)
	FileWrite($Datei,'AVISource("')
	
	FileWrite($Datei,$Dateien[1] & "\" & $Dateien[2] & '"')
	For $i = 3 To UBound($Dateien)-1
		FileWrite($Datei,',"' & $Dateien[1] & "\" & $Dateien[$i] & '"')
	Next
	
	FileWrite($Datei,").AssumeFPS(" & $VideoFPS & ")" & @CRLF)
	
	If $Resize = True Then
		FileWrite($Datei,"Lanczos4Resize(" & $Breite & "," & $Hoehe & ")" & @CRLF)
	EndIf
	
	If $ChangeFPS = True Then
		FileWrite($Datei,"ChangeFPS(" & $RenderFPS & ")" & @CRLF)
	EndIf
	
	FileWrite($Datei,"ConvertToYV12()" & @CRLF)
	FileClose($Datei)
	
	If MsgBox(0x4,"Fertig","Möchtest du dir das Script ansehen?")<>7 Then
		ShellExecute("notepad.exe", $Datei)
	EndIf
EndFunc
