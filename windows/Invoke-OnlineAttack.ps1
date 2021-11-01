<#
.SYNOPSIS
    Performs an online dictionary on a given WPA2-PSK Wi-Fi network.

.DESCRIPTION
    Performs an online dictionary on a given WPA2-PSK Wi-Fi network.
    Takes an input network SSID and wordlist then attempts to connect
    to the Wi-Fi network using all passwords in the wordlist.

.INPUTS
    None. You cannot pipe objects to Invoke-OnlineAttack.

.OUTPUTS
    System.String. Invoke-OnlineAttack returns the password as a String.

.NOTES
    Version:        1.0
    Author:         Soufiane Belmir, Ethan Ho, William Lu
    Creation Date:  2021-10-13
    Purpose/Change: Initial script development
  
.EXAMPLE
    .\Invoke-OnlineAttack -Wordlist "rockyou.txt"
#>

param
(
    # Wi-Fi network SSID
    [Parameter(Mandatory = $true)]
    [string]
    $SSID,
    
    # Path to wordlist file
    [Parameter(Mandatory = $true)]
    [string]
    $Wordlist
)

