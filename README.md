# WPA2-PSK Attacks

## Offline

Use of Aircrack-ng tools to capture the four-way handshake and crack passwords.

## Online

### Windows

From the Windows Command Line or PowerShell, run the `Invoke-OnlineAttack.ps1`
script.

```
C:\> powershell.exe -ExecutionPolicy Bypass .\Invoke-OnlineAttack.ps1 -SSID <SSID> -Wordlist <wordlist-file>
```

### UNIX

From the terminal, run the `online_attack.sh` script.

```console
$ sudo ./online_attack.sh <interface> <ssid> <wordlist-file>
```

