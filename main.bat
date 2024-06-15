:: By guelzn

@echo off

:main

echo.
echo.   
echo                                     -..                                                  
echo                                     .: ............::........... --...=                             
echo                                    .... .. . ...:........      . :.....:.::                         
echo                                  :.....: ..  ....................:...........                       
echo                                  ..... .. .......:........: ....  :...........                      
echo                                 ..........          :.......:  :..........::-:                      
echo                               :.... .... ..           :........ ................-                   
echo                               :..... :... .:            -....... ...............:                   
echo                                        ......      =-  :...:......-.....-                           
echo                                    :... ......      :...:... ......-....                            
echo                                  ....  ......:       ......-   :....:..                             
echo                            :....... .....          :.........:  :...:::                            
echo                         :.....    ...-::----:::-:  :.....=:.....:  :..:                             
echo                        :....      ................::....     :..... :..:                            
echo                       ..                         ..::...        :....-.:                            
echo                       .............................                :..:.-                           
echo                                                                    :.:+                           
echo                                          :: ::.:..  .. .::::           -                            
echo                                              .:  . : . :. ..                                        
echo.                                                                      
echo                   __________________________________________________________________
echo.
echo               "OTIMIZACAO AUTOMATICA" - by guelzn - Copyright 2024 - All rights reserved
echo.
echo.

echo                                      [1] Enable Vinte7           [4] Revert
echo                                       [2] About                    [5] Exit
echo                                        [3] Create the partition                                      
echo.
set /p a= Choose a option: 

if %a%==1 (
goto one 
) 
if %a%==2 (
goto two
)
if %a%==3 (
goto three
)
if %a%==4 (
goto four
)
if %a%==5 (
goto five
)

) else (
goto main
)

:one
    
    cls
    echo Antes de Inicializarmos o Script, limparemos sua lixeira mais as pastas Temp e Prefetch!
    pause
    cls
	
    :: REM *** para apagar arquivos temporários + lixeira

    powershell -Command "Remove-Item 'C:\Usersz\"%USERNAME%"\AppData\Local\Temp\*' -Recurse -Force"
	powershell -Command "Remove-Item 'C:\Windows\Prefetch\*' -Recurse -Force"
	powershell -Command "Remove-Item 'C:\Windows\Temp\*' -Recurse -Force"
	rd /s /q C:\$Recycle.bin
    
    :: REM *** Acelerar desligamento

    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f
    
    :: REM *** Diminuir processos do Windows
    
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_SZ /d 04000000 /f

    :: Desabilita o microsoft EDGE em segundo plano
	
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "SyncFavoritesBetweenIEAndMicrosoftEdge" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "PreventLiveTileDataCollection" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "PreventTabPreloading" /t REG_DWORD /d 1 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d 0 /f

    :: REM *** Desabilita otimização de entrega

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_SZ /d 0 /f

    :: REM *** Tirar algumas animações

    reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9032078010000000 /f
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" REG_SZ /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IconsOnly" /T REG_DWORD /D 1 /F
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewAlphaSelect" /T REG_DWORD /D 1 /F
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /t REG_DWORD /d 0 /f
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d 2 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewShadow" /T REG_DWORD /D 1 /F
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /V "AlwaysHibernateThumbnails" /T REG_DWORD /D 0 /F
 
    :: REM *** Desabilita cortana e "telemetria"
	
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

    :: REM *** Melhora um pouco a internet
	
    netsh interface teredo set state disable
	netsh interface 6to4 set state disable disable
	netsh interface isatap set state disable
	
    reg add "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v "EnableICSIPv6" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f


    cls
    pause
    cls 
goto main

:two
    cls
    echo Um script desenvolido pelo guelzn, no intuito de melhorar o fps e input lag (+100 fps boost)
	pause
	start https://x.com/tweaks27
	start https://www.youtube.com/@guelznhighlights
	cls
goto main

:three
    
    cls
    :: REM *** Ponto de restauração

    C:\Windows\System32\cmd.exe /k "Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%USERNAME%", "%DATE%" 100, 7"

    cls
    pause
    cls
goto main

:four

    cls
    :: REM *** Reverter Acelerar desligamento

    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /f
    
    :: REM *** Reverter Diminuir processos do Windows
    
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /f

    :: REM *** Reverter Tirar algumas animações

    reg delete "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /f
    reg delete "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /f
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /f
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /f
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /f
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "DragFullWindows" /f
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "FontSmoothing" /f
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /f
goto main

:five
exit 
