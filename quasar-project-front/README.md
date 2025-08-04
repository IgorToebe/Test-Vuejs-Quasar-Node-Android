# Quasar Android Test App

Uma aplicação Quasar + Capacitor para testar funcionalidades Android como câmera, GPS, flashlight, vibração, e outras APIs nativas.

## � Estrutura do Projeto

```
quasar-project-front/
├── src/                    # Código fonte Vue.js
├── public/                 # Recursos públicos
├── android/               # Projeto Android gerado
├── src-capacitor/         # Configuração Capacitor
├── docs/                  # 📚 Documentação completa
├── scripts/               # 🔧 Scripts de desenvolvimento
└── README.md              # Este arquivo
```

## 📚 Documentação Completa

Toda a documentação detalhada foi organizada na pasta `docs/`:

- **[docs/README.md](docs/README.md)** - Índice completo da documentação
- **[docs/DEVELOPMENT_GUIDE.md](docs/DEVELOPMENT_GUIDE.md)** - Guia completo de desenvolvimento
- **[docs/CONFIGURAR_ANDROID.md](docs/CONFIGURAR_ANDROID.md)** - Configuração do ambiente
- **[docs/EXECUTAR_ANDROID_STUDIO.md](docs/EXECUTAR_ANDROID_STUDIO.md)** - Como executar no Android Studio

## �📱 Funcionalidades Testadas

- ✅ **Câmera**: Captura de fotos com configurações avançadas
- ✅ **GPS/Localização**: Obtenção de coordenadas com alta precisão
- ✅ **Flashlight**: Controle da lanterna do dispositivo
- ✅ **Vibração**: Padrões de haptic feedback
- ✅ **Informações do Dispositivo**: Modelo, fabricante, OS, bateria
- ✅ **Status da Rede**: Verificação de conectividade
- ✅ **Bateria**: Nível e status de carregamento
- ✅ **Sistema de Arquivos**: Teste de permissões de escrita/leitura
- ✅ **Contatos**: Simulação de acesso aos contatos

## 🚀 Configuração Inicial

### Pré-requisitos

- Node.js (v16+)
- Android Studio
- Java JDK 11+
- Quasar CLI

### Instalação das Dependências

```bash
# Instalar dependências do projeto
npm install

# Instalar Quasar CLI globalmente (se não tiver)
npm install -g @quasar/cli

# Instalar Capacitor CLI globalmente (se não tiver)
npm install -g @capacitor/cli
```

### Dependências do Projeto

```bash
# Dependências Capacitor
npm install @capacitor/android
npm install @capacitor/camera
npm install @capacitor/device
npm install @capacitor/filesystem
npm install @capacitor/geolocation
npm install @capacitor/haptics
npm install @capacitor/network
npm install @capacitor/preferences
npm install @capacitor/toast

# Dependências UI
npm install primevue
npm install @primevue/themes
npm install primeicons
```

## 🔧 Comandos de Desenvolvimento

### ⚠️ IMPORTANTE: Diferença entre Web e Android

**🌐 Para desenvolvimento WEB (navegador):**

```bash
quasar dev    # Abre no navegador - http://localhost:9000
```

**📱 Para desenvolvimento ANDROID (APK no dispositivo):**

```bash
npm run build              # 1. Build da aplicação
npx cap sync android       # 2. Sincronizar com Android
npx cap run android        # 3. Instalar APK no dispositivo
```

### Desenvolvimento Web

```bash
# Iniciar servidor de desenvolvimento
quasar dev

# Build para produção web
quasar build
```

### Desenvolvimento Android

```bash
# Adicionar plataforma Android (primeira vez)
npx cap add android

# Sincronizar código web com Android
npx cap sync

# Copiar assets para Android
npx cap copy android

# Abrir projeto no Android Studio
npx cap open android

# Build e rodar no dispositivo/emulador
npx cap run android

# Build no modo live reload
npx cap run android --live-reload
```

### Comandos de Build

```bash
# Build da aplicação web
npm run build

# Build completo e sync
npm run build && npx cap sync
```

### Ferramentas de Desenvolvimento

```bash
# Lint do código
npm run lint

# Formatação do código
npm run format

# Verificar dependências
npm audit

# Limpar cache
npm run clean
```

## 📱 Desenvolvimento Android

### Configuração do Android Studio

1. Instalar Android Studio
2. Configurar Android SDK (API 33+)
3. Configurar emulador ou conectar dispositivo físico
4. Habilitar modo desenvolvedor no dispositivo

### Comandos ADB (Debug)

```bash
# Verificar dispositivos conectados
adb devices

# Instalar APK manualmente
adb install app-debug.apk

# Ver logs do aplicativo
adb logcat

# Fazer screenshot
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

### Build de Produção

```bash
# Build de produção
quasar build

