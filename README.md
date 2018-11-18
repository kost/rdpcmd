# rdpcmd
Execute and script commands over RDP connection. It will try to execute command in elevated cmd.exe

Since there were no examples of how you can use AutoIt to control RDP sessions and also spawn elevated cmd.exe, I wrote one.

## Installation

You need to import registry file in order to disable confirmation RDP prompts (faster and safer):

`
reg import disable-confirmations.reg
`

Note: You need only to run this on host where you will rdpcmd from. You do not have to do it on the hosts you're connecting. Be aware also that rdpcmd will not work if you do not disable confirmations.

Warning: Disabling confirmations have its security implications. That means you will not get confirmation for new/invalid security certificates.

## Usage

Simple usage:

`
rdpcmd <ip> <user> <password> <command> <sleep-after-running>
`

## Examples

Run ipconfig, do not close command prompt (you will need to reconnect to RDP to see the output):

`
rdpcmd 192.168.1.1 user password "ipconfig" 0
`

Enable winrm, close command prompt after 5000 ms (5 s):

`
rdpcmd 192.168.1.1 user password "winrm quickconfig -quiet -force" 5000
`

## Known Limitations

Since it is Proof of Concept (PoC), it have some limitations (pull requests are welcome!):

* Does not handle errors well (connection failure, wrong credentials, etc)
* Works best if you don't have anything else open (especially other RDP sessions)
* Will not report if it fails

