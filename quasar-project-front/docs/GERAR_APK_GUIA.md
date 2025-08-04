# 📱 Guia Completo: Como Gerar APK Android

Este guia te ajudará a gerar o arquivo APK para instalar o app no Android.

## 🔧 Pré-requisitos

1. **Android Studio** instalado
2. **Android SDK** configurado
3. **Java JDK** 8 ou superior
4. **Gradle** (incluído no Android Studio)

## 📋 Passos para Gerar o APK

### 1. Preparar o Projeto

```bash
# Construir o projeto Vue/Quasar
npm run build

# Sincronizar com Capacitor
npx cap sync

# Abrir no Android Studio
npx cap open android
```

### 2. No Android Studio

#### Opção A: APK de Debug (Desenvolvimento)

1. No Android Studio, vá em **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
2. Aguarde a compilação
3. Clique em **locate** quando aparecer a notificação
4. O APK estará em: `android/app/build/outputs/apk/debug/app-debug.apk`

#### Opção B: APK Release (Produção)

1. No Android Studio, vá em **Build** → **Generate Signed Bundle / APK...**
2. Escolha **APK**
3. Clique **Next**
4. **Criar Keystore** (primeira vez) ou usar existente:
   - **Keystore path**: Escolha onde salvar (ex: `my-keystore.jks`)
   - **Password**: Crie uma senha segura
   - **Alias**: Nome do alias (ex: `my-app-key`)
   - **Validity**: 25 anos
   - Preencha informações do certificado
5. Clique **Next**
6. Escolha **release**
7. Marque ambas opções de assinatura (V1 e V2)
8. Clique **Finish**
9. O APK estará em: `android/app/build/outputs/apk/release/app-release.apk`

### 3. Via Linha de Comando (Alternativa)

#### APK Debug:

```bash
cd android
./gradlew assembleDebug
```

#### APK Release:

```bash
cd android
./gradlew assembleRelease
```

## 📁 Localização dos APKs

- **Debug APK**: `android/app/build/outputs/apk/debug/app-debug.apk`
- **Release APK**: `android/app/build/outputs/apk/release/app-release.apk`

## 📲 Instalar no Android

### Via USB (ADB):

**Windows (Comando completo):**

```cmd
"%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" install app-debug.apk
```

**Linux/Mac:**

```bash
adb install app-debug.apk
```

**Ou use o script automático:** `android\instalar-apk.bat`

### Via Arquivo:

1. Copie o APK para o dispositivo Android
2. No Android, vá em **Configurações** → **Segurança**
3. Habilite **Fontes Desconhecidas** ou **Instalar apps desconhecidos**
4. Use um gerenciador de arquivos para localizar e instalar o APK

## 🔐 Configurar Keystore (Importante para Release)

### Criar arquivo `gradle.properties` local:

Crie o arquivo `android/gradle.properties` (ou edite o existente):

```properties
# Configurações do Keystore
MYAPP_UPLOAD_STORE_FILE=my-keystore.jks
MYAPP_UPLOAD_KEY_ALIAS=my-app-key
MYAPP_UPLOAD_STORE_PASSWORD=sua_senha_keystore
MYAPP_UPLOAD_KEY_PASSWORD=sua_senha_key
```

### Configurar `build.gradle`:

No arquivo `android/app/build.gradle`, adicione:

```gradle
android {
    ...
    signingConfigs {
        release {
            if (project.hasProperty('MYAPP_UPLOAD_STORE_FILE')) {
                storeFile file(MYAPP_UPLOAD_STORE_FILE)
                storePassword MYAPP_UPLOAD_STORE_PASSWORD
                keyAlias MYAPP_UPLOAD_KEY_ALIAS
                keyPassword MYAPP_UPLOAD_KEY_PASSWORD
            }
        }
    }
    buildTypes {
        release {
            ...
            signingConfig signingConfigs.release
        }
    }
}
```

## ⚠️ Pontos Importantes

1. **Debug APK**: Apenas para testes, não pode ser publicado na Play Store
2. **Release APK**: Para produção, precisa ser assinado
3. **Keystore**: Guarde bem! Você precisará dele para atualizações
4. **Permissões**: Certifique-se de que todas as permissões estão no `AndroidManifest.xml`
5. **Tamanho**: APKs podem ser grandes; considere usar AAB (Android App Bundle) para a Play Store

## 🚀 Comandos Rápidos

```bash
# Sequência completa para APK debug
npm run build
npx cap sync
cd android
./gradlew assembleDebug

# Instalar no dispositivo conectado (Windows)
"%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" install app/build/outputs/apk/debug/app-debug.apk

# Instalar no dispositivo conectado (Linux/Mac)
adb install app/build/outputs/apk/debug/app-debug.apk
```

## 🔍 Verificar APK

```bash
# Ver informações do APK
aapt dump badging app-debug.apk

# Ver tamanho do APK
ls -lh app-debug.apk
```

## 📱 Testar Funcionalidades

Após instalar, teste especialmente:

- ✅ Câmera (precisa de dispositivo real)
- ✅ GPS/Localização
- ✅ Vibração
- ✅ Informações do dispositivo
- ✅ Status da bateria
- ✅ Conectividade de rede

## 🆘 Solução de Problemas

### Erro de Permissões:

- Verifique `AndroidManifest.xml`
- Teste em dispositivo real (não emulador)

### Erro de Build:

- Limpe o projeto: `./gradlew clean`
- Sincronize novamente: `npx cap sync`

### APK muito grande:

- Use `./gradlew assembleRelease` (minificado)
- Considere Android App Bundle (AAB)

---

🎉 **Pronto!** Agora você pode gerar e instalar seu APK Android!
