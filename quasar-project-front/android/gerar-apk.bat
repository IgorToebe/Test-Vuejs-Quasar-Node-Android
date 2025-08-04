@echo off
echo ================================
echo    GERANDO APK ANDROID
echo ================================
echo.

echo [1/3] Construindo projeto Vue/Quasar...
cd ..
call npm run build
if %errorlevel% neq 0 (
    echo ERRO: Falha ao construir o projeto
    pause
    exit /b 1
)

echo.
echo [2/3] Sincronizando com Capacitor...
call npx cap sync
if %errorlevel% neq 0 (
    echo ERRO: Falha ao sincronizar com Capacitor
    pause
    exit /b 1
)

echo.
echo [3/3] Gerando APK...
cd android
call gradlew.bat assembleDebug
if %errorlevel% neq 0 (
    echo ERRO: Falha ao gerar APK
    pause
    exit /b 1
)

echo.
echo ================================
echo       APK GERADO COM SUCESSO!
echo ================================
echo.
echo Localizacao do APK:
echo app\build\outputs\apk\debug\app-debug.apk
echo.
echo Pressione qualquer tecla para abrir a pasta...
pause > nul

start "" "app\build\outputs\apk\debug"