# Sync com Android
npx cap sync android

# Build APK no Android Studio ou:
cd android && ./gradlew assembleRelease
```

## 🔐 Permissões Android

O arquivo `android/app/src/main/AndroidManifest.xml` já está configurado com as seguintes permissões:

```xml
<!-- Permissões Básicas -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Câmera e Flashlight -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.FLASHLIGHT" />

<!-- Localização -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- Vibração -->
<uses-permission android:name="android.permission.VIBRATE" />

<!-- Armazenamento -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

<!-- Contatos e Áudio -->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />

<!-- Recursos de Hardware -->
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
<uses-feature android:name="android.hardware.location" android:required="false" />
<uses-feature android:name="android.hardware.location.gps" android:required="false" />
<uses-feature android:name="android.hardware.camera.flash" android:required="false" />
```

## 🛠️ Arquitetura do Projeto

```
src/
├── components/          # Componentes Vue reutilizáveis
├── layouts/            # Layouts da aplicação
├── pages/              # Páginas da aplicação
│   └── AndroidTestPage.vue  # Página principal de testes
├── plugins/            # Plugins personalizados
│   └── flashlight.js   # Plugin personalizado do flashlight
├── router/             # Configuração das rotas
├── boot/               # Arquivos de inicialização
└── css/                # Estilos globais

android/                # Projeto Android nativo
├── app/src/main/
│   ├── AndroidManifest.xml  # Permissões e configurações
│   └── java/                # Código Java/Kotlin nativo
└── build.gradle            # Configurações de build
```

## 🔍 Testes e Debug

### Logs de Debug

```bash
# Ver logs do Capacitor
npx cap run android --live-reload

# Logs específicos do app
adb logcat | grep "Capacitor"

# Debug no Chrome DevTools
# Abrir chrome://inspect no navegador
```

### Testes das Funcionalidades

1. **Câmera**: Teste de captura e permissões
2. **GPS**: Teste de precisão e timeout
3. **Flashlight**: Controle liga/desliga
4. **Vibração**: Padrões de intensidade
5. **Device Info**: Informações completas do dispositivo
6. **Network**: Status de conectividade
7. **Bateria**: Nível e status de carregamento
8. **Storage**: Teste de escrita/leitura
9. **Contatos**: Simulação de acesso

## 📚 Recursos Úteis

- [Documentação Quasar](https://quasar.dev/)
- [Documentação Capacitor](https://capacitorjs.com/)
- [Capacitor Android Guide](https://capacitorjs.com/docs/android)
- [PrimeVue Components](https://primevue.org/)

## 🚨 Troubleshooting

### Problemas Comuns

**❌ "Não foi possível carregar a página web" / "Programa abrindo como página web":**

O app deve ser executado como APK no dispositivo Android, não como página web! Siga estes passos:

```bash
# 1. PARE qualquer servidor web que esteja rodando (Ctrl+C)
# 2. Fazer build para Android
npm run build

# 3. Sincronizar com Android
npx cap sync android

# 4. Executar no dispositivo/emulador (APK)
npx cap run android
```

**Erro de permissões:**

```bash
npx cap sync android
```

**Build falha:**

```bash
# Limpar cache
rm -rf node_modules
npm install
npx cap sync
```

**Problemas com Android Studio:**

```bash
# Reabrir projeto
npx cap open android
```

**Flashlight não funciona:**

- Verificar permissões no AndroidManifest.xml
- Testar em dispositivo físico (não funciona em emulador)
- Verificar se o dispositivo tem flash disponível

## 📄 Scripts Disponíveis

```json
{
  "dev": "quasar dev",
  "build": "quasar build",
  "lint": "eslint --fix",
  "format": "prettier --write",
  "android:sync": "npx cap sync android",
  "android:run": "npx cap run android",
  "android:open": "npx cap open android"
}
```

## 🔄 Workflow de Desenvolvimento

### 🌐 Desenvolvimento Web (Testes Básicos)

```bash
1. quasar dev               # Desenvolvimento no navegador
2. Testar UI e funcionalidades básicas
3. PARAR servidor (Ctrl+C) antes de ir para Android
```

### 📱 Desenvolvimento Android (APK Real)

```bash
1. npm run build           # Build da aplicação
2. npx cap sync android    # Sincronizar com Android
3. npx cap run android     # Instalar e executar APK
4. npx cap run android --live-reload  # Com live reload
```

### 🚨 NUNCA misture os dois modos!

- ❌ **ERRADO**: Tentar acessar funcionalidades Android no navegador
- ✅ **CORRETO**: Usar `npx cap run android` para APK no dispositivo

---

**Desenvolvido com Quasar Framework + Capacitor**
