@echo off
echo ============================================
echo     INSTALADOR APK ANDROID via ADB
echo ============================================
echo.

set ADB_PATH="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
set APK_PATH="app\build\outputs\apk\debug\app-debug.apk"

echo [1] Verificando se ADB esta disponivel...
if not exist %ADB_PATH% (
    echo ERRO: ADB nao encontrado!
    echo Instale o Android Studio ou Android SDK
    pause
    exit /b 1
)
echo ✓ ADB encontrado

echo.
echo [2] Verificando dispositivos conectados...
%ADB_PATH% devices
echo.

echo [3] Verificando se APK existe...
if not exist %APK_PATH% (
    echo ERRO: APK nao encontrado!
    echo Execute primeiro: gradlew.bat assembleDebug
    echo Ou gere o APK pelo Android Studio
    pause
    exit /b 1
)
echo ✓ APK encontrado: %APK_PATH%

echo.
echo [4] IMPORTANTE - Verifique no seu Android:
echo    ✓ Modo Desenvolvedor ativado
echo    ✓ Depuracao USB ativada  
echo    ✓ Cabo USB conectado
echo    ✓ Permissao concedida no popup do Android
echo.
pause

echo [5] Instalando APK...
%ADB_PATH% install -r %APK_PATH%

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo       APK INSTALADO COM SUCESSO! 🎉
    echo ============================================
    echo.
    echo O app foi instalado no seu dispositivo Android
    echo Procure pelo icone "Desko" na tela inicial
) else (
    echo.
    echo ============================================
    echo         ERRO NA INSTALACAO ❌
    echo ============================================
    echo.
    echo Possiveis solucoes:
    echo - Verifique se a Depuracao USB esta ativada
    echo - Aceite o popup de permissao no Android
    echo - Tente desconectar e conectar o cabo USB
    echo - Execute: adb kill-server e tente novamente
)

echo.
pause
