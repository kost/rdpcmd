$servername = $CMDLINE[1]
$username = $CMDLINE[2]
$password = $CMDLINE[3]
$cmd = $CMDLINE[4]
$sleep = $CMDLINE[5]

run("cmdkey /generic:""" & $servername & """ /user:""" & $username & """ /pass:""" & $password & """")
run("mstsc /console /v:"& $servername)

Local $hWnd = WinWait("[CLASS:TscShellContainerClass]", "", 10)

if $hWnd = 0 Then
   Exit(1)
EndIf

Sleep(2000)

WinSetState ( "[CLASS:TscShellContainerClass", "", @SW_MAXIMIZE )
Sleep(2000)
send("#r")
Sleep(2000)
send("powershell Start-Process cmd -Verb runAs{ENTER}")
Sleep(2000)
send("{ALT}y")
Sleep(2000)

send($cmd & "{ENTER}")
if $sleep > 0 Then
   Sleep($sleep)
   send("exit{ENTER}")
EndIf

WinClose($hWnd)

run("cmdkey /delete:" & $servername)
