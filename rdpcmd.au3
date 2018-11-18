if $CmdLine[0] < 4 then
	MsgBox(64, "Not enough parameters", $CmdLine[0] & " parameters have been passed. Need at least 4: server, username, password and command.")
	Exit(1)
EndIf

$servername = $CmdLine[1]
$username = $CmdLine[2]
$password = $CmdLine[3]
$cmd = $CmdLine[4]
if $CmdLine[0] > 4 then
	$sleep = $CmdLine[5]
Else
	$sleep = 0
EndIf
$sleepwait=3000

run("cmdkey /generic:""" & $servername & """ /user:""" & $username & """ /pass:""" & $password & """")
run("mstsc /console /v:"& $servername)

Local $hWnd = WinWait("[CLASS:TscShellContainerClass]", "", 10)
if $hWnd = 0 Then
	;MsgBox(64, "RDP error", "RDP error while connecting")
	ExitCleanup()
	Exit(2)
EndIf

Sleep(2000)

Local $SecurityhWnd = WinExists("Windows Security")
if $SecurityhWnd = 1 Then
	;MsgBox(64, "RDP error", "RDP error while authenticating")
	ExitCleanup()
	Exit(2)
EndIf

if $hWnd = 0 Then
	;MsgBox(64, "RDP error", "RDP error while connecting")
	ExitCleanup()
	Exit(2)
EndIf

; RDP will not receive Window key if RDP session is not maximized
$wstate=WinSetState ( "[CLASS:TscShellContainerClass]", "", @SW_MAXIMIZE )
if $wstate = 0 Then
	;MsgBox(64, "RDP error", "RDP error while maximizing")
	ExitCleanup()
	Exit(2)
EndIf

Sleep(2000)
send("#r")
Sleep(2000)
send("powershell Start-Process cmd -Verb runAs{ENTER}")
Sleep(2000)
send("{ALT}y")
Sleep(2000)

send($cmd & "{ENTER}")
Sleep($sleep+$sleepwait)
if $sleep > 0 Then
   send("exit{ENTER}")
EndIf

WinClose($hWnd)

run("cmdkey /delete:" & $servername)

Func ExitCleanup()
	run("taskkill /F /IM:mstsc.exe /T")
	run("cmdkey /delete:" & $servername)
EndFunc  ; ExitCleanup()
