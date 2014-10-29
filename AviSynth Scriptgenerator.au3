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

#RequireAdmin

#region ;Dim
dim $Resize = False
dim $ChangeFPS = False
dim $Speicherort
dim $Dateien
dim $VideoFPS
dim $RenderFPS
dim $geaendert = False
dim $Randverlauf = False
dim $Randbild = False
dim $erweitert = False
dim $Muxen = False
dim $Schneiden = False
dim $BildLinks[3]
dim $BildRechts[3]
dim $Speicherort[3]
dim $MKVMerge
dim $Ordner
dim $MGUI
dim $PlayerHoehe
dim $Breite
dim $Hoehe
dim $VideoBreite
dim $VideoHoehe
dim $Datei
dim $File
dim $Fraps = False
dim $aktuelleVersion = 3.77
dim $ShowMeGui = False
dim $ShowScript = False
dim $Fehler[1]
dim $Audio = False
dim $QueueAudio = False
dim $Verhealtnis
dim $Ton[9][4]
If FileExists(@ScriptDir & "\Options.ini") = 1 Then
	$Ini = @ScriptDir & "\Options.ini"
Else
	$Ini = ""
EndIf
dim $Standardordner = IniRead($Ini,"Allgemein","Standardordner",@WorkingDir)
If IniRead($Ini,"Merke","MerkeSpuren","False") = "True" Then
	$Ton[0][0] = IniRead($Ini,"Ton","Ton[0][0]","2")
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
Else
	$Ton[0][0] = "2"
	$Ton[1][1] = "Stereo"
	$Ton[2][1] = "Mono"
	$Ton[3][1] = "Stereo"
	$Ton[4][1] = "Stereo"
	$Ton[5][1] = "Stereo"
	$Ton[6][1] = "Stereo"
	$Ton[7][1] = "Stereo"
	$Ton[8][1] = "Stereo"
	$Ton[1][2] = "1"
	$Ton[2][2] = "1"
	$Ton[3][2] = "1"
	$Ton[4][2] = "1"
	$Ton[5][2] = "1"
	$Ton[6][2] = "1"
	$Ton[7][2] = "1"
	$Ton[8][2] = "1"
EndIf
#endregion

