@echo off
echo =============================================
echo    ADICIONAR ADB AO PATH DO WINDOWS
echo =============================================
echo.

set ADB_PATH=%LOCALAPPDATA%\Android\Sdk\platform-tools

echo Adicionando ADB ao PATH...
echo Caminho: %ADB_PATH%

:: Adicionar ao PATH temporariamente (apenas para esta sessão)
set PATH=%PATH%;%ADB_PATH%

echo.
echo ✓ ADB adicionado ao PATH temporariamente
echo.
echo Para tornar permanente:
echo 1. Abra "Variáveis de Ambiente" no Windows
echo 2. Edite a variável PATH
echo 3. Adicione: %ADB_PATH%
echo.
echo Testando ADB...
adb version

echo.
echo Agora você pode usar: adb install app-debug.apk
echo.
pause
