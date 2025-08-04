@echo off
echo ============================================
echo    ATUALIZAR APK COM NOVO ICONE
echo ============================================
echo.

echo [1/4] Limpando projeto...
cd ..
call npx cap sync
if %errorlevel% neq 0 (
    echo ERRO: Falha ao sincronizar
    pause
    exit /b 1
)

echo.
echo [2/4] Limpando cache Android...
cd android
call gradlew.bat clean
if %errorlevel% neq 0 (
    echo ERRO: Falha ao limpar projeto
    pause
    exit /b 1
)

echo.
echo [3/4] Gerando novo APK com icone atualizado...
call gradlew.bat assembleDebug
if %errorlevel% neq 0 (
    echo ERRO: Falha ao gerar APK
    pause
    exit /b 1
)

echo.
echo [4/4] Instalando APK atualizado no dispositivo...
echo.
echo IMPORTANTE: 
echo - Certifique-se que o dispositivo Android esta conectado
echo - Depuracao USB ativada
echo - Aceite as permissoes no popup
echo.
pause

set ADB_PATH="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
set APK_PATH="app\build\outputs\apk\debug\app-debug.apk"

echo Verificando dispositivo...
%ADB_PATH% devices

echo.
echo Instalando APK com novo icone...
%ADB_PATH% install -r %APK_PATH%

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo    APK ATUALIZADO COM SUCESSO! 🎉
    echo ============================================
    echo.
    echo O app foi atualizado no seu dispositivo!
    echo Verifique o novo icone na tela inicial.
    echo.
    echo DICA: Se o icone nao mudou imediatamente:
    echo 1. Reinicie o launcher (tela inicial)
    echo 2. Ou reinicie o dispositivo
) else (
    echo.
    echo ============================================
    echo         ERRO NA INSTALACAO ❌
    echo ============================================
    echo.
    echo Possiveis solucoes:
    echo 1. Verifique se o dispositivo esta conectado
    echo 2. Aceite as permissoes no Android
    echo 3. Tente desinstalar a versao anterior primeiro
)

echo.
pause
