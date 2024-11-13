This is a very simple command line tool for controlling Wiz lights in Windows.

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

<b>Example Command:</b><br>
<code>Lights on</code><br>
<code>Lights color 255 0 255</code><br>
<code>Lights id 15</code><br>
<code>Lights ip 192.168.1.21</code>

<b>Light id's</b>
<br>
  - 4 Party
  - 5 Fireplace
  - 6 cozy
  - 7 Forest
  - 8 Pastel
  - 9 Wake up
  - 10 Bedtime
  - 11 Warm White
  - 12 Daylight
  - 13 cool white
  - 14 night light
  - 15 focus
  - 16 relax
  - 18 TV time
  - 19 Plantgrowth
  - 20 Spring
  - 21 Summer
  - 22 Fall
  - 23 Deepdive
  - 24 Jungle
  - 25 Mojito
  - 26 Club
  - 27 Christmas
  - 28 Halloween
  - 29 Candlelight
  - 30 Golden White
  - 31 Pulse
  - 32 Steampunk
  - 1000 Rhythm

Speical thanks to <a href="https://www.reddit.com/r/wiz/comments/1582jfx/guide_to_controlling_a_wiz_lightplug_via_windows/">u/seanmacproductions</a> from reddit for making the <a href="https://seanmcnally.net/wiz-config.html">UDP code generator</a>.
