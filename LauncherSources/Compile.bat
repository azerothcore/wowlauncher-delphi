@ECHO OFF
DEL Launcher.exe
DCC32 Launcher.dpr
PAUSE
UPX Launcher.exe
DEL *.~*
DEL *.dcu
