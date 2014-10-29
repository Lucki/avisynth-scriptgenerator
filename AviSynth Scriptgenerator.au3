#cs
Noch zu tun:
	-Runden?
	-Overlay zusammenfassen?
#ce

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon.ico
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#Include <WinAPI.au3>
#include <Array.au3>
#include <GDIPlus.au3>
#include <ComboConstants.au3>
#include <GUIListBox.au3>
#include <SliderConstants.au3>

;#RequireAdmin

#region ;Dim
dim $Bild[3]
dim $Speicherort[3]
dim $aktuelleVersion = 4
dim $Fehler[1]
dim $Ton[9][4]
If Not FileExists(@ScriptDir & "\Optionen.ini") Then
	_FileCreate(@ScriptDir & "\Optionen.ini")
EndIf
dim $Ini = @ScriptDir & "\Optionen.ini"
dim $Standardordner = IniRead($Ini,"Allgemein","Standardordner",@WorkingDir)
#endregion

#Region ### START Koda GUI section ### Form=
$Form5 = GUICreate("Tonspuren", 260, 170,-1,-1,-1,-1,$Form1)
$Slider1 = GUICtrlCreateSlider(0, 0, 260, 33)
GUICtrlSetLimit(-1, 6, 0)
GUICtrlSetData(-1,IniRead($Ini,"Tonspuren","AnzahlSpuren","0"))
$Combo1 = GUICtrlCreateCombo("", 72, 40, 185, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Stereo|Mono","Stereo")
GUICtrlSetState(-1, $GUI_DISABLE)
$Combo2 = GUICtrlCreateCombo("", 72, 64, 185, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1,"3|2.9|2.8|2.7|2.6|2.5|2.4|2.3|2.2|2.1|2|1.9|1.8|1.7|1.6|1.5|1.4|1.3|1.2|1.1|1|0.9|0.8|0.7|0.6|0.5|0.4|0.3|0.2|0.1|0", "1")
GUICtrlSetState(-1, $GUI_DISABLE)
$List1 = GUICtrlCreateList("", 8, 40, 57, 123)
GUICtrlSetData(-1, "Spur 1|Spur 2", "")
$Button9 = GUICtrlCreateButton("Fertig", 72, 112, 185, 25)
$Button10 = GUICtrlCreateButton("Abbrechen", 72, 136, 185, 25)
$Button14 = GUICtrlCreateButton("Rohspur anhören", 72, 88, 92, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button15 = GUICtrlCreateButton("Ext. hinz.", 164, 88, 92, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
#EndRegion ### END Koda GUI section ###

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Schritt 1", 191, 94, 351, 240)
$MenuItem1 = GUICtrlCreateMenu("&Allgemein")
$MenuItem6 = GUICtrlCreateMenuItem("Einstellungen"", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenuItem("Auf Updates prüfen", $MenuItem1)
$MenuItem8 = GUICtrlCreateMenuItem("Erstelle Desktopverknüpfung", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuItem("Beenden", $MenuItem1)
$MenuItem2 = GUICtrlCreateMenu("?")
$MenuItem4 = GUICtrlCreateMenuItem("Hilfe", $MenuItem2)
$MenuItem3 = GUICtrlCreateMenuItem("Über", $MenuItem2)
$Button1 = GUICtrlCreateButton("Weiter", 120, 8, 65, 25)
GUIStartGroup()
$Radio1 = GUICtrlCreateRadio("Skript erstellen", 16, 16, 105, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("Vorhandenes Skript muxen", 16, 40, 153, 17)
GUIStartGroup()
Dim $Form1_AccelTable[3][2] = [["!+4", $MenuItem6],["^{5 (ZEHNERTASTATUR)}", $MenuItem8],["!{FESTSTELL}", $MenuItem3]]
GUISetAccelerators($Form1_1_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=A:\Daten\Avisynth Scriptgenerator\Form4.kxf
$Form4 = GUICreate("Muxen", 482, 71, 262, 515)
$Label1 = GUICtrlCreateLabel("Skriptname:", 8, 8, 60, 17)
$Input1 = GUICtrlCreateInput("", 80, 8, 321, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("...", 416, 8, 57, 25)
$Checkbox1 = GUICtrlCreateCheckbox("ungefähr Schneiden nach", 8, 40, 145, 25)
$Input2 = GUICtrlCreateInput("", 152, 40, 41, 21)
GUICtrlSetTip(-1, "15")
$Label2 = GUICtrlCreateLabel("Minuten", 200, 48, 42, 17)
$Button2 = GUICtrlCreateButton("Muxen", 376, 40, 97, 25)
$Button3 = GUICtrlCreateButton("Zurück", 280, 40, 89, 25)
#EndRegion ### END Koda GUI section ###

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=a:\daten\avisynth scriptgenerator\form2.kxf
$Form2 = GUICreate("Schritt 2", 483, 246, 262, 226)
$MenuItem2 = GUICtrlCreateMenu("&Allgemein")
$MenuItem6 = GUICtrlCreateMenuItem("Einstellungen", $MenuItem2)
$MenuItem5 = GUICtrlCreateMenuItem("Erstelle Desktopverknüpfung", $MenuItem2)
$MenuItem4 = GUICtrlCreateMenuItem("Auf Updates prüfen", $MenuItem2)
$MenuItem3 = GUICtrlCreateMenuItem("Beenden", $MenuItem2)
$MenuItem1 = GUICtrlCreateMenu("?")
$MenuItem8 = GUICtrlCreateMenuItem("Hilfe", $MenuItem1)
$MenuItem7 = GUICtrlCreateMenuItem("Über", $MenuItem1)
$Label1 = GUICtrlCreateLabel("Skriptname:", 8, 8, 60, 17)
$Input1 = GUICtrlCreateInput("", 88, 8, 321, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button1 = GUICtrlCreateButton("...", 424, 8, 49, 21)
$Label2 = GUICtrlCreateLabel("Videodateien:", 8, 40, 69, 17)
$Input2 = GUICtrlCreateInput("", 88, 40, 321, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Button2 = GUICtrlCreateButton("...", 424, 40, 49, 21)
$Group1 = GUICtrlCreateGroup("Allgemeine Änderungen", 8, 128, 465, 57)
$Input5 = GUICtrlCreateInput("", 112, 152, 41, 21)
GUICtrlSetTip(-1, "1152")
$Input6 = GUICtrlCreateInput("", 280, 152, 25, 21)
GUICtrlSetTip(-1, "25")
$Checkbox1 = GUICtrlCreateCheckbox("Frames per Second:", 160, 152, 113, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Höhe in Pixel:", 24, 152, 89, 17)
$Button3 = GUICtrlCreateButton("Ton", 320, 152, 137, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Informationen des vorliegenden Materials", 8, 64, 465, 57)
$Label3 = GUICtrlCreateLabel("Höhe in Pixel:", 16, 88, 69, 17)
$Input3 = GUICtrlCreateInput("", 104, 88, 41, 21)
GUICtrlSetTip(-1, "1080")
$Label4 = GUICtrlCreateLabel("Frames per Second:", 160, 88, 99, 17)
$Input4 = GUICtrlCreateInput("", 264, 88, 25, 21)
GUICtrlSetTip(-1, "30")
GUIStartGroup()
$Radio1 = GUICtrlCreateRadio("16:9", 304, 88, 49, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("16:10", 408, 88, 49, 17)
$Radio3 = GUICtrlCreateRadio("4:3", 360, 88, 41, 17)
GUIStartGroup()
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button4 = GUICtrlCreateButton("Weiter", 232, 192, 241, 25)
$Button5 = GUICtrlCreateButton("Zurück", 8, 192, 217, 25)
#EndRegion ### END Koda GUI section ###

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=a:\daten\avisynth scriptgenerator\form3.kxf
$Form3 = GUICreate("Schritt 3", 320, 142, 1526, 63)
$MenuItem1 = GUICtrlCreateMenu("Allgemein")
$MenuItem5 = GUICtrlCreateMenuItem("Einstellungen", $MenuItem1)
$MenuItem4 = GUICtrlCreateMenuItem("Auf Updates prüfen", $MenuItem1)
$MenuItem8 = GUICtrlCreateMenuItem("Erstelle Desktopverknüpfung", $MenuItem1)
$MenuItem3 = GUICtrlCreateMenuItem("Beenden", $MenuItem1)
$MenuItem2 = GUICtrlCreateMenu("?")
$MenuItem7 = GUICtrlCreateMenuItem("Hilfe", $MenuItem2)
$MenuItem6 = GUICtrlCreateMenuItem("Über", $MenuItem2)
$Checkbox1 = GUICtrlCreateCheckbox("Im Texteditor öffnen", 8, 8, 129, 25)
GUICtrlSetState(-1, IniRead($Ini,"Schritt3","Texteditor","$GUI_UNCHECKED"))
$Checkbox2 = GUICtrlCreateCheckbox("Beinhaltenden Ordner anzeigen", 8, 35, 169, 25)
GUICtrlSetState(-1, IniRead($Ini,"Schritt3","Ordner","$GUI_UNCHECKED"))
$Checkbox3 = GUICtrlCreateCheckbox("MeGUI öffnen", 8, 61, 129, 25)
GUICtrlSetState(-1, IniRead($Ini,"Schritt3","MeGUI","$GUI_UNCHECKED"))
$Button1 = GUICtrlCreateButton("Skript erstellen", 192, 72, 113, 33)
$Checkbox4 = GUICtrlCreateCheckbox("Im Anschluss beenden", 8, 88, 129, 25))
GUICtrlSetState(-1, IniRead($Ini,"Schritt3","Beenden","$GUI_CHECKED"))
$Button2 = GUICtrlCreateButton("Zurück", 192, 8, 113, 33)
Dim $Form3_AccelTable[2][2] = [["m", $MenuItem5],["!d", $MenuItem6]]
GUISetAccelerators($Form3_AccelTable)
#EndRegion ### END Koda GUI section ###

showsplash()
LadeEinstellungen()

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $Form3
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE, $MenuItem5
					beenden()
				Case $MenuItem4
					checkUpdate()
				Case $MenuItem7
					ShellExecute("http://www.letsplayforum.de/index.php?page=Thread&threadID=39887")
				Case $Checkbox1
					IniWrite($Ini,"Schritt3","Texteditor",GUICtrlGetState($Checkbox1))
				Case $Checkbox2
					IniWrite($Ini,"Schritt3","Ordner",GUICtrlGetState($Checkbox2))
				Case $Checkbox3
					IniWrite($Ini,"Schritt3","MeGUI",GUICtrlGetState($Checkbox3))
				Case $Checkbox4
					IniWrite($Ini,"Schritt3","Beenden",GUICtrlGetState($Checkbox4))
				Case $Button1
					;Skript erstellen
				Case $Button2
					GUISetState(@SW_HIDE,$Form3)
					GUISetState(@SW_SHOW,$Form2)
			EndSwitch
		Case $Form2
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE, $Button10
					GUISetState(@SW_HIDE,$Form2)
					GUICtrlSetState($Checkbox6, $GUI_UNCHECKED)
					GUICtrlSetState($Button8,$GUI_HIDE)
					$Audio = False
					GUISetState(@SW_ENABLE, $Form1)
					WinActivate("AviSynth Scriptgenerator")
				Case $Slider1
					Local $Spuren = GUICtrlRead($Slider1)
					anzahlaendern($Spuren)
					IniWrite($Ini,"Ton","AnzahlSpuren",$Spuren)
				Case $List1
					GUICtrlSetState($Combo1, $GUI_ENABLE)
					GUICtrlSetState($Button14, $GUI_ENABLE)
					$Spur = StringMid(GUICtrlRead($List1),6)
					;If $Fraps = True And $Spur = 1 Then
					;	GUICtrlSetState($Button15, $GUI_DISABLE)
					;Else
						GUICtrlSetState($Button15, $GUI_ENABLE)
					;EndIf
					If $Ton[$Spur][3] <> "" Then
						GUICtrlSetData($Button15,"Ext. entf.")
					Else
						GUICtrlSetData($Button15,"Ext. hinz.")
					EndIf
					setzeDaten($Spur)
				Case $Button15
					If $Ton[$Spur][3] <> "" Then
						$Ton[$Spur][3] = ""
						GUICtrlSetData($Button15,"Ext. hinz.")
					Else
						Local $a = _WinAPI_GetOpenFileName("Externe Spur hinzufügen","Wav (*.wav)",$Standardordner,"Meine Tondatei.wav",".wav",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
						If $a[0] <> 0 Then
							$Ton[$Spur][3] = $a[1] & "\" & $a[2]
							GUICtrlSetData($Button15,"Ext. entf.")
						EndIf
					EndIf
				Case $Combo1
					$Spur = StringMid(GUICtrlRead($List1),6)
					$Ton[$Spur][1] = GUICtrlRead($Combo1)
					IniWrite($Ini,"Ton","Ton[" & $Spur & "][1]",GUICtrlRead($Combo1))
				Case $Combo2
					$Spur = StringMid(GUICtrlRead($List1),6)
					$Ton[$Spur][2] = GUICtrlRead($Combo2)
					IniWrite($Ini,"Ton","Ton[" & $Spur & "][2]",GUICtrlRead($Combo2))
				Case $Button9
					GUISetState(@SW_HIDE,$Form2)
					GUISetState(@SW_ENABLE, $Form1)
					WinActivate("AviSynth Scriptgenerator")
				Case $Button14
					If $Ton[$Spur][3] = "" Then
						If $Fraps = True Then
							ShellExecute($Dateien[1] & "\" & $Dateien[2])
						Else
							If IniRead($Ini,"Allgemein","Splitter","") = "" Then
								If FileExists(@ProgramFilesDir & "\Dxtory Software\Dxtory2.0\AudioStreamSplitter.exe") = 1 Then
									IniWrite($Ini,"Allgemein","Splitter",@ProgramFilesDir & "\Dxtory Software\Dxtory2.0\AudioStreamSplitter.exe")
								Else
									MsgBox(0,"Vervollständigen","DxTory liegt nicht im Standardordner." & @CRLF & 'Bitte gib den Ort von "DxTory.exe" an')
									Local $b[3]
									While $b[1] <> ""
										$b = _WinAPI_GetOpenFileName("dxtory.exe","Ausführbare Dateien (*.exe)",$Standardordner,"AudioStreamSplitter.exe",".exe",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
									WEnd
									IniWrite($Ini,"Allgemein","Splitter",$b[1] & "\AudioStreamSplitter.exe")
								EndIf
							EndIf
							Local $a = $a & '"' & $Dateien[1] & "\" & $Dateien[2] & '"'
							For $i = 3 To UBound($Dateien)-1
								$a = $a & ' "' & $Dateien[1] & "\" & $Dateien[$i] & '"'
							Next
							ShellExecuteWait(IniRead($Ini,"Allgemein","Splitter",""),$a)
							ShellExecute($Dateien[1] & "\" & StringMid($Dateien[2],1,StringInStr($Dateien[2],".")-1) & " st" & $Spur-1 & '.wav')
						EndIf
					Else
						ShellExecute($Ton[$Spur][3])
					EndIf
			EndSwitch
	EndSwitch
WEnd

Func LadeEinstellungen()
	$Ton[0][0] = IniRead($Ini,"Ton","Ton[0][0]","1")
	$Ton[1][1] = IniRead($Ini,"Ton","Ton[1][1]","Stereo")
	$Ton[2][1] = IniRead($Ini,"Ton","Ton[2][1]","Mono")
	$Ton[3][1] = IniRead($Ini,"Ton","Ton[3][1]","Stereo")
	$Ton[4][1] = IniRead($Ini,"Ton","Ton[4][1]","Stereo")
	$Ton[5][1] = IniRead($Ini,"Ton","Ton[5][1]","Stereo")
	$Ton[6][1] = IniRead($Ini,"Ton","Ton[6][1]","Stereo")
	$Ton[7][1] = IniRead($Ini,"Ton","Ton[7][1]","Stereo")
	$Ton[8][1] = IniRead($Ini,"Ton","Ton[8][1]","Stereo")
	$Ton[1][2] = IniRead($Ini,"Ton","Ton[1][2]","1")
	$Ton[2][2] = IniRead($Ini,"Ton","Ton[2][2]","1")
	$Ton[3][2] = IniRead($Ini,"Ton","Ton[3][2]","1")
	$Ton[4][2] = IniRead($Ini,"Ton","Ton[4][2]","1")
	$Ton[5][2] = IniRead($Ini,"Ton","Ton[5][2]","1")
	$Ton[6][2] = IniRead($Ini,"Ton","Ton[6][2]","1")
	$Ton[7][2] = IniRead($Ini,"Ton","Ton[7][2]","1")
	$Ton[8][2] = IniRead($Ini,"Ton","Ton[8][2]","1")

	$Bild[1] = StringMid(IniRead($Ini,"Allgemein","Bild",""),1,StringInStr(IniRead($Ini,"Allgemein","Bild",""),"\",0,-1)-1)
	$Bild[2] = StringMid(IniRead($Ini,"Allgemein","Bild",""),StringInStr(IniRead($Ini,"Allgemein","Bild",""),"\",0,-1)+1)
	GUICtrlSetData($Input8,$Bild[1] & "\" & $Bild[2])

	anzahlaendern(IniRead($Ini,"Merke","AnzahlSpuren","0"))
	GUICtrlSetState($Checkbox16,$GUI_CHECKED)
EndFunc

Func anzahlaendern($Spuren)
	Switch $Spuren
		Case 0
			GUICtrlSetData($List1, "|Spur 1|Spur 2")
			$Ton[0][0] = 2
		Case 1
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3")
			$Ton[0][0] = 3
		Case 2
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3|Spur 4")
			$Ton[0][0] = 4
		Case 3
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3|Spur 4|Spur 5")
			$Ton[0][0] = 5
		Case 4
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3|Spur 4|Spur 5|Spur 6")
			$Ton[0][0] = 6
		Case 5
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3|Spur 4|Spur 5|Spur 6|Spur 7")
			$Ton[0][0] = 7
		Case 6
			GUICtrlSetData($List1, "|Spur 1|Spur 2|Spur 3|Spur 4|Spur 5|Spur 6|Spur 7|Spur 8")
			$Ton[0][0] = 8
	EndSwitch
EndFunc
#region ;Check
Func setzeDaten($Spur)
	GUICtrlSetData($Combo1,"|Stereo|Mono",$Ton[$Spur][1])
	GUICtrlSetState($Combo2, $GUI_ENABLE)
	GUICtrlSetData($Combo2,"|3|2.9|2.8|2.7|2.6|2.5|2.4|2.3|2.2|2.1|2|1.9|1.8|1.7|1.6|1.5|1.4|1.3|1.2|1.1|1|0.9|0.8|0.7|0.6|0.5|0.4|0.3|0.2|0.1|0",$Ton[$Spur][2])
EndFunc

Func checkInput($Input)
	If GUICtrlRead($Input) <= 0 Or StringIsDigit(GUICtrlRead($Input)) <> 1 Then
		Return False
	EndIf
	Return True
EndFunc

Func checkInput1()
	If GUICtrlRead($Input1) = "" Or GUICtrlRead($Input1) = "|" Then
		_ArrayAdd($Fehler,"Bitte trage einen korrekten Pfad für die Videodateien ein.")
	EndIf
EndFunc

Func checkSpeicherort()
	If $Speicherort[1] = "" Or $Speicherort[2] = "" Or GUICtrlRead($Input6) = "Mein erstes Avisynthscript.avs\Mein erstes Avisynthscript.avs" Or GUICtrlRead($Input6) = "" Then
		_ArrayAdd($Fehler,"Bitte trage einen korrekten Pfad für den Speicherort ein.")
	EndIf
EndFunc

Func checkBilder()
	If GUICtrlRead($Input8) = "" Or GUICtrlRead($Input8) = "\" Or GUICtrlRead($Input9) = "" Or GUICtrlRead($Input9) = "\" Then
		_ArrayAdd($Fehler,"Bitte trage einen korrekten Pfad für das Bild ein.")
	Else
		_GDIPlus_Startup()
		;MsgBox(0,"",Round((((($PlayerHoehe/9)*16)-(($PlayerHoehe*($VideoBreite/$VideoHoehe))))/2),0))
		If $VideoBreite/$VideoHoehe <= 16/9 And $PlayerHoehe > 0  And _GDIPlus_ImageGetHeight(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> $PlayerHoehe Then
			_ArrayAdd($Fehler,"Die Bildhöhe des linken Bildes stimmt nicht mit der gewünschten Höhe überein.")
		ElseIf $VideoBreite/$VideoHoehe > 16/9 And $PlayerHoehe > 0  And _GDIPlus_ImageGetHeight(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> Round(((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2),0) Then
			_ArrayAdd($Fehler,"Die Bildhöhe des oberen Bildes verträgt sich nicht mit der gewünschten Höhe.")
		EndIf
		If $VideoBreite/$VideoHoehe <= 16/9 And $PlayerHoehe > 0 And GUICtrlRead($Input10) > 0 And _GDIPlus_ImageGetWidth(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> Round((((($PlayerHoehe/9)*16)-(($PlayerHoehe*($VideoBreite/$VideoHoehe))))/2),0) Then
			_ArrayAdd($Fehler,"Die Bildbreite des linken Bildes verträgt sich nicht mit der gewünschten Höhe.")
		ElseIf $VideoBreite/$VideoHoehe > 16/9 And $PlayerHoehe > 0 And GUICtrlRead($Input10) > 0 And _GDIPlus_ImageGetWidth(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> (($PlayerHoehe/9)*16) Then
			_ArrayAdd($Fehler,"Die Bildbreite des oberen Bildes stimmt nicht mit der gewünschten Höhe überein.")
		EndIf
		If $VideoBreite/$VideoHoehe <= 16/9 And $PlayerHoehe > 0  And _GDIPlus_ImageGetHeight(_GDIPlus_ImageLoadFromFile($BildRechts[1] & "\" & $BildRechts[2])) <> $PlayerHoehe Then
			_ArrayAdd($Fehler,"Die Bildhöhe des rechten Bildes stimmt nicht mit der gewünschten Höhe überein.")
		ElseIf $VideoBreite/$VideoHoehe > 16/9 And $PlayerHoehe > 0  And _GDIPlus_ImageGetHeight(_GDIPlus_ImageLoadFromFile($BildRechts[1] & "\" & $BildRechts[2])) <> Round(((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2),0) Then
			_ArrayAdd($Fehler,"Die Bildhöhe des unteren Bildes verträgt sich nicht mit der gewünschten Höhe.")
		EndIf
		If $VideoBreite/$VideoHoehe <= 16/9 And $PlayerHoehe > 0 And GUICtrlRead($Input10) > 0 And _GDIPlus_ImageGetWidth(_GDIPlus_ImageLoadFromFile($BildRechts[1] & "\" & $BildRechts[2])) <> Round((((($PlayerHoehe/9)*16)-(($PlayerHoehe*($VideoBreite/$VideoHoehe))))/2),0) Then
			_ArrayAdd($Fehler,"Die Bildbreite des rechten Bildes verträgt sich nicht mit der gewünschten Höhe.")
		ElseIf $VideoBreite/$VideoHoehe > 16/9 And $PlayerHoehe > 0 And GUICtrlRead($Input10) > 0 And _GDIPlus_ImageGetWidth(_GDIPlus_ImageLoadFromFile($BildRechts[1] & "\" & $BildRechts[2])) <> (($PlayerHoehe/9)*16) Then
			_ArrayAdd($Fehler,"Die Bildbreite des unteren Bildes stimmt nicht mit der gewünschten Höhe überein.")
		EndIf
		_GDIPlus_Shutdown()
	EndIf
EndFunc

Func checkVerlauf()
	If GUICtrlRead($Input8) = "" Or GUICtrlRead($Input8) = "\" Then
		_ArrayAdd($Fehler,"Bitte trage einen korrekten Pfad für das Verlaufsbild ein.")
	Else
		_GDIPlus_Startup()
		If $PlayerHoehe > 0  And _GDIPlus_ImageGetHeight(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> $PlayerHoehe Then
			_ArrayAdd($Fehler,"Die Bildhöhe des Verlaufsbildes stimmt nicht mit der gewünschten Höhe überein.")
		EndIf
		If $PlayerHoehe > 0 And GUICtrlRead($Input10) > 0 And _GDIPlus_ImageGetWidth(_GDIPlus_ImageLoadFromFile($BildLinks[1] & "\" & $BildLinks[2])) <> (($PlayerHoehe/9)*16) Then
			_ArrayAdd($Fehler,"Die Bildbreite des Verlaufsbildes verträgt sich nicht mit der gewünschten Höhe.")
		EndIf
		_GDIPlus_Shutdown()
	EndIf
EndFunc
#endregion

#region ;Muxen
Func checkFiles()
	If Not FileExists($DateiMKV) Then
		_ArrayAdd($Fehler,"Es liegt keine Videodatei mit dem Namen " & $DateiMKV & " vor.")
	EndIf
	If Not FileExists($DateiOGG) Then
		If FileExists($DateiFLAC) Then
			$DateiFLAC = $DateiOGG
		Else
			_ArrayAdd($Fehler,"Es liegt keine Tondatei mit dem Namen " & $DateiOGG & " vor.")
		EndIf
	EndIf
EndFunc

Func Muxen($Pfad)
	Switch $Schneiden
		Case True
			Local $Parameter = ' -o "' & ($Speicherort[1] & "\" & StringMid($Speicherort[2],1,StringInStr($Speicherort[2],".",0)-1) & '-muxed.mkv" "') & '--forced-track" "0:no" "--compression" "0:none" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "' & $DateiOGG & '" "--language" "0:ger" "--default-track" "0:yes" "--forced-track" "0:no" "--compression" "0:none" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "' & $DateiMKV & '" "--track-order" "0:0,1:0" "--split" "duration:' & GUICtrlRead($Input12) & ':00"'
		Case False
			Local $Parameter = ' -o "' & ($Speicherort[1] & "\" & StringMid($Speicherort[2],1,StringInStr($Speicherort[2],".",0)-1) & '-muxed.mkv" "') & '--forced-track" "0:no" "--compression" "0:none" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "' & $DateiOGG & '" "--language" "0:ger" "--default-track" "0:yes" "--forced-track" "0:no" "--compression" "0:none" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "' & $DateiMKV & '" "--track-order" "0:0,1:0"'
	EndSwitch
	ShellExecuteWait($Pfad,$Parameter)
	If MsgBox(0x4,"Fertig","Möchtest du den Scriptordner ansehen?")<>7 Then
		ShellExecute($Speicherort[1] & "\")
	EndIf
EndFunc
#endregion

#region ;GUICtrl

#endregion

Func Resize($B,$H)
	FileWrite($Datei,".Lanczos4Resize(" & $B & "," & $H & ")")
EndFunc

Func Fertigstellen()
	$geaendert = True
	$File = $Speicherort[1] & "\" & $Speicherort[2]
	If $Randbild = False And $Randverlauf = False Then
		schreibe("Vorne")
		schreibe("Hinten")
	ElseIf $erweitert = True And $Randbild = True Then
		schreibe("Vorne")

		If $VideoBreite/$VideoHoehe < 16/9 Then
			Resize(($PlayerHoehe*($VideoBreite/$VideoHoehe)),$PlayerHoehe)
			;FileWrite($Datei,".AddBorders(" & (((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & ",0," & (((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & ",0)")
		ElseIf $VideoBreite/$VideoHoehe > 16/9 Then
			Resize(($PlayerHoehe/9)*16,(($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))
			;FileWrite($Datei,".AddBorders(0," & ((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2) & ",0," & ((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2) & ")")
		EndIf
		FileWrite($Datei,".AddBorders(" & (((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & "," & ((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2) & "," & (((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & "," & ((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2) & ")")

		FileWrite($Datei,'.Overlay(ImageReader("' & $BildLinks[1] & "\" & $BildLinks[2] & '"))')
		FileWrite($Datei,'.Overlay(ImageReader("' & $BildRechts[1] & "\" & $BildRechts[2] & '"),' & (((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & "," & ((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2) & ")")

		schreibe("Hinten")

	ElseIf $erweitert = True And $Randverlauf = True Then
		schreibe("Vorne")

		FileWrite($Datei,@CRLF & "Verschwommen = Video.Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False).Blur(1.58,MMX=False)")

		Local $d = $VideoBreite
		If $VideoBreite < (($PlayerHoehe/9)*16) Or $VideoHoehe < $PlayerHoehe Then
			;Mod($d,($VideoBreite/$VideoHoehe)) <> 0 Or
			While $d < (($PlayerHoehe/9)*16) Or $d/($VideoBreite/$VideoHoehe) < $PlayerHoehe
				$d = $d + 1
			WEnd
			FileWrite($Datei,".Lanczos4Resize(" & $d & "," & ($d/($VideoBreite/$VideoHoehe)) & ")")
		EndIf
		#cs
		If $VideoBreite/$VideoHoehe < 16/9 Then
			FileWrite($Datei,".Crop(0," & Abs((($d/($VideoBreite/$VideoHoehe))-$PlayerHoehe)/2) & ",0,-" & Abs((($d/($VideoBreite/$VideoHoehe))-$PlayerHoehe)/2) & ")" & @CRLF)
		ElseIf $VideoBreite/$VideoHoehe > 16/9 Then
			FileWrite($Datei,".Crop(" & Abs(($d-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & ",0," & Abs(($d-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2) & ",-0)" & @CRLF)
		EndIf
		#ce
		FileWrite($Datei,".Crop(" & Abs(($d-($PlayerHoehe/9)*16)/2) & "," & Abs((($d/($VideoBreite/$VideoHoehe))-$PlayerHoehe)/2) & ",-" & Abs(($d-($PlayerHoehe/9)*16)/2) & ",-" & Abs((($d/($VideoBreite/$VideoHoehe))-$PlayerHoehe)/2) & ")" & @CRLF)
		FileWrite($Datei,'Verlauf = ImageReader("' & $BildLinks[1] & "\" & $BildLinks[2] & '")' & @CRLF)
		FileWrite($Datei,'Verlaufsmaske = ImageReader("' & $BildLinks[1] & "\" & $BildLinks[2] & '",pixel_type="RGB32").ShowAlpha(pixel_type="RGB32")')
		FileWrite($Datei,@CRLF & 'Klar = Video')
		If $VideoHoehe <> $PlayerHoehe Then
			FileWrite($Datei,".Lanczos4Resize(" & Round(($PlayerHoehe*($VideoBreite/$VideoHoehe)),0) & "," & $PlayerHoehe & ")")
		EndIf

		FileWrite($Datei,@CRLF)
		If $VideoBreite/$VideoHoehe < 16/9 Then
			FileWrite($Datei,"Fertig = Overlay(Verschwommen,Verlauf,mask=Verlaufsmaske,0,0,opacity=1).Overlay(Klar," & Round((((($PlayerHoehe/9)*16)-($PlayerHoehe*($VideoBreite/$VideoHoehe)))/2),0) & ",0)" & @CRLF)
		ElseIf $VideoBreite/$VideoHoehe > 16/9 Then
			FileWrite($Datei,"Fertig = Overlay(Verschwommen,Verlauf,mask=Verlaufsmaske,0,0,opacity=1).Overlay(Klar,0," & Round(((($PlayerHoehe)-(((($PlayerHoehe/9)*16)/($VideoBreite/$VideoHoehe))/($VideoBreite/$VideoHoehe)))/2),0) & ")" & @CRLF)
		EndIf
		schreibe("Hinten")
	EndIf

	MsgBox(0x40,"Fertig","Script wurde erfolgreich erstellt.")
	If $ShowScript = True Then
		ShellExecute("notepad.exe", $File)
	EndIf
	If $ShowMeGui = True Then
		If Not WinExists("MeGUI") Then
			ShellExecute(IniRead($Ini,"Allgemein","MeGUI",""))
		Else
			WinActivate("MeGUI")
		EndIf
		WinWaitActive("MeGUI")
		Send("^o")
		WinWaitActive("Select your input file")
		Send($Speicherort[1] & "\" & $Speicherort[2] & "{ENTER}")
		WinWait("Current position")
		WinWaitActive("MeGUI")
		If ControlCommand("MeGUI","","[NAME:tabControl1]","CurrentTab","") = 2 Then
			ControlCommand("MeGUI","","[NAME:tabControl1]","TabLeft", "")
		ElseIf ControlCommand("MeGUI","","[NAME:tabControl1]","CurrentTab","") = 3 Then
			ControlCommand("MeGUI","","[NAME:tabControl1]","TabLeft", "")
			ControlCommand("MeGUI","","[NAME:tabControl1]","TabLeft", "")
		EndIf
		If $QueueAudio = True Then
			WinWaitActive("MeGUI")
			ControlClick("MeGUI","Queue","[NAME:queueAudioButton]")
		EndIf
		WinWaitActive("MeGUI")
		ControlClick("MeGUI","Queue","[NAME:queueVideoButton]")
		Sleep(1000)
		While WinExists("Incorrect Colorspace")
			Sleep(100)
		WEnd
		Sleep(1000)
		While WinExists("","Successfully converted to YV12.")
			Sleep(100)
		WEnd
		WinWaitActive("MeGUI")
		ControlCommand("MeGUI","","[NAME:tabControl1]","TabRight", "")
		;ControlClick("MeGUI","Start","[NAME:startStopButton]")
	EndIf
EndFunc
Func schreibe($Ort)
	Switch $Ort
		Case "Vorne"
			_FileCreate($File)
			$Datei = FileOpen($File,2)
			Local $a = $a & '"' & $Dateien[1] & "\" & $Dateien[2] & '"'
			For $i = 3 To UBound($Dateien)-1
				$a = $a & ' "' & $Dateien[1] & "\" & $Dateien[$i] & '"'
			Next

			FileWrite($Datei,'Video = AVISource("')
			FileWrite($Datei,$Dateien[1] & "\" & $Dateien[2] & '"')
			For $i = 3 To UBound($Dateien)-1
				FileWrite($Datei,',"' & $Dateien[1] & "\" & $Dateien[$i] & '"')
			Next
			If $Audio = True Then
				FileWrite($Datei,", audio=False).AssumeFPS(" & $VideoFPS & ")")
				If $Resize = True Then
					Resize($Breite,$Hoehe)
				EndIf
				If $ChangeFPS = True Then
					FileWrite($Datei,".ChangeFPS(" & $RenderFPS & ")")
				EndIf
				If $Fraps = False Then
					If IniRead($Ini,"Allgemein","Splitter","") = "" Then
						If FileExists(@ProgramFilesDir & "\Dxtory Software\Dxtory2.0\AudioStreamSplitter.exe") = 1 Then
							IniWrite($Ini,"Allgemein","Splitter",@ProgramFilesDir & "\Dxtory Software\Dxtory2.0\AudioStreamSplitter.exe")
						Else
							MsgBox(0,"Vervollständigen","DxTory liegt nicht im Standardordner." & @CRLF & 'Bitte gib den Ort von "DxTory.exe" an')
							Local $b[3]
							While $b[1] <> ""
								$b = _WinAPI_GetOpenFileName("dxtory.exe","Ausführbare Dateien (*.exe)",$Standardordner,"AudioStreamSplitter.exe",".exe",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
							WEnd
							IniWrite($Ini,"Allgemein","Splitter",$b[1] & "\AudioStreamSplitter.exe")
						EndIf
					EndIf
					ShellExecuteWait(IniRead($Ini,"Allgemein","Splitter",""),$a)
				EndIf
			Else
				FileWrite($Datei,", audio=true).AssumeFPS(" & $VideoFPS & ")")
				If $Resize = True Then
					Resize($Breite,$Hoehe)
				EndIf
				If $ChangeFPS = True Then
					FileWrite($Datei,".ChangeFPS(" & $RenderFPS & ")")
				EndIf
			EndIf
		Case "Hinten"
			If $Audio = True Then
				If $Fraps = False Then
					For $i = 1 To $Ton[0][0]
						FileWrite($Datei,@CRLF & "Spur" & $i & ' = ')
						If $Ton[$i][3] = "" Then
							Local $a = 'WAVSource("' & $Dateien[1] & "\" & StringMid($Dateien[2],1,StringInStr($Dateien[2],".")-1) & " st" & $i-1 & '.wav"'
							For $i2 = 3 To UBound($Dateien)-1
								$a = $a & ',"' & $Dateien[1] & "\" & StringMid($Dateien[$i2],1,StringInStr($Dateien[$i2],".")-1) & " st" & $i-1 & '.wav"'
							Next
							$a = $a & ")"
						Else
							Local $a = 'WAVSource("' & $Ton[$i][3] & '")'
						EndIf
						If $Ton[$i][1] = "Mono" Then
							FileWrite($Datei,'MonoToStereo(' & $a & "," & $a & ")")
						Else
							FileWrite($Datei,$a)
						EndIf
					Next
				ElseIf $Fraps = True Then
					If $Ton[1][3] = "" Then
						Local $a = @CRLF & 'Spur1 = AVISource("' & $Dateien[1] & "\" & $Dateien[2] & '"'
						For $i2 = 3 To UBound($Dateien)-1
							$a = $a & ',"' & $Dateien[1] & "\" & $Dateien[$i2] & '"'
						Next
						$a = $a & ", audio = true)"
					Else
						Local $a = @CRLF & 'Spur1 = WAVSource("' & $Ton[1][3] & '")'
					EndIf
					If $Ton[1][1] = "Mono" Then
						FileWrite($Datei,'MonoToStereo(' & $a & "," & $a & ")")
					Else
						FileWrite($Datei,$a)
					EndIf
					For $i = 2 To $Ton[0][0]
						$a = 'WAVSource("' & $Ton[$i][3] & '")'
						If $Ton[$i][1] = "Mono" Then
							FileWrite($Datei,@CRLF & 'Spur' & $i & ' = MonoToStereo(' & $a & "," & $a & ")")
						Else
							FileWrite($Datei,@CRLF & 'Spur' & $i & ' =' & $a)
						EndIf
					Next
				EndIf
				FileWrite($Datei,@CRLF & "Gemischt = MixAudio(Spur1,Spur2," & $Ton[1][2] & "," & $Ton[2][2] & ")" & @CRLF)
				For $i = 3 To $Ton[0][0]
					FileWrite($Datei,"Gemischt = MixAudio(Gemischt,Spur" & $i & ",1," & $Ton[$i][2] & ")" & @CRLF)
				Next
			EndIf

			;FileWrite($Datei,"ConvertToYV12()" & @CRLF)
			If $Audio = False And $Randverlauf = False Then
				FileWrite($Datei,@CRLF & "Video" & @CRLF)
			ElseIf $Randverlauf = True And $Audio = False Then
				FileWrite($Datei,@CRLF & "Fertig" & @CRLF)
			ElseIf $Randverlauf = True And $Audio = True Then
				FileWrite($Datei,@CRLF & "AudioDub(Fertig,Gemischt)" & @CRLF)
			Else
				FileWrite($Datei,@CRLF & "AudioDub(Video,Gemischt)" & @CRLF)
			EndIf
			FileClose($Datei)
	EndSwitch
EndFunc

#region ;Allgemein
Func showsplash()
	$destination = @WorkingDir & "\Splash.jpg"
	FileInstall("A:\Daten\Avisynth Scriptgenerator\Splash.jpg", $destination)  ;source must be literal string
	SplashImageOn("Splash Screen",$destination,910,117,-1,-1,3)
	checkUpdate()
	SplashOff()
	FileDelete($destination)
EndFunc

Func Update($version)
	TrayTip("Update","Führe Update aus.",10,1)
	InetGet("http://killerinstinct.ath.cx:2000/AVSgenerator/AviSynth%20Scriptgenerator%20-%20v" & $version & ".exe",@ScriptDir & "\AviSynth Scriptgenerator - v" & $version & ".exe")
	FileDelete(@DesktopDir & "\AviSynth Scriptgenerator - v" & $aktuelleVersion & ".exe.lnk")
	Exit ShellExecute(@ScriptDir & "\AviSynth Scriptgenerator - v" & $version & ".exe",' loescheAlt "' & @ScriptDir & "\" & @ScriptName & '"')
EndFunc

Func checkUpdate()
	If $CmdLine[0] > 0 And $CmdLine[1] = "loescheAlt" Then
		FileDelete($CmdLine[2])
		FileCreateShortcut(@ScriptDir & "\" & @ScriptName,@DesktopDir & "\" & @ScriptName,@ScriptDir)
		TrayTip("Update","Update erfolgreich ausgeführt",10)
		If MsgBox(0x24,"Update abgeschlossen","Möchtest du dir die Versionsänderungen ansehen?") = 6 Then
			ShellExecute("http://www.letsplayforum.de/index.php?page=Thread&threadID=39887")
		EndIf
	Else
		TrayTip("Update","Suche nach Updates.",30,1)
	EndIf
	Local $neueVersion = BinaryToString(InetRead("http://killerinstinct.ath.cx:2000/AVSgenerator/Aktuelle%20Version.txt",1))
	If $neueVersion <> $aktuelleVersion Then
		If MsgBox(0x24,"Update verfügbar","Ein Update ist verfügbar." & @CRLF & "Möchtest du das Update jetzt ausführen?") = 6 Then
			Update($neueVersion)
		EndIf
	EndIf
	TrayTip("Update","Keine Updates gefunden.",3,1)
EndFunc

Func beenden()

EndFunc
#endregion
