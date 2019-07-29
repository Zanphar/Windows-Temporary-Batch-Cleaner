@ECHO OFF

REM tmpcln - A small batch file to perform certain system tasks at user's request.
REM Copyright 1992-2018 Charles M. McDonald 
REM 
REM Redistribution and use in source and binary forms, with or without modification, are permitted 
REM provided that the following conditions are met:
REM 
REM 1. Redistributions of source code must retain the above copyright notice, this list of conditions 
REM and the following disclaimer. 
REM 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions 
REM and the following disclaimer in the documentation and/or other materials provided with the distribution.
REM 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or 
REM promote products derived from this software without specific prior written permission. 
REM 
REM THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
REM WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
REM PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
REM INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
REM PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
REM HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
REM NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
REM POSSIBILITY OF SUCH DAMAGE. 

CD %HOMEPATH%\Desktop

ECHO: This information is generated using tmpcln from Charles McDonald of CharlieWARE SOFTWARE. >%HOMEPATH%\Desktop\%0.log 
ECHO: You can download a copy of this software from http://www.chware.net/. >>%HOMEPATH%\Desktop\%0.log

ECHO:
ECHO: Storage Available Before: >>%HOMEPATH%\Desktop\%0.log
DIR | FIND "bytes free" >>%HOMEPATH%\Desktop\%0.log
ECHO:

ECHO: tmpcln - A small batch file to perform certain system tasks at user's request.
ECHO: Copyright 1992-2018 Charles M. McDonald 
ECHO:
ECHO: Redistribution and use in source and binary forms, with or without modification, are permitted 
ECHO: provided that the following conditions are met:
ECHO:
ECHO: 1. Redistributions of source code must retain the above copyright notice, this list of conditions 
ECHO: and the following disclaimer. 
ECHO: 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions 
ECHO: and the following disclaimer in the documentation and/or other materials provided with the distribution.
ECHO: 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or 
ECHO: promote products derived from this software without specific prior written permission. 
ECHO:
ECHO: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
ECHO: WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
ECHO: PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
ECHO: INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
ECHO: PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
ECHO: HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
ECHO: NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
ECHO: POSSIBILITY OF SUCH DAMAGE. 
ECHO:
ECHO: By pressing any key to continue, you automatically accept the terms and conditions of the above
ECHO: agreement. If you cannot or do not agree, press CTRL+C to abort this software.
ECHO:
ECHO: IMPORTANT INFORMATION, PLEASE READ CAREFULLY. You may encounter errors during the use of this file,
ECHO: but please keep in mind that not all errors are actually errors.
ECHO:
PAUSE
ECHO:

REM FOR /F "usebackq delims=|" %%f IN (`DIR /B "%SYSTEMDRIVE%\Program Files"`) DO ECHO %%f
REM FOR /F "usebackq delims=|" %%f IN (`DIR /B "%SYSTEMDRIVE%\Program Files (x86)"`) DO ECHO %%f

ECHO: Terminating web browsers that are open...

"%WINDIR%\System32\TASKKILL.EXE" /IM iexplore.exe /F
"%WINDIR%\System32\TASKKILL.EXE" /IM Firefox.exe /F
"%WINDIR%\System32\TASKKILL.EXE" /IM Chrome.exe /F
"%WINDIR%\System32\TASKKILL.EXE" /IM Safari.exe /F
"%WINDIR%\System32\TASKKILL.EXE" /IM Maxthon.exe /F
"%WINDIR%\System32\TASKKILL.EXE" /IM Avant.exe /F

ECHO: Freeing up memory and resources... This may take a while.

"%WINDIR%\System32\TASKKILL.EXE" /F /FI "status eq not responding"
"%WINDIR%\System32\RUNDLL32.EXE" advapi32.dll,ProcessIdleTasks

ECHO: Resetting Icon cache database...
cd /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer attrib –h iconcache_*.db del iconcache_*.db start explorer

taskkill /im explorer.exe /f

CD /d %userprofile%\AppData\Local\Microsoft\Windows\Explorer 
ATTRIB –h 
thumbcache_*.db 
DEL thumbcache_*.db 
START Explorer

TakeOwn /R /F "%userprofile%\AppData\Local\Temporary Internet Files"

ECHO: Erasing stale files that are no longer needed by anything...

DEL /F /S /Q "%SYSTEMDRIVE%\*.tmp"
DEL /F /S /Q "%SYSTEMDRIVE%\*._mp"
DEL /F /S /Q "%SYSTEMDRIVE%\*.log"
DEL /F /S /Q "%SYSTEMDRIVE%\*.gid"
DEL /F /S /Q "%SYSTEMDRIVE%\*.chk"
DEL /F /S /Q "%SYSTEMDRIVE%\*.old"
DEL /F /S /Q "%SYSTEMDRIVE%\Recycled\*.*"
DEL /F /S /Q "%SYSTEMDRIVE%\$Recycle.Bin\*.*"
DEL /F /S /Q "%WINDIR%\*.bak"
DEL /F /S /Q "%WINDIR%\Prefetch\*.*"
DEL /F /S /Q "%USERPROFILE%\Cookies\*.*"
DEL /F /S /Q "%USERPROFILE%\Recent\*.*"
DEL /F /S /Q "%USERPROFILE%\Local Settings\Temporary Internet Files\*.*"
DEL /F /S /Q "%USERPROFILE%\Local Settings\Temp\*.*"
DEL /F /S /Q "%USERPROFILE%\Recent\*.*"

ECHO: Destroying and re-creating Windows Temp folder...

RD /S /Q "%WINDIR%\Temp" & MD "%WINDIR%\Temp"

ECHO: Misc 1
ForFiles /S /P "%WINDIR%\Temp" /D -1 /C "%WINDIR%\SYSTEM32\CMD.EXE /C if @isdir==FALSE DEL /F /Q @PATH"

ECHO: Misc 2

ForFiles /S /P "%USERPROFILE%\Local Settings\Temporary Internet Files" /D -1 /C "%WINDIR%\SYSTEM32\CMD.EXE /C if @isdir==FALSE DEL /F /Q @PATH"

ECHO: Misc 3

ForFiles /S /P "%WINDIR%\SoftwareDistribution\Download" /D -1 /C "%WINDIR%\SYSTEM32\CMD.EXE /C if @isdir==FALSE DEL /F /Q @PATH"

ECHO: Clean Manager AUTO
"%WINDIR%\System32\CLEANMGR.EXE" /AUTOCLEAN

ECHO: Checking Disc for errors...

"%WINDIR%\System32\CHKDSK.EXE" /F

ECHO:
ECHO: Flushing DNS Cache...

"%WINDIR%\System32\IPCONFIG.EXE" /FLUSHDNS

ECHO: Freeing up memory and resources... This may take a while.

"%WINDIR%\System32\TASKKILL.EXE" /F /FI "status eq not responding"
REM "%WINDIR%\System32\RUNDLL32.EXE" advapi32.dll,ProcessIdleTasks

ECHO: Storage Available After: >>%HOMEPATH%\Desktop\%0.log
DIR | FIND "bytes free" >>%HOMEPATH%\Desktop\%0.log

:exit
ECHO: $0 has completed.