showsplash()

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("AviSynth Scriptgenerator", 610,273)
$Button3 = GUICtrlCreateButton("Script erzeugen", 24, 112, 281, 25)
$Button4 = GUICtrlCreateButton("Beenden", 312, 112, 281, 25)
$CheckRadio1 = GUICtrlCreateCheckbox("Randbilder", 16, 152, 73, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$CheckRadio2 = GUICtrlCreateCheckbox("Randverlauf", 16, 168, 81, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$Group1 = GUICtrlCreateGroup("Einfach", 8, 8, 585, 97)
$Input1 = GUICtrlCreateInput("", 104, 56, 369, 21,$ES_READONLY)
$Button1 = GUICtrlCreateButton("...", 552, 56, 33, 25)
$Input2 = GUICtrlCreateInput("", 496, 56, 49, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSendMsg($Input2, 0x1501, 0, "FPS")
$Label1 = GUICtrlCreateLabel("@", 480, 56, 15, 17)
$Checkbox1 = GUICtrlCreateCheckbox("Größe ändern", 16, 80, 81, 17)
$Input3 = GUICtrlCreateInput("", 104, 80, 97, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSendMsg($Input3, 0x1501, 0, "Breite")
$Input4 = GUICtrlCreateInput("", 224, 80, 81, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSendMsg($Input4, 0x1501, 0, "Höhe")
$Label2 = GUICtrlCreateLabel("x", 208, 80, 9, 17)
$Label3 = GUICtrlCreateLabel("@", 312, 80, 15, 17)
$Input5 = GUICtrlCreateInput("", 328, 80, 57, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
$Checkbox2 = GUICtrlCreateCheckbox("Framerate ändern", 392, 80, 105, 17)
$Input6 = GUICtrlCreateInput("", 136, 24, 409, 21,$ES_READONLY)
$Button2 = GUICtrlCreateButton("...", 552, 24, 33, 25)
$Label4 = GUICtrlCreateLabel("Speicherort und -name:", 16, 24, 114, 17)
$Label5 = GUICtrlCreateLabel("Videodateien:", 16, 56, 69, 17)
GUICtrlSendMsg($Input5, 0x1501, 0, "FPS")
$Checkbox3 = GUICtrlCreateCheckbox("Erweitert", 504, 80, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Erweitert", 8, 136, 585, 67)
GUICtrlSetState(-1, $GUI_HIDE)
$Input7 = GUICtrlCreateInput("", 104, 152, 81, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSendMsg($Input7, 0x1501, 0, "Endhöhe in px")
GUICtrlSetState(-1, $GUI_HIDE)
$Input8 = GUICtrlCreateInput("", 192, 152, 137, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY))
GUICtrlSetState(-1, $GUI_HIDE)
$Input9 = GUICtrlCreateInput("", 376, 152, 169, 21, BitOR($ES_AUTOHSCROLL,$ES_READONLY))
GUICtrlSetState(-1, $GUI_HIDE)
$Button5 = GUICtrlCreateButton("...", 336, 153, 33, 25, 0)
GUICtrlSetState(-1, $GUI_HIDE)
$Button6 = GUICtrlCreateButton("...", 554, 153, 33, 25, 0)
GUICtrlSetState(-1, $GUI_HIDE)
$Checkbox6 = GUICtrlCreateCheckbox("Audiospuren mischen", 336, 184, 121, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$Button8 = GUICtrlCreateButton("Tonspuren einstellen", 464, 176, 121, 25)
GUICtrlSetState(-1, $GUI_HIDE)
$Input10 = GUICtrlCreateInput("", 104, 176, 105, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSendMsg($Input10, 0x1501, 0, "Aktuelle Videobreite")
GUICtrlSetState(-1, $GUI_HIDE)
$Input11 = GUICtrlCreateInput("", 232, 176, 97, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSendMsg($Input11, 0x1501, 0, "Aktuelle Videohöhe")
$Label6 = GUICtrlCreateLabel("x", 216, 176, 9, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$Checkbox5 = GUICtrlCreateCheckbox("Muxen", 16, 184, 57, 17)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Muxen", 8, 200, 585, 49)
GUICtrlSetState(-1, $GUI_HIDE)
$Button7 = GUICtrlCreateButton("Muxen starten", 280, 216, 305, 25, 0)
GUICtrlSetState(-1, $GUI_HIDE)
$Input12 = GUICtrlCreateInput("", 64, 216, 113, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL,$ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSendMsg($Input12, 0x1501, 0, "x")
$Checkbox4 = GUICtrlCreateCheckbox("Nach", 16, 216, 49, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$Label7 = GUICtrlCreateLabel("Minuten splitten", 184, 216, 94, 17)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$MenuItem1 = GUICtrlCreateMenu("Datei")
If IniRead($Ini,"Allgemein","Installiert","False") = "True" Then
	$MenuItem5 = GUICtrlCreateMenuItem("Programm deinstallieren", $MenuItem1)
Else
	$MenuItem5 = GUICtrlCreateMenuItem("Programm installieren", $MenuItem1)
EndIf
$MenuItem6 = GUICtrlCreateMenuItem("Optionen", $MenuItem1)
$MenuItem2 = GUICtrlCreateMenu("?")
$MenuItem3 = GUICtrlCreateMenuItem("Hilfe", $MenuItem2)
$MenuItem4 = GUICtrlCreateMenuItem("Info", $MenuItem2)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

#Region ### START Koda GUI section ### Form=
$Form3 = GUICreate("Optionen", 491, 180,-1,-1,-1,-1,$Form1)
$Group4 = GUICtrlCreateGroup("Einstellungen merken", 8, 8, 121, 168)
$Checkbox7 = GUICtrlCreateCheckbox("Auflösung ändern", 16, 24, 105, 17)
$Checkbox8 = GUICtrlCreateCheckbox("AssumeFPS", 16, 40, 73, 17)
$Checkbox9 = GUICtrlCreateCheckbox("ChangeFPS", 16, 56, 73, 17)
$Checkbox10 = GUICtrlCreateCheckbox("PlayerHöhe", 16, 72, 73, 17)
$Checkbox11 = GUICtrlCreateCheckbox("Splitzeit", 16, 88, 73, 17)
$Checkbox12 = GUICtrlCreateCheckbox("4:3 Auflösung", 16, 104, 81, 17)
$Checkbox13 = GUICtrlCreateCheckbox("Fraps", 16, 120, 89, 17)
$Checkbox14 = GUICtrlCreateCheckbox("Script ansehen", 16, 136, 97, 17)
$Checkbox16 = GUICtrlCreateCheckbox("Spuren",16,152)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("MeGUI", 136, 8, 345, 65)
$Input13 = GUICtrlCreateInput("", 144, 24, 289, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$Button11 = GUICtrlCreateButton("...", 440, 24, 33, 25)
$Checkbox15 = GUICtrlCreateCheckbox("MeGUI nach Scripterstellung starten", 144, 48, 193, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Checkbox17 = GUICtrlCreateCheckbox("Queue Audio", 337, 48)
$Group6 = GUICtrlCreateGroup("Standardordner", 136, 72, 345, 49)
$Input14 = GUICtrlCreateInput("", 144, 88, 289, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$Button12 = GUICtrlCreateButton("...", 440, 87, 33, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button13 = GUICtrlCreateButton("Fertig", 136, 128, 345, 25)
#EndRegion ### END Koda GUI section ###

#Region ### START Koda GUI section ### Form=
$Form2 = GUICreate("Tonspuren", 260, 170,-1,-1,-1,-1,$Form1)
$Slider1 = GUICtrlCreateSlider(0, 0, 260, 33)
GUICtrlSetLimit(-1, 6, 0)
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

gemerkt()

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $Form1
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE, $Button4
					GUIDelete($Form1)
					GUIDelete($Form2)
					GUIDelete($Form3)
					Exit
				Case $MenuItem5
					If IniRead($Ini,"Allgemein","Installiert","False") = "False" Then
						Local $a = _WinAPI_GetSaveFileName("Installationsort","Ausführbare Dateien (*.exe)",@ProgramFilesDir,"AviSynth Scriptgenerator - v" & $aktuelleVersion & ".exe",".exe",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
						If $a[1] <> "AviSynth Scriptgenerator - v" & $aktuelleVersion & ".exe" Then
							Installiere($a)
						EndIf
					Else
						Deinstalliere()
					EndIf
				Case $MenuItem6
					If $Ini <> "" Then
						GUISetState(@SW_SHOW,$Form3)
						GUISetState(@SW_DISABLE,$Form1)
						WinActivate("Optionen")
					Else
						MsgBox(0x40,"Fehler","Das Programm muss installiert sein, um die Optionen zu bearbeiten.")
					EndIf
				Case $MenuItem4
					MsgBox(0x40,"Info","Der AviSynth Scriptgenerator liegt in der Version " & $aktuelleVersion & " vor." & @CRLF & "Erstellt von Lucki")
				Case $MenuItem3
					ShellExecute("http://www.letsplayforum.de/index.php?page=Thread&threadID=39887")
				Case $Checkbox1
					If GUICtrlRead($Checkbox1) = 1 Then
						GUICtrlSetState($Input3, $GUI_ENABLE)
						GUICtrlSetState($Input4, $GUI_ENABLE)
						IniWrite($Ini,"Merke","Resize","True")
						$Resize = True
					ElseIf GUICtrlRead($Checkbox1) = 4 Then
						GUICtrlSetState($Input3, $GUI_DISABLE)
						GUICtrlSetState($Input4, $GUI_DISABLE)
						IniWrite($Ini,"Merke","Resize","False")
						$Resize = False
					EndIf
				Case $Checkbox2
					If GUICtrlRead($Checkbox2) = 1 Then
						IniWrite($Ini,"Merke","ChangeFPS","True")
						$ChangeFPS = True
						GUICtrlSetState($Input5, $GUI_ENABLE)
					ElseIf GUICtrlRead($Checkbox2) = 4 Then
						IniWrite($Ini,"Merke","ChangeFPS","False")
						GUICtrlSetState($Input5, $GUI_DISABLE)
						$ChangeFPS = False
					EndIf
				Case $Checkbox3
					If GUICtrlRead($Checkbox3) = 1 Then
						showErweitert()
					ElseIf GUICtrlRead($Checkbox3) = 4 Then
						resetErweitert()
					EndIf
				Case $Checkbox5
					If GUICtrlRead($Checkbox5) = 1 Then
						showMuxen()
					ElseIf GUICtrlRead($Checkbox5) = 4 Then
						resetMuxen()
					EndIf
				Case $Checkbox4
					If GUICtrlRead($Checkbox4) = 1 Then
						GUICtrlSetState($Input12, $GUI_ENABLE)
						IniWrite($Ini,"Merke","Split","True")
						$Schneiden = True
					ElseIf GUICtrlRead($Checkbox4) = 4 Then
						$Schneiden = False
						IniWrite($Ini,"Merke","Split","False")
						GUICtrlSetState($Input12, $GUI_DISABLE)
					EndIf
				Case $Checkbox6
					If GUICtrlRead($Checkbox6) = 1 Then
						If $Ini = "" Then
							MsgBox(0x40,"Fehler","Für diese Option muss das Programm installiert sein.")
							GUICtrlSetState($Checkbox6,$GUI_UNCHECKED)
						Else
							GUICtrlSetState($Button8, $GUI_SHOW)
							IniWrite($Ini,"Merke","Audio","True")
							$Audio = True
						EndIf
					ElseIf GUICtrlRead($Checkbox6) = 4 Then
						$Audio = False
						IniWrite($Ini,"Merke","Audio","False")
						GUICtrlSetState($Button8, $GUI_HIDE)
					EndIf
				Case $Button8
					GUISetState(@SW_SHOW,$Form2)
					GUISetState(@SW_DISABLE,$Form1)
					WinActivate("Tonspuren")
				Case $CheckRadio1
					If GUICtrlRead($CheckRadio1) = 1 Then
						showRandbild()
					ElseIf GUICtrlRead($CheckRadio1) = 4 Then
						resetRandbild()
					EndIf
				Case $CheckRadio2
					If GUICtrlRead($CheckRadio2) = 1 Then
						showRandverlauf()
					ElseIf GUICtrlRead($CheckRadio2) = 4 Then
						resetRandverlauf()
					EndIf
				Case $Button5
					If $Randbild = True Then
						$d = "Bild Links"
					ElseIf $Randverlauf = True Then
						$d = "Verlauf"
					EndIf
					$BildLinks = _WinAPI_GetOpenFileName($d,"Bilddateien (*.png;*.jpg;*.jpeg;*.bmp)",$Standardordner,"",".png",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
					If $BildLinks[1] = "" Then
						GUICtrlSetData($Input8,"")
					Else
						GUICtrlSetData($Input8,$BildLinks[1] & "\" & $BildLinks[2])
						IniWrite($Ini,"Allgemein","BildLinks",$BildLinks[1] & "\" & $BildLinks[2])
					EndIf
				Case $Button6
					$BildRechts = _WinAPI_GetOpenFileName("Bild Rechts","Bilddateien (*.png;*.jpg;*.jpeg;*.bmp)",$Standardordner,"",".png",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
					If	$BildRechts[1] = "" Then
						GUICtrlSetData($Input9,"")
					Else
						GUICtrlSetData($Input9,$BildRechts[1] & "\" & $BildRechts[2])
						IniWrite($Ini,"Allgemein","BildRechts",$BildRechts[1] & "\" & $BildRechts[2])
					EndIf
				Case $Button1
					$Dateien = _WinAPI_GetOpenFileName("Videodateien","Videos (*.avi)",$Standardordner,"",".avi",0,BitOR($OFN_ALLOWMULTISELECT, $OFN_HIDEREADONLY, $OFN_EXPLORER))
					If $Dateien[1] = "" Then
						GUICtrlSetData($Input1,"")
					Else
						_ArraySort($Dateien,0,2)
						$Anzeige = $Dateien[1]
						For $i = 2 To UBound($Dateien)-1
							$Anzeige = $Anzeige & "|" & $Dateien[$i]
						Next
						GUICtrlSetData($Input1,$Anzeige)
					EndIf
				Case $Button2
					If $Muxen = False Then
						$Speicherort = _WinAPI_GetSaveFileName("Speicherort","AviSynth Scriptdateien (*.avs)",$Standardordner,"Mein erstes Avisynthscript.avs",".avs",0,BitOR($OFN_OVERWRITEPROMPT, $OFN_HIDEREADONLY, $OFN_EXPLORER))
					Else
						$Speicherort = _WinAPI_GetOpenFileName("Script öffnen","AviSynth Scriptdateien (*.avs)",$Standardordner,"Mein erstes Avisynthscript.avs",".avs",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
					EndIf
					If $Speicherort[1] = "Mein erstes Avisynthscript.avs" Then
						GUICtrlSetData($Input6,"")
					Else
						GUICtrlSetData($Input6,$Speicherort[1] & "\" & $Speicherort[2])
						$geaendert = False
					EndIf
				Case $Button3
					Switch $Muxen
						Case False
							checkInput1()
							checkSpeicherort()
							If $Resize = True And checkInput($Input3) = True And checkInput($Input4) = True Then
								$Breite = GUICtrlRead($Input3)
								$Hoehe = GUICtrlRead($Input4)
								If Mod(GUICtrlRead($Hoehe),2) <> 0 Then
									_ArrayAdd($Fehler,"Die Höhe muss glatt durch 2 teilbar sein.")
								EndIf
								If Mod(GUICtrlRead($Breite),2) <> 0 Then
									_ArrayAdd($Fehler,"Die Breite muss glatt durch 2 teilbar sein.")
								EndIf
								If IniRead($Ini,"Merke","MerkeAuflösung","False") = "True" Then
									IniWrite($Ini,"Merke","Breite",$Breite)
									IniWrite($Ini,"Merke","Höhe",$Hoehe)
								EndIf
							ElseIf $Resize = True Then
								_ArrayAdd($Fehler,"Bitte trage eine korrekte Zahl für die Auflösung ein.")
							EndIf
							If $ChangeFPS = True And checkInput($Input5) = True Then
								$RenderFPS = GUICtrlRead($Input5)
								If IniRead($Ini,"Merke","MerkeChangeFPS","False") = "True" Then
									IniWrite($Ini,"Merke","RenderFPS",$RenderFPS)
								EndIf
							ElseIf $ChangeFPS = True Then
								_ArrayAdd($Fehler,"Bitte trage eine Zahl für die gewünschte Framerate ein.")
							EndIf
							If checkInput($Input2) = False Then
								_ArrayAdd($Fehler,"Bitte trage eine Zahl für die vorhandene Framerate ein.")
							Else
								$VideoFPS = GUICtrlRead($Input2)
								If IniRead($Ini,"Merke","MerkeAssumeFPS","False") = "True" Then
									IniWrite($Ini,"Merke","VideoFPS",$VideoFPS)
								EndIf
							EndIf
							If $erweitert = True Then
								If $Randbild = True Or $Randverlauf = True Then
									If checkInput($Input10) = True And checkInput($Input11) = True Then
										$VideoBreite = GUICtrlRead($Input10)
										$VideoHoehe = GUICtrlRead($Input11)
										If IniRead($Ini,"Merke","MerkeAuflösung2","False") = "True" Then
											IniWrite($Ini,"Merke","VideoBreite",$VideoBreite)
											IniWrite($Ini,"Merke","VideoHöhe",$VideoHoehe)
										EndIf
									Else
										_ArrayAdd($Fehler,"Bitte trage eine korrekte Zahl für die Auflösung ein.")
									EndIf
									If checkInput($Input7) = True Then
										$PlayerHoehe = GUICtrlRead($Input7)
										If Mod($PlayerHoehe,9) <> 0 Then
											_ArrayAdd($Fehler,"Bitte trage eine glatt durch 9 teilbare Zahl für die gewünschte Höhe ein.")
										EndIf
										If IniRead($Ini,"Merke","MerkePlayerhöhe","False") = "True" Then
											IniWrite($Ini,"Merke","PlayerHöhe",$PlayerHoehe)
										EndIf
									Else
										_ArrayAdd($Fehler,"Bitte trage eine korrekte Zahl für die gewünschte Höhe ein.")
									EndIf
								EndIf
								If $Randbild = True Then
									checkBilder()
								ElseIf $Randverlauf = True Then
									checkVerlauf()
								EndIf
							EndIf
						Case True
							_ArrayAdd($Fehler,"Es kann kein Script erzeugt werden, wenn Muxen eingeschaltet ist.")
					EndSwitch

					$Fehler[0] = UBound($Fehler)-1

					If $Fehler[0] = 0 And $geaendert = False Then
						Fertigstellen()
					ElseIf  $Fehler[0] = 0 And $geaendert = True Then
						If MsgBox(0x24,"Änderung","Der Speicherort wurde nicht geändert." & @CRLF & "Fortfahren?")<>7 Then
							Fertigstellen()
						EndIf
					ElseIf $Fehler[0] = 1 Then
						Local $FehlerText = $Fehler[1] & @CRLF & @CRLF & "Es trat " & $Fehler[0] & " Fehler auf."
						MsgBox(0x30,"Fehler",$FehlerText)
					Else
						Local $FehlerText = _ArrayToString($Fehler, @CRLF , 1)
						$FehlerText = $FehlerText & @CRLF & @CRLF & "Es traten " & $Fehler[0] & " Fehler auf."
						MsgBox(0x30,"Fehler",$FehlerText)
					EndIf

					ReDim $Fehler[1]
				Case $Button7
					checkSpeicherort()
					If $Schneiden = True And checkInput($Input12) = True And GUICtrlRead($Input12) < 60 Then
						$Splitduration = GUICtrlRead($Input12)
						If IniRead($Ini,"Merke","MerkeSplitzeit","False") = "True" Then
							IniWrite($Ini,"Merke","Splitzeit",$Splitduration)
						EndIf
					ElseIf $Schneiden = True Then
						_ArrayAdd($Fehler,"Bitte trage eine korrekte Länge kleiner 60 ein.")
					EndIf

					$DateiMKV = $Speicherort[1] & "\" & StringMid($Speicherort[2],1,StringInStr($Speicherort[2],".",0)) & "mkv"
					$DateiOGG = $Speicherort[1] & "\" & StringMid($Speicherort[2],1,StringInStr($Speicherort[2],".",0)) & "ogg"
					$DateiFLAC = $Speicherort[1] & "\" & StringMid($Speicherort[2],1,StringInStr($Speicherort[2],".",0)) & "flac"

					checkFiles()
					checkMKVMerge()
					$Fehler[0] = UBound($Fehler)-1

					If $Fehler[0] = 0 Then
						Muxen($MKVMerge)
					ElseIf $Fehler[0] = 1 Then
						Local $FehlerText = $Fehler[1] & @CRLF & @CRLF & "Es trat " & $Fehler[0] & " Fehler auf."
						MsgBox(0x30,"Fehler",$FehlerText)
					Else
						Local $FehlerText = _ArrayToString($Fehler, @CRLF , 1)
						$FehlerText = $FehlerText & @CRLF & "Es traten " & $Fehler[0] & " Fehler auf."
						MsgBox(0x30,"Fehler",$FehlerText)
					EndIf

					ReDim $Fehler[1]
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
					IniWrite($Ini,"Merke","AnzahlSpuren",$Spuren)
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
					If IniRead($Ini,"Merke","MerkeSpuren","False") = "True" Then
						IniWrite($Ini,"Ton","Ton[" & $Spur & "][1]",GUICtrlRead($Combo1))
					EndIf
				Case $Combo2
					$Spur = StringMid(GUICtrlRead($List1),6)
					$Ton[$Spur][2] = GUICtrlRead($Combo2)
					If IniRead($Ini,"Merke","MerkeSpuren","False") = "True" Then
						IniWrite($Ini,"Ton","Ton[" & $Spur & "][2]",GUICtrlRead($Combo2))
					EndIf
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
		Case $Form3
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUISetState(@SW_HIDE,$Form3)
					GUISetState(@SW_ENABLE, $Form1)
					WinActivate("AviSynth Scriptgenerator")
				Case $Checkbox7
					If GUICtrlRead($Checkbox7) = 1 Then
						IniWrite($Ini,"Merke","MerkeAuflösung","True")
					ElseIf GUICtrlRead($Checkbox7) = 4 Then
						IniWrite($Ini,"Merke","MerkeAuflösung","False")
					EndIf
				Case $Checkbox8
					If GUICtrlRead($Checkbox8) = 1 Then
						IniWrite($Ini,"Merke","MerkeAssumeFPS","True")
					ElseIf GUICtrlRead($Checkbox8) = 4 Then
						IniWrite($Ini,"Merke","MerkeAssumeFPS","False")
					EndIf
				Case $Checkbox9
					If GUICtrlRead($Checkbox9) = 1 Then
						IniWrite($Ini,"Merke","MerkeChangeFPS","True")
					ElseIf GUICtrlRead($Checkbox9) = 4 Then
						IniWrite($Ini,"Merke","MerkeChangeFPS","False")
					EndIf
				Case $Checkbox10
					If GUICtrlRead($Checkbox10) = 1 Then
						IniWrite($Ini,"Merke","MerkePlayerhöhe","True")
					ElseIf GUICtrlRead($Checkbox10) = 4 Then
						IniWrite($Ini,"Merke","MerkePlayerhöhe","False")
					EndIf
				Case $Checkbox11
					If GUICtrlRead($Checkbox11) = 1 Then
						IniWrite($Ini,"Merke","MerkeSplitzeit","True")
					ElseIf GUICtrlRead($Checkbox11) = 4 Then
						IniWrite($Ini,"Merke","MerkeSplitzeit","False")
					EndIf
				Case $Checkbox12
					If GUICtrlRead($Checkbox12) = 1 Then
						IniWrite($Ini,"Merke","MerkeAuflösung2","True")
					ElseIf GUICtrlRead($Checkbox12) = 4 Then
						IniWrite($Ini,"Merke","MerkeAuflösung2","False")
					EndIf
				Case $Checkbox13
					If GUICtrlRead($Checkbox13) = 1 Then
						IniWrite($Ini,"Merke","Fraps","True")
						$Fraps = True
					ElseIf GUICtrlRead($Checkbox13) = 4 Then
						IniWrite($Ini,"Merke","Fraps","False")
						$Fraps = False
					EndIf
				Case $Checkbox14
					If GUICtrlRead($Checkbox14) = 1 Then
						IniWrite($Ini,"Merke","Script","True")
						$ShowScript = True
					ElseIf GUICtrlRead($Checkbox14) = 4 Then
						IniWrite($Ini,"Merke","Script","False")
						$ShowScript = False
					EndIf
				Case $Checkbox15
					If GUICtrlRead($Checkbox15) = 1 Then
						If IniRead($Ini,"Allgemein","MeGUI","") <> "" Then
							IniWrite($Ini,"Merke","MeGuiStarten","True")
							$ShowMeGui = True
						Else
							MsgBox(0x40,"Fehler","Für diese Option muss dar richtige Pfad angegeben sein.")
							GUICtrlSetState($Checkbox15,$GUI_UNCHECKED)
						EndIf
					ElseIf GUICtrlRead($Checkbox15) = 4 Then
						IniWrite($Ini,"Merke","MeGuiStarten","False")
						$ShowMeGui = False
					EndIf
				Case $Checkbox16
					If GUICtrlRead($Checkbox16) = 1 Then
						IniWrite($Ini,"Merke","MerkeSpuren","True")
					ElseIf GUICtrlRead($Checkbox16) = 4 Then
						IniWrite($Ini,"Merke","MerkeSpuren","False")
					EndIf
				Case $Checkbox17
					If GUICtrlRead($Checkbox17) = 1 Then
						IniWrite($Ini,"Merke","QueueAudio","True")
						$QueueAudio = True
					ElseIf GUICtrlRead($Checkbox17) = 4 Then
						IniWrite($Ini,"Merke","QueueAudio","False")
						$QueueAudio = False
					EndIf
				Case $Button13
					If GUICtrlRead($Input14) <> "" Then
						IniWrite($Ini,"Allgemein","Standardordner",GUICtrlRead($Input14))
					EndIf
					If GUICtrlRead($Input13) <> "" Then
						IniWrite($Ini,"Allgemein","MeGUI",GUICtrlRead($Input13))
					EndIf
					GUISetState(@SW_HIDE,$Form3)
					GUISetState(@SW_ENABLE, $Form1)
					WinActivate("AviSynth Scriptgenerator")
				Case $Button12
					$Ordner = FileSelectFolder("Standardordner","")
					If	$Ordner = "" Then
						GUICtrlSetData($Input14,"")
					Else
						GUICtrlSetData($Input14,$Ordner)
					EndIf
				Case $Button11
					$MGUI = _WinAPI_GetOpenFileName("MeGUI","Ausführbare Dateien (*.exe)",$Standardordner,"MeGUI.exe",".exe",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
					If	$MGUI[1] = "" Or $MGUI[1] = "MeGUI.exe" Then
						GUICtrlSetData($Input13,"")
					Else
						GUICtrlSetData($Input13,$MGUI[1] & "\" & $MGUI[2])
					EndIf
			EndSwitch
	EndSwitch
WEnd
Func gemerkt()
	$BildLinks[1] = StringMid(IniRead($Ini,"Allgemein","BildLinks",""),1,StringInStr(IniRead($Ini,"Allgemein","BildLinks",""),"\",0,-1)-1)
	$BildLinks[2] = StringMid(IniRead($Ini,"Allgemein","BildLinks",""),StringInStr(IniRead($Ini,"Allgemein","BildLinks",""),"\",0,-1)+1)
	$BildRechts[1] = StringMid(IniRead($Ini,"Allgemein","BildRechts",""),1,StringInStr(IniRead($Ini,"Allgemein","BildRechts",""),"\",0,-1)-1)
	$BildRechts[2] = StringMid(IniRead($Ini,"Allgemein","BildRechts",""),StringInStr(IniRead($Ini,"Allgemein","BildRechts",""),"\",0,-1)+1)
	GUICtrlSetData($Input9,$BildRechts[1] & "\" & $BildRechts[2])
	GUICtrlSetData($Input8,$BildLinks[1] & "\" & $BildLinks[2])
	If IniRead($Ini,"Merke","MerkeAuflösung","False") = "True" Then
		If IniRead($Ini,"Merke","Resize","False") = "True" Then
			$Resize = True
			GUICtrlSetState($Checkbox1,$GUI_CHECKED)
			GUICtrlSetState($Input3,$GUI_ENABLE)
			GUICtrlSetState($Input4,$GUI_ENABLE)
		EndIf
		GUICtrlSetState($Checkbox7,$GUI_CHECKED)
		GUICtrlSetData($Input3,IniRead($Ini,"Merke","Breite",""))
		GUICtrlSetData($Input4,IniRead($Ini,"Merke","Höhe",""))
	EndIf
	If IniRead($Ini,"Merke","MerkeAssumeFPS","False") = "True" Then
		GUICtrlSetData($Input2,IniRead($Ini,"Merke","VideoFPS",""))
		GUICtrlSetState($Checkbox8,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","QueueAudio","False") = "True" Then
		$QueueAudio = True
		GUICtrlSetState($Checkbox17,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","MerkeChangeFPS","False") = "True" Then
		If IniRead($Ini,"Merke","ChangeFPS","False") = "True" Then
			GUICtrlSetState($Checkbox2,$GUI_CHECKED)
			GUICtrlSetState($Input5,$GUI_ENABLE)
			$ChangeFPS = True
		EndIf
		GUICtrlSetData($Input5,IniRead($Ini,"Merke","RenderFPS",""))
		GUICtrlSetState($Checkbox9,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","MerkePlayerhöhe","False") = "True" Then
		GUICtrlSetData($Input7,IniRead($Ini,"Merke","PlayerHöhe",""))
		GUICtrlSetState($Checkbox10,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","Fraps","False") = "True" Then
		$Fraps = True
		GUICtrlSetState($Checkbox13,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","MerkeAuflösung2","False") = "True" Then
		GUICtrlSetData($Input10,IniRead($Ini,"Merke","VideoBreite",""))
		GUICtrlSetData($Input11,IniRead($Ini,"Merke","VideoHöhe",""))
		GUICtrlSetState($Checkbox12,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","MerkeSplitzeit","False") = "True" Then
		If IniRead($Ini,"Merke","Split","False") = "True" Then
			GUICtrlSetState($Checkbox9,$GUI_CHECKED)
			GUICtrlSetState($Input12,$GUI_ENABLE)
			$Schneiden = True
		EndIf
		GUICtrlSetData($Input12,IniRead($Ini,"Merke","Splitzeit",""))
		GUICtrlSetState($Checkbox11,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","Script","False") = "True" Then
		$ShowScript = True
		GUICtrlSetState($Checkbox14,$GUI_CHECKED)
	EndIf
	If IniRead($Ini,"Merke","MeGuiStarten","False") = "True" Then
		$ShowMeGui = True
		GUICtrlSetState($Checkbox15,$GUI_CHECKED)
	EndIf
	GUICtrlSetData($Input14,IniRead($Ini,"Allgemein","Standardordner",""))
	GUICtrlSetData($Input13,IniRead($Ini,"Allgemein","MeGUI",""))
	If IniRead($Ini,"Merke","MerkeSpuren","False") = "True" Then
		GUICtrlSetData($Slider1,IniRead($Ini,"Merke","AnzahlSpuren","0"))
		anzahlaendern(IniRead($Ini,"Merke","AnzahlSpuren","0"))
		GUICtrlSetState($Checkbox16,$GUI_CHECKED)
		If IniRead($Ini,"Merke","Audio","False") = "True" Then
			GUICtrlSetState($Checkbox6,$GUI_CHECKED)
			$Audio = True
		EndIf
	EndIf
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
Func Installiere($a)
	TrayTip("Installieren","Führe Installation aus.",10,1)
	$version = BinaryToString(InetRead("https://dl.dropboxusercontent.com/u/75233120/AviSynth/Aktuelle%20Version.txt"))
	If $version <> $aktuelleVersion Then
		InetGet("https://dl.dropboxusercontent.com/u/75233120/AviSynth/AviSynth%20Scriptgenerator%20-%20v" & $version & ".exe",$a[1] & "\" & $a[2])
	Else
		FileCopy(@ScriptDir & "\" & @ScriptName,$a[1] & "\" & $a[2])
	EndIf
	_FileCreate($a[1] & "\Options.ini")
	$Ini = $a[1] & "\Options.ini"
	IniWriteSection($Ini,"Allgemein","Installiert=True" & @LF & "Installationspfad=" & $a[1] & "\" & $a[2])
	Exit ShellExecute($a[1] & "\" & $a[2],' loescheAlt "' & @ScriptDir & "\" & @ScriptName & '"')
EndFunc
Func Deinstalliere()
	FileDelete(@ScriptDir & "\Options.ini")
	$Ini = ""
	GUICtrlSetData($MenuItem5,"Programm installieren")
	MsgBox(0x40,"Deinstalliert","Einstellungen gelöscht.")
EndFunc
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
	Local $neueVersion = BinaryToString(InetRead("https://dl.dropboxusercontent.com/u/75233120/AviSynth/Aktuelle%20Version.txt",1))
	If $neueVersion <> $aktuelleVersion Then
		If MsgBox(0x24,"Update verfügbar","Ein Update ist verfügbar." & @CRLF & "Möchtest du das Update jetzt ausführen?") = 6 Then
			Update($neueVersion)
		EndIf
	EndIf
	TrayTip("Update","Keine Updates gefunden.",3,1)
EndFunc
Func Update($version)
	TrayTip("Update","Führe Update aus.",10,1)
	InetGet("https://dl.dropboxusercontent.com/u/75233120/AviSynth/AviSynth%20Scriptgenerator%20-%20v" & $version & ".exe",@ScriptDir & "\AviSynth Scriptgenerator - v" & $version & ".exe")
	FileDelete(@DesktopDir & "\AviSynth Scriptgenerator - v" & $aktuelleVersion & ".exe.lnk")
	Exit ShellExecute(@ScriptDir & "\AviSynth Scriptgenerator - v" & $version & ".exe",' loescheAlt "' & @ScriptDir & "\" & @ScriptName & '"')
EndFunc
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
Func checkMKVMerge()
	If IniRead($Ini,"Allgemein","MKVMerge","") = "" Then
		If Not FileExists(@ProgramFilesDir & "\MKVtoolnix\mkvmerge.exe") Then
			MsgBox(0,"Vervollständigen","MKVMerge liegt nicht im Standardordner." & @CRLF & 'Bitte gib den Ort von "MKVMerge.exe" an')
			Local $a = _WinAPI_GetOpenFileName("MKVMerge.exe","Ausführbare Dateien (*.exe)",$Standardordner,"mkvmerge.exe",".exe",0,BitOR($OFN_HIDEREADONLY, $OFN_EXPLORER))
			If $a[1] = "" Then
				_ArrayAdd($Fehler,"MKVMerge wurde nicht gefunden.")
			Else
				IniWrite($Ini,"Allgemein","MKVMerge",$a[1] & "\" & $a[2])
			EndIf
		Else
			IniWrite($Ini,"Allgemein","MKVMerge",@ProgramFilesDir & "\MKVtoolnix\mkvmerge.exe")
		EndIf
	Else
		$MKVMerge = IniRead($Ini,"Allgemein","MKVMerge",@ProgramFilesDir & "\MKVtoolnix\mkvmerge.exe")
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
#region ;GUICtrl
Func showErweitert()
	$erweitert = True
	If $Audio = True Then
		GUICtrlSetState($Button8, $GUI_SHOW)
	EndIf
	GUICtrlSetState($CheckRadio1, $GUI_SHOW)
	GUICtrlSetState($CheckRadio2, $GUI_SHOW)
	GUICtrlSetState($Group2, $GUI_SHOW)
	GUICtrlSetState($Checkbox5, $GUI_SHOW)
	GUICtrlSetState($Checkbox6, $GUI_SHOW)
EndFunc
Func activateGroesse()
	GUICtrlSetState($Checkbox1, $GUI_ENABLE)
EndFunc
Func deactivateGroesse()
	GUICtrlSetState($Checkbox1, $GUI_DISABLE)
	GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
	GUICtrlSetState($Input3, $GUI_DISABLE)
	GUICtrlSetState($Input4, $GUI_DISABLE)
	$Resize = False
EndFunc
Func showRandbild()
	resetMuxen()
	showRandverlauf()
	deactivateGroesse()
	GUICtrlSetState($CheckRadio2, $GUI_UNCHECKED)
	GUICtrlSetState($CheckRadio1, $GUI_CHECKED)
	GUICtrlSetState($Button6, $GUI_SHOW)
	GUICtrlSetState($Input9, $GUI_SHOW)
	GUICtrlSetTip($Input8, "Bild am linken Rand")
	GUICtrlSetTip($Input9, "Bild am rechten Rand")
	$Randverlauf = False
	$Randbild = True
EndFunc
Func showRandverlauf()
	$Randverlauf = True
	$Randbild = False
	resetMuxen()
	GUICtrlSetState($CheckRadio1, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2, $GUI_ENABLE)
	deactivateGroesse()
	GUICtrlSetState($Checkbox4, $GUI_UNCHECKED)
	GUICtrlSetState($Input7, $GUI_SHOW)
	GUICtrlSetState($CheckRadio1, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox5, $GUI_UNCHECKED)
	GUICtrlSetState($Input8, $GUI_SHOW)
	GUICtrlSetState($Input9, $GUI_HIDE)
	GUICtrlSetState($Input10, $GUI_SHOW)
	GUICtrlSetState($Input11, $GUI_SHOW)
	GUICtrlSetState($Button5, $GUI_SHOW)
	GUICtrlSetState($Button6, $GUI_HIDE)
	GUICtrlSetState($Label6, $GUI_SHOW)
	GUICtrlSetState($Input12, $GUI_DISABLE)
	GUICtrlSetState($Input2, $GUI_ENABLE)
	GUICtrlSetState($Button1, $GUI_ENABLE)
	GUICtrlSetTip($Input8, "Verlaufsbild")
EndFunc
Func showMuxen()
	resetRandbild()
	GUICtrlSetState($Group3, $GUI_SHOW)
	GUICtrlSetState($Button7, $GUI_SHOW)
	GUICtrlSetState($Input12, $GUI_SHOW)
	GUICtrlSetState($Label7, $GUI_SHOW)
	GUICtrlSetState($Checkbox4, $GUI_SHOW)
	GUICtrlSetState($CheckRadio1, $GUI_UNCHECKED)
	GUICtrlSetState($CheckRadio2, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2, $GUI_DISABLE)
	GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
	GUICtrlSetState($Input5, $GUI_DISABLE)
	GUICtrlSetState($Input2, $GUI_DISABLE)
	GUICtrlSetState($Checkbox6, $GUI_DISABLE)
	GUICtrlSetState($Checkbox6, $GUI_UNCHECKED)
	GUICtrlSetState($Button1, $GUI_DISABLE)
	GUICtrlSetState($Button3, $GUI_DISABLE)
	deactivateGroesse()
	$ChangeFPS = False
	$Muxen = True
EndFunc
Func resetErweitert()
	$erweitert = False
	$Audio = False
	GUICtrlSetState($Checkbox5, $GUI_HIDE)
	GUICtrlSetState($CheckRadio1, $GUI_HIDE)
	GUICtrlSetState($CheckRadio2, $GUI_HIDE)
	GUICtrlSetState($Group2, $GUI_HIDE)
	GUICtrlSetState($CheckRadio1, $GUI_UNCHECKED)
	GUICtrlSetState($CheckRadio2, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox6, $GUI_HIDE)
	GUICtrlSetState($Checkbox6, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox5, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox4, $GUI_UNCHECKED)
	GUICtrlSetState($Input12, $GUI_HIDE)
	GUICtrlSetState($Button8, $GUI_HIDE)
	resetMuxen()
	resetRandbild()
EndFunc
Func resetRandbild()
	$Randbild = False
	GUICtrlSetState($Input9, $GUI_HIDE)
	resetRandverlauf()
EndFunc
Func resetRandverlauf()
	$Randverlauf = False
	activateGroesse()
	GUICtrlSetState($Input7, $GUI_HIDE)
	GUICtrlSetState($Input8, $GUI_HIDE)
	GUICtrlSetState($Input10, $GUI_HIDE)
	GUICtrlSetState($Input11, $GUI_HIDE)
	GUICtrlSetState($Button5, $GUI_HIDE)
	GUICtrlSetState($Button6, $GUI_HIDE)
	GUICtrlSetState($Label6, $GUI_HIDE)
EndFunc
Func resetMuxen()
	GUICtrlSetState($Group3, $GUI_HIDE)
	GUICtrlSetState($Button7, $GUI_HIDE)
	GUICtrlSetState($Input12, $GUI_HIDE)
	GUICtrlSetState($Label7, $GUI_HIDE)
	GUICtrlSetState($Checkbox4, $GUI_HIDE)
	GUICtrlSetState($Input12, $GUI_DISABLE)
	GUICtrlSetState($Checkbox4, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2, $GUI_ENABLE)
	GUICtrlSetState($Checkbox6, $GUI_ENABLE)
	GUICtrlSetState($Button3, $GUI_ENABLE)
	activateGroesse()
	GUICtrlSetState($Input2, $GUI_ENABLE)
	GUICtrlSetState($Button1, $GUI_ENABLE)
	$Muxen = False
	$Schneiden = False
EndFunc
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
				FileWrite($Datei,", audio=False).AssumeFPS(" & $VideoFPS & ",1)")
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
Func showsplash()
	$destination = @WorkingDir & "\Scriptgeneratorsplash.jpg"
	FileInstall("A:\Daten\Avisynth Scriptgenerator\Scriptgeneratorsplashh.jpg", $destination)  ;source must be literal string
	SplashImageOn("Splash Screen",$destination,910,117,-1,-1,3)
	#cs Doppelstart verhindern
	If ProcessExists("AviSynth Scriptgenerator - v" & $aktuelleVersion & ".exe") <> 0 Then
		MsgBox(0x10,"Prozess","Das Programm ist bereits gestartet.",5)
		Exit
	EndIf
	#ce
	checkUpdate()
	SplashOff()
	FileDelete($destination)
EndFunc
