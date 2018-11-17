# rdpcmd
script commands over RDP connection

## installation

You need to import registry file in order to disable confirmation RDP prompts (faster and safer):

`
reg import disable-confirmations.reg
`

## usage

Simple usage:
`
rdpcmd <ip> <user> <password> <command> <sleep-after-running>
`

## examples

Run ipconfig, do not close command prompt (you will need to reconnect to RDP to see the output):

`
rdpcmd 192.168.1.1 user password "ipconfig" 0
`

Enable winrm, close command prompt after 5000 ms (5 s):

`
rdpcmd 192.168.1.1 user password "winrm quickconfig -quiet -force" 5000
`
