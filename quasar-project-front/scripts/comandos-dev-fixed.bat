@echo off
chcp 65001 >nul
title Quasar Android - Comandos de Desenvolvimento

:menu
echo.
echo ============================================
echo     QUASAR ANDROID - COMANDOS UTEIS
echo ============================================
echo.
echo 1. Desenvolvimento Web
echo 2. Build e Sync Android  
echo 3. Executar no Android
echo 4. Executar com Live Reload
echo 5. Abrir Android Studio
echo 6. Ver Logs ADB
echo 7. Limpar Cache
echo 8. Verificar Dispositivos
echo 9. Configurar Firewall (Porta 9000)
echo 10. Gerar APK Release (Producao)
echo 11. Sair
echo.
set /p choice="Escolha uma opcao (1-11): "

if "%choice%"=="1" goto :opcao1
if "%choice%"=="2" goto :opcao2
if "%choice%"=="3" goto :opcao3
if "%choice%"=="4" goto :opcao4
if "%choice%"=="5" goto :opcao5
if "%choice%"=="6" goto :opcao6
if "%choice%"=="7" goto :opcao7
if "%choice%"=="8" goto :opcao8
if "%choice%"=="9" goto :opcao9
if "%choice%"=="10" goto :opcao10
if "%choice%"=="11" goto :sair

echo.
echo ❌ Opcao invalida! Digite um numero de 1 a 11.
echo.
pause
goto :menu

:opcao1
echo.
echo Iniciando servidor de desenvolvimento...
call npm run dev
echo.
echo ✅ Servidor finalizado!
pause
goto :menu

:opcao2
echo.
echo Fazendo build e sync...
call npm run android:build
echo.
echo ✅ Build e sync concluidos!
pause
goto :menu

:opcao3
echo.
echo Executando no Android...
call npm run android:run
echo.
echo ℹ️  App instalado e executado no dispositivo!
pause
goto :menu

:opcao4
echo.
echo Executando com live reload...
echo ⚠️  Certifique-se que a porta 9000 esteja liberada no firewall!
echo ⚠️  Use opcao 9 se ainda nao configurou o firewall.
echo.
call npm run android:run-live
echo.
echo ℹ️  Live reload ativo! Mudancas no codigo aparecerao automaticamente no app.
pause
goto :menu

:opcao5
echo.
echo Abrindo Android Studio...
call npm run android:open
echo.
echo ℹ️  Android Studio foi aberto com o projeto!
echo ℹ️  Aguarde carregar e execute o app clicando no botao Run ▶️
pause
goto :menu

:opcao6
echo.
echo Mostrando logs ADB (Ctrl+C para sair)...
echo ℹ️  Filtrando apenas logs do Capacitor...
echo.
call adb logcat | findstr "Capacitor"
pause
goto :menu

:opcao7
echo.
echo Limpando cache...
call npm run android:clean
echo.
echo ✅ Cache limpo!
pause
goto :menu

:opcao8
echo.
echo Verificando dispositivos conectados...
call adb devices
echo.
pause
goto :menu

:opcao9
echo.
echo ============================================
echo     CONFIGURACAO DO FIREWALL
echo ============================================
echo.
echo ⚠️  ATENCAO: Esta operacao ira:
echo    • Abrir a porta 9000 no Firewall do Windows
echo    • Permitir conexoes de entrada na rede local
echo    • Necessario para o Live Reload funcionar
echo.
echo 🔒 Seguranca:
echo    • Apenas dispositivos na sua rede WiFi poderao se conectar
echo    • A porta sera usada apenas para desenvolvimento
echo.
set /p confirm="Deseja continuar? (S/N): "

if /i "%confirm%"=="S" (
    echo.
    echo Configurando Firewall para Live Reload...
    echo.
    echo Criando regra para porta 9000...
    netsh advfirewall firewall add rule name="Quasar Live Reload - Porta 9000" dir=in action=allow protocol=TCP localport=9000
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Firewall configurado com sucesso!
        echo ✅ Porta 9000 liberada para Live Reload
        echo ✅ Agora voce pode usar a opcao 4 (Live Reload)
    ) else (
        echo.
        echo ❌ Erro ao configurar firewall!
        echo ❌ Execute este script como Administrador
        echo ❌ Clique com botao direito → "Executar como administrador"
    )
) else (
    echo.
    echo ❌ Operacao cancelada pelo usuario
    echo ℹ️  Para usar Live Reload, a porta 9000 precisa estar aberta
)
echo.
pause
goto :menu

:opcao10
echo.
echo ============================================
echo     GERAR APK RELEASE (PRODUCAO)
echo ============================================
echo.
echo 📱 Este processo ira:
echo    • Fazer build de producao (otimizado)
echo    • Sincronizar com Android
echo    • Gerar APK assinado para distribuicao
echo.
echo ⏳ Tempo estimado: 2-5 minutos
echo.
set /p confirm="Deseja continuar? (S/N): "

if /i "%confirm%"=="S" (
    echo.
    echo 🔄 Passo 1/3: Build de producao...
    call npm run build
    
    if %errorlevel% equ 0 (
        echo ✅ Build concluido com sucesso!
        echo.
        echo 🔄 Passo 2/3: Sincronizando com Android...
        call npx cap sync android
        
        if %errorlevel% equ 0 (
            echo ✅ Sync concluido com sucesso!
            echo.
            echo 🔄 Passo 3/3: Gerando APK Release...
            echo ⚠️  O Android Studio vai abrir - execute o build la:
            echo    1. Aguarde carregar completamente
            echo    2. Build → Generate Signed Bundle/APK
            echo    3. Escolha APK
            echo    4. Selecione keystore ou crie novo
            echo    5. Aguarde geracao
            echo.
            call npx cap open android
            echo.
            echo ℹ️  APK sera gerado em: android/app/build/outputs/apk/release/
        ) else (
            echo ❌ Erro no sync! Verifique a configuracao.
        )
    ) else (
        echo ❌ Erro no build! Verifique o codigo.
    )
) else (
    echo ❌ Operacao cancelada pelo usuario
)
echo.
pause
goto :menu

:sair
echo.
echo ✅ Saindo... Obrigado por usar o script!
echo.
pause
exit /b 0
