@Echo Off
net localgroup ������������
Echo ---
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##asgard#kopilka /v _LabelFromReg | Find "_LabelFromReg" | Find "Kopilka" >nul
If %ERRORLEVEL% NEQ 0 Echo ��� ��᪠ ����୮� - ����� �ਯ� & goto install
Echo ---
Echo ��� ��᪠ ��୮�
Echo ---

For /F "tokens=2,3 delims= " %%i In ('net use') Do If %%i==P: If %%j==\\asgard\kopilka Echo ��� ������祭 �ࠢ��쭮 & GoTo check
Echo ��� �� ������祭

:install
Echo ---
Echo install...

set diskname=p:
set diskpath=\\asgard\kopilka
set disklabel=Kopilka
If Exist %diskname%\* net use %diskname% /delete
net use %diskname% %diskpath% /Persistent:Yes
cscript.exe "\\asgard\service\Scripts\Net_disk\Drv_Ren.vbs" //B "%diskname%\" "%disklabel%"


:check
Echo ---
For /F "Tokens=2 Delims=[]" %%i In ('ver') Do (
   For /F "Tokens=2,3 Delims=. " %%a In ("%%i") Do Set version=%%a.%%b
)

If "%version%"=="5.1" GoTo XP
If "%version%"=="6.1" GoTo Seven
Echo OC �� �����ন����� 
GoTo :EOF


:Seven
 Echo Windows 7
 set p=%AppData%\Microsoft\Windows\Network Shortcuts\
GoTo Continue

:XP
 Echo Windows XP
 set p=%userprofile%\NetHood\
GoTo Continue

:Continue
Echo ---
Echo ��� �⥢� ��모
Echo ---
dir /a-d /b /s "%p%" 2>nul
IF %errorlevel% NEQ 0 Echo ���� & GoTo EndReg
Echo ---
Echo ��襫, 㤠���...
for /d %%i in ("%p%*") do rd /s /q "%%i" 2>nul

:EndReg
Echo ---
Echo �� Ok
