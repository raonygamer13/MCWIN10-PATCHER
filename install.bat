@echo off
color a
cls

echo                  _________-----_____
echo        ____------           __      ----_
echo  ___----             ___------              \
echo     ----________        ----                 \
echo                -----__    ^|             _____)
echo                     __-                /     \
echo         _______-----    ___--          \    /)\
echo   ------_______      ---____            \__/  /
echo                -----__    \ --    _          /\
echo                       --__--__     \_____/   \_/\
echo                               ---^|   /          ^|
echo                                  ^| ^|___________^|
echo                                  ^| ^| ((_(_)^| )_)
echo                                  ^|  \_((_(_)^|/(_)
echo                                   \             (
echo                                    \_____________)
echo -                                     V-----2.0
echo ===================================================================================
echo -
for /f "tokens=2 delims==" %%a in ('wmic os get OSLanguage /Value') do set OSLanguage=%%a
if %OSLanguage%==1046 (
   ::PORTUGUESE
   echo Linguagem: Portugues
   set admBusy=Esperando privilegios de administrador...
   set runningWarn=Rodando o instalador...
   set runQuestion=Voce deseja instalar o patch para Minecraft: Windows 10 [S/N]?
   set archMsg=Este PC e
   set patchingMessage=Patcheando Windows.ApplicationModel.Store.dll em
   set thanksMessage=Obrigado %username% por usar o meu Script, todos os direitos reservados a mim raonygamer13...
   set qS=S
) else (
   ::OTHER
   echo Language: English or Other
   set admBusy=Requesting administrative privileges...
   set runningWarn=Running installer...
   set runQuestion=Do you want to install the patch for Minecraft: Windows 10 [Y/N]?
   set archMsg=This PC is
   set patchingMessage=Patching Windows.ApplicationModel.Store.dll in
   set thanksMessage=Thanks %username% for using my Script, all rights reserved to me raonygamer13...
   set qS=Y
)

::install
    if exist "%PROGRAMFILES(x86)%" (set arch=64) else (set arch=32)
    echo %archMsg% %arch% bits
    set /p c=%runQuestion% 
    if /i "%c%" == "%qS%" goto initializing
    if /i "%c%" == "N" exit

:initializing
    echo %runningWarn%
    set relativePath=%~dp0
    set sys32Path=%systemroot%\system32
    set wow64Path=%systemroot%\syswow64
    set unlockerPath=%relativePath%%arch%\Unlocker
    set launcherPath=%relativePath%%arch%\Launcher
    goto %arch%

:64
    ::SYSTEM32
    cd %sys32Path%
    echo %patchingMessage% %cd%
    cd %unlockerPath%
    IObitUnlocker.exe /delete /normal %sys32Path%\Windows.ApplicationModel.Store.dll
    cd %relativePath%%arch%\System32
    copy Windows.ApplicationModel.Store.dll %sys32Path%
    ::SYSWOW64
    cd %wow64Path%
    echo %patchingMessage% %cd%
    cd %unlockerPath%
    IObitUnlocker.exe /delete /normal %sys32Path%\Windows.ApplicationModel.Store.dll
    cd %relativePath%%arch%\SysWOW64
    copy Windows.ApplicationModel.Store.dll %wow64Path%
    cd %launcherPath%
    BedrockLauncherInstaller.exe
    goto end
    
:32
    ::SYSTEM32
    cd %sys32Path%
    echo %patchingMessage% %cd%
    cd %unlockerPath%
    IObitUnlocker.exe /delete /normal %sys32Path%\Windows.ApplicationModel.Store.dll
    cd %relativePath%%arch%\System32
    copy Windows.ApplicationModel.Store.dll %sys32Path%
    cd %launcherPath%
    MCLauncher.exe
    goto end

:end
    cd %relativePath%
    echo %thanksMessage%
    timeout 5
    start https://www.youtube.com/channel/UCYtFAT9Zhiv6FvhG-LGGRfQ/subscribe