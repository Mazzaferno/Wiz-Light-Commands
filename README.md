This is a very simple command line tool for controlling Wiz lights Via command line in Windows.

<b>Requirements:</b> Npcap <br>
  - the commands are sent to the lights via ncat commands. https://npcap.com/#download

<b>Usage:</b>

 - on - lights on
 - off - lights off
 - 1 - Daylight
 - id - id followed by a number to set scene id 
 - color R G B - set the RGB colors of the light
 - ip - change the ip of your light

putting lights.bat in C:\windows will allow for the command "Lights" to be called from cmd at all times
