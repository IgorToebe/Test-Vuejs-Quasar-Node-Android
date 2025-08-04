@echo off
echo ============================================
echo      ATUALIZAR ICONE DO APP ANDROID
echo ============================================
echo.

echo Este script te ajudara a atualizar o icone do app.
echo.

echo OPCOES:
echo [1] Usar Android Studio (Recomendado)
echo [2] Substituir manualmente
echo [3] Usar ferramenta online
echo [4] Mostrar localizacao dos icones
echo.

set /p choice="Escolha uma opcao (1-4): "

if "%choice%"=="1" goto android_studio
if "%choice%"=="2" goto manual
if "%choice%"=="3" goto online
if "%choice%"=="4" goto show_location

:android_studio
echo.
echo ============================================
echo         USANDO ANDROID STUDIO
echo ============================================
echo.
echo 1. Abra o Android Studio
echo 2. Clique direito em 'app' -^> New -^> Image Asset
echo 3. Asset Type: Launcher Icons (Adaptive and Legacy)
echo 4. Name: ic_launcher
echo 5. Foreground Layer: Escolha sua imagem
echo 6. Background Layer: Cor ou imagem de fundo
echo 7. Clique Next -^> Finish
echo.
echo O Android Studio gerara automaticamente todos os tamanhos!
goto end

:manual
echo.
echo ============================================
echo        SUBSTITUICAO MANUAL
echo ============================================
echo.
echo Tamanhos necessarios para seu icone:
echo - mdpi:    48x48px
echo - hdpi:    72x72px  
echo - xhdpi:   96x96px
echo - xxhdpi:  144x144px
echo - xxxhdpi: 192x192px
echo.
echo Arquivos a substituir:
echo - ic_launcher.png
echo - ic_launcher_round.png
echo - ic_launcher_foreground.png
echo.
echo Localizacao: android\app\src\main\res\mipmap-*\
goto show_location

:online
echo.
echo ============================================
echo        FERRAMENTAS ONLINE
echo ============================================
echo.
echo Recomendacoes:
echo.
echo 1. Android Asset Studio:
echo    https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html
echo.
echo 2. App Icon Generator:
echo    https://appicon.co/
echo.
echo 3. Icon Kitchen:
echo    https://icon.kitchen/
echo.
echo Passos:
echo 1. Upload sua imagem (512x512px recomendado)
echo 2. Configure padding, cor de fundo, etc.
echo 3. Download o pacote com todas as resolucoes
echo 4. Extraia e substitua nas pastas mipmap
goto show_location

:show_location
echo.
echo ============================================
echo       LOCALIZACAO DOS ICONES
echo ============================================
echo.
echo Os icones estao em:
echo %~dp0app\src\main\res\
echo.
echo Pastas:
dir /b "%~dp0app\src\main\res\mipmap-*" 2>nul
echo.
echo Abrindo pasta dos icones...
start "" "%~dp0app\src\main\res\"
goto end

:end
echo.
echo ============================================
echo         APOS ATUALIZAR O ICONE
echo ============================================
echo.
echo 1. Limpe o projeto:     gradlew clean
echo 2. Sincronize:          npx cap sync  
echo 3. Rebuilde:            gradlew assembleDebug
echo 4. Instale novamente:   instalar-apk.bat
echo.
echo DICA: Use uma imagem 512x512px como base!
echo.
pause
