@echo off

set "filePath=%appdata%\wizlight\temp.ini"

if exist "%filePath%" (
    for /f "delims=" %%A in (%filePath%) do set "ip=%%A"
) else (
    mkdir "%appdata%\wizlight\" 2>nul
    echo Wiz light IP has not been configured.
    set /p ip=Please enter your Wiz light IP:
    cls
    echo Wiz light has been configured to %ip%
    echo %ip% > "%filePath%"
)


:: Check if an argument is passed
if "%1"=="" (
    echo Please specify "on" or "off".
    echo  - use "lights help" for list of commands
    exit /b
)

:: Handle "on" argument
if /i "%1"=="on" (
    echo Turning lights ON...
    :: Insert the command to turn on the lights here
    echo {"id":1,"method":"setState","params":{"state":true}} | ncat -u -w 1 %ip% 38899
    exit /b
)

:: Handle "off" argument
if /i "%1"=="off" (
    echo Turning lights OFF...
    :: Insert the command to turn off the lights here
    echo {"id":1,"method":"setState","params":{"state":false}} | ncat -u -w 1 %ip% 38899
    exit /b
)

if /i "%1"=="1" (
    echo Turning lights to 100...
    :: Insert the command to turn off the lights here
    echo {"id":1,"method":"setPilot","params":{"temp":3966,"dimming":100}} | ncat -u -w 1 %ip% 38899
    exit /b
)

if /i "%1"=="color" (
    if /i "%2"=="help" (
        cls
        echo example command: lights color 255 0 0
        echo 255 0 0 would be red, RGB
        exit /b
    )
        if /i "%2"=="purple" (
        cls
        echo {"id":1,"method":"setPilot","params":{"r":255,"g":0,"b":255,"dimming": 100}} | ncat -u -w 1 %ip% 38899
        exit /b
    )
        if /i "%2"=="red" (
        cls
        echo {"id":1,"method":"setPilot","params":{"r":255,"g":0,"b":0,"dimming": 100}} | ncat -u -w 1 %ip% 38899
        exit /b
    )
        if /i "%2"=="blue" (
        cls
        echo {"id":1,"method":"setPilot","params":{"r":0,"g":0,"b":255,"dimming": 100}} | ncat -u -w 1 %ip% 38899
        exit /b
    )
            if /i "%2"=="green" (
        cls
        echo {"id":1,"method":"setPilot","params":{"r":0,"g":255,"b":0,"dimming": 100}} | ncat -u -w 1 %ip% 38899
        exit /b
    )
    echo Changing colors...
    :: Insert the command to turn off the lights here
    echo {"id":1,"method":"setPilot","params":{"r":%2,"g":%3,"b":%4,"dimming": 100}} | ncat -u -w 1 %ip% 38899
    exit /b
)
if /i "%1"=="id" (
    if /i "%2"=="help" (goto id_list)
    echo setting lights to scene ID: %2....
    
    echo use lights id help for full list of id's
    echo {"id":1,"method":"setPilot","params":{"sceneId":%2,"speed":125,"dimming":100}} | ncat -u -w 1 %ip% 38899
exit /b

)

if /i "%1"=="help" (
    cls
    echo ----------------------
    echo  available commands:
    echo  - on - lights on
    echo  - off - lights off
    echo  - 1 - Daylight
    echo  - color R G B - set the RGB colors of the light
    echo  - id - id followed by a number to set scene id 
    REM Insert the command to turn off the lights here
    
    exit /b
)

if /i "%1"=="party" (
goto loop
)
    goto error
        :loop

echo {"id":1,"method":"setPilot","params":{"r":255,"g":0,"b":255,"dimming": 100}} | ncat -u -w 1 %ip% 38899
timeout /t 3 /nobreak > nul
echo {"id":1,"method":"setPilot","params":{"r":0,"g":255,"b":64,"dimming": 100}} | ncat -u -w 1 %ip% 38899
timeout /t 3 /nobreak > nul
echo {"id":1,"method":"setPilot","params":{"r":255,"g":64,"b":0,"dimming": 100}} | ncat -u -w 1 %ip% 38899
timeout /t 3 /nobreak > nul
    goto loop

:id_list
echo  - 4 Party
echo  - 5 Fireplace
echo  - 6 cozy
echo  - 7 Forest
echo  - 8 Pastel
echo  - 9 Wake up
echo  - 10 Bedtime
echo  - 11 Warm White
echo  - 12 Daylight
echo  - 13 cool white
echo  - 14 night light
echo  - 15 focus
echo  - 16 relax
echo  - 18 TV time
echo  - 19 Plantgrowth
echo  - 20 Spring
echo  - 21 Summer
echo  - 22 Fall
echo  - 23 Deepdive
echo  - 24 Jungle
echo  - 25 Mojito
echo  - 26 Club
echo  - 27 Christmas
echo  - 28 Halloween
echo  - 29 Candlelight
echo  - 30 Golden White
echo  - 31 Pulse
echo  - 32 Steampunk
echo  - 1000 Rhythm
exit /b

:: Invalid argument
:error
echo Invalid option. Please use "lights help" for list of commands

