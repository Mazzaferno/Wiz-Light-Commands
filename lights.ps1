<#param (
    [string]$p,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$args
)
there was no need for these params, just use $args array..    #>

$iniPath = Join-Path $env:APPDATA "wizlight\temp.ini"
function set-IPs() {
    Write-Host "Please enter an ip or multiple seperated by commas like 1.1.1.1, 1.1.1.2"
    [array]$ips = Read-Host "Enter IPs"
    $ips = $ips -split ","
    $ips.trim() | Out-File -FilePath $iniPath -Encoding utf8
    return($ips)
    
}
if (-not (Test-Path $iniPath)){
    Write-Host "No wizlight found."
    $ips = set-IPs
}

[array]$ips = Get-Content $iniPath
$port = 38899

# Create the JSON message
$message = ""
switch ($args[0]) {
    "on" {
        $method = "setState"
        $parameters = @{ state = $true }
        $message = "Lights turning on, thank you"
    }
    "off" {
        $method = "setState"
        $parameters = @{ state = $false }
        $message = "Lights turning off, goodnight"
    }
    "1"{
        $method = "setPilot"
        $parameters = @{temp = 3966; dimming = 100}
        $message = "Lights turning set to full brightness"

    }
    "2"{
        $method = "setPilot"
        $parameters = @{temp = 3966; dimming = 20}

    }
    "id"{
        $id = $args[1]
        if ($id.GetType() -ne [int]){
            Write-Host "Usage: lights id <id>"
            Write-Host "---------------------------------------
            Available IDs:`n
            4 Party
            5 Fireplace
            6 cozy
            7 Forest
            8 Pastel
            9 Wake up
            10 Bedtime
            11 Warm White
            12 Daylight
            13 cool white
            14 night light
            15 focus
            16 relax
            18 TV time
            19 Plantgrowth
            20 Spring
            21 Summer
            22 Fall
            23 Deepdive
            24 Jungle
            25 Mojito
            26 Club
            27 Christmas
            28 Halloween
            29 Candlelight
            30 Golden White
            31 Pulse
            32 Steampunk
            1000 Rhythm"
            exit
        }
        $id = [int]$id
        $method = "setPilot"
        $parameters = @{sceneId = $id; dimming = 100; speed = 125}

    }
    "color" {
        if ($args.Count -ne 4) {
            Write-Host "Usage: -p color 255 0 0"
            exit
        }
        $r = $args[1]
        $g = $args[2]
        $b = $args[3]
        $method = "setPilot"
        $parameters = @{ r = $r; g = $g; b = $b }
        $message = "Lights turning to color $r, $g, $b"
    }
    "ip"{
        $ips = set-IPs
        $ips | Out-File -FilePath $iniPath -Encoding utf8
        Write-Host "IPs saved to $iniPath"
        exit
    }
    default {
                        write-host "
        ___  ___                              __ _
        |  \/  |                             / _| |
        | .  . | __ _ __________ _ ___  ___ | |_| |_
        | |\/| |/ _  |_  /_  / _  / __|/ _ \|  _| __|
        | |  | | (_| |/ / / / (_| \__ \ (_) | | | |_
        \_|  |_/\__,_/___/___\__,_|___/\___/|_|  \__|
                                                    
                Lights control script
                   open source 2025

                by github.com/mazzaferno
        " -ForegroundColor red
        Write-Host "
        on .................- turn on the lights
        off                 - turn off the lights
        1  .................- set to full brightness
        2                   - set to 20% brightness
        id <id> ............- set the lights to a preset scene - id help for available ids
        color <r> <g> <b>   - set the lights to a color - r,g,b values between 0-255
        ip .................- set the ip(s) of the lights
        " -ForegroundColor Cyan


        exit
    }
}



function  Send-UDPMessage {

    $json = @{
        id     = 1
        method = $method
        params = $parameters
    } | ConvertTo-Json -Compress
    
# Convert the message to bytes
$bytes = [System.Text.Encoding]::UTF8.GetBytes($json)

# Create the UDP client
$udp = New-Object System.Net.Sockets.UdpClient

# Send the UDP packet
foreach ($ip in $ips) {
    $udp.Send($bytes, $bytes.Length, $ip, $port) | Out-Null
}

# Close the client
$udp.Close()

$colors = @("Green", "Red", "Yellow", "Cyan", "Magenta", "White")
foreach ($char in $message.ToCharArray()) {
    $random = Get-Random -Maximum $colors.Count
    Write-Host -NoNewline $char -ForegroundColor Green
    Start-Sleep -Milliseconds 50
}
}
Send-UDPMessage
