# WPA2-PSK Attacks

## Offline

Use of Aircrack-ng tools to capture the four-way handshake and crack passwords.

## Online

### Windows

From PowerShell, run the `Invoke-OnlineAttack.ps1` script. The execution policy
may need to be set to Unrestricted before the script can be run
(`PS C:\> Set-ExecutionPolicy -Scope Current User Unrestricted`).

```
PS C:\> .\Invoke-OnlineAttack.ps1 -SSID <SSID> -Wordlist <wordlist-file>
```

Alternatively, the Windows Command Line can be used to invoke the script.

```
C:\> powershell.exe -ExecutionPolicy Bypass .\Invoke-OnlineAttack.ps1 -SSID <SSID> -Wordlist <wordlist-file>
```

### UNIX

From the terminal, run the `online_attack.sh` script.

```console
$ sudo ./online_attack.sh <interface> <ssid> <wordlist-file>
```

