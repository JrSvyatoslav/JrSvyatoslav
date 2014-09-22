@Echo Off
net localgroup Администраторы
Echo ---
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##asgard#kopilka /v _LabelFromReg | Find "_LabelFromReg" | Find "Kopilka" >nul
If %ERRORLEVEL% NEQ 0 Echo Имя диска неверное - запуск скрипта & goto install
Echo ---
Echo Имя диска верное
Echo ---

For /F "tokens=2,3 delims= " %%i In ('net use') Do If %%i==P: If %%j==\\asgard\kopilka Echo Диск подключен правильно & GoTo check
Echo Диск не подключен

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
Echo OC не поддерживется 
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
Echo Ищу сетевые ярлыки
Echo ---
dir /a-d /b /s "%p%" 2>nul
IF %errorlevel% NEQ 0 Echo Пусто & GoTo EndReg
Echo ---
Echo Нашел, удаляю...
for /d %%i in ("%p%*") do rd /s /q "%%i" 2>nul

:EndReg
Echo ---
Echo Все Ok
