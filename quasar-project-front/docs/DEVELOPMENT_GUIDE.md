# 🚀 Guia Completo de Desenvolvimento - Quasar Android App

## 📋 Pré-requisitos

### Software Necessário

- ✅ **Node.js** v16+ ([Download](https://nodejs.org/))
- ✅ **Java JDK** 11+ ([Download](https://adoptium.net/))
- ✅ **Android Studio** ([Download](https://developer.android.com/studio))
- ✅ **Git** ([Download](https://git-scm.com/))

### Instalação Global

```bash
# Quasar CLI
npm install -g @quasar/cli

# Capacitor CLI
npm install -g @capacitor/cli

# Verificar instalações
quasar --version
cap --version
```

## 🔧 Configuração Inicial

### 1. Clone e Instalação

```bash
git clone <repository-url>
cd quasar-project-front
npm install
```

### 2. Configuração Android Studio

```bash
# Abrir Android Studio
# Tools > SDK Manager
# Instalar Android SDK (API 33+)
# Tools > AVD Manager (criar emulador)
```

### 3. Variáveis de Ambiente

```bash
# Windows - Adicionar ao PATH:
ANDROID_HOME=C:\Users\{username}\AppData\Local\Android\Sdk
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-11.0.x

# Verificar
echo $ANDROID_HOME
echo $JAVA_HOME
```

## 🏗️ Estrutura do Projeto

```
quasar-project-front/
├── 📁 src/
│   ├── 📁 components/       # Componentes Vue
│   ├── 📁 layouts/          # Layouts principais
│   ├── 📁 pages/            # Páginas da aplicação
│   │   └── 📄 AndroidTestPage.vue  # Página de testes
│   ├── 📁 plugins/          # Plugins personalizados
│   │   └── 📄 flashlight.js # Plugin do flashlight
│   ├── 📁 router/           # Configuração de rotas
│   ├── 📁 boot/             # Inicialização
│   └── 📁 css/              # Estilos globais
├── 📁 android/              # Projeto Android nativo
│   ├── 📁 app/src/main/
│   │   ├── 📄 AndroidManifest.xml
│   │   └── 📁 java/         # Código nativo
│   └── 📄 build.gradle
├── 📁 public/               # Assets estáticos
├── 📄 capacitor.config.json # Configuração Capacitor
├── 📄 quasar.config.js      # Configuração Quasar
└── 📄 package.json          # Dependências
```

## 🔄 Workflow de Desenvolvimento

### Desenvolvimento Web (Rápido)

```bash
# 1. Iniciar servidor local
npm run dev
# ou
quasar dev

# 2. Abrir http://localhost:9000
# 3. Testar funcionalidades básicas
```

### Desenvolvimento Android

#### Primeiro Setup

```bash
# 1. Adicionar plataforma Android (apenas primeira vez)
npm run android:add

# 2. Build inicial
npm run build

# 3. Sincronizar
npm run android:sync
```

#### Desenvolvimento Diário

```bash
# 1. Fazer alterações no código
# 2. Build e sync automaticamente
npm run android:build

# 3. Testar no dispositivo/emulador
npm run android:run

# 4. OU usar live reload (recomendado)
npm run android:run-live
```

### Live Reload (Desenvolvimento Ágil)

```bash
# Melhor experiência de desenvolvimento
npm run android:run-live

# O que acontece:
# - App abre no dispositivo
# - Mudanças no código são refletidas automaticamente
# - Não precisa rebuild manual
```

## 📱 Teste no Dispositivo

### Configurar Dispositivo Físico

```bash
# 1. Habilitar "Opções do desenvolvedor"
# 2. Habilitar "Depuração USB"
# 3. Conectar cabo USB
# 4. Verificar conexão
adb devices

# 5. Rodar no dispositivo
npm run android:run
```

### Usar Emulador

```bash
# 1. Abrir Android Studio
# 2. Tools > AVD Manager
# 3. Create Virtual Device
# 4. Iniciar emulador
# 5. Rodar aplicação
npm run android:run
```

## 🔍 Debug e Logs

### Logs do Capacitor

```bash
# Ver todos os logs
adb logcat

# Filtrar por app
adb logcat | grep "Capacitor"

# Logs específicos
adb logcat | grep "AndroidTestApp"
```

### Debug no Chrome

```bash
# 1. Executar app no dispositivo
npm run android:run-live

# 2. Abrir Chrome
# 3. Ir para: chrome://inspect
# 4. Selecionar o dispositivo
# 5. Usar DevTools normalmente
```

### Logs JavaScript

```javascript
// No código Vue/JS
console.log('Debug info:', data)
console.error('Error:', error)

// Visualizar no Chrome DevTools
// ou no terminal com adb logcat
```

## 🛠️ Scripts Úteis

### Build e Deploy

```bash
# Build completo
npm run android:build

# Apenas copiar assets
npm run android:copy

# Apenas sincronizar
npm run android:sync

# Limpar cache Android
npm run android:clean
```

### Desenvolvimento

```bash
# Lint código
npm run lint

# Formatar código
npm run format

# Verificar dependências
npm audit

# Atualizar Capacitor
npm run capacitor:update
```

## 📊 Funcionalidades Testadas

### ✅ Implementadas e Funcionando

- **Câmera**: Captura de fotos com alta qualidade
- **GPS**: Localização com alta precisão
- **Vibração**: Padrões de haptic feedback
- **Device Info**: Informações completas do dispositivo
- **Network**: Status de conectividade
- **Bateria**: Nível e status de carregamento
- **Storage**: Sistema de arquivos e cache
- **Preferences**: Armazenamento de configurações

### 🔄 Em Desenvolvimento

- **Flashlight**: Plugin personalizado (simulado/funcional)
- **Contatos**: Acesso simulado aos contatos
- **Audio**: Testes de permissões de áudio

## 🔐 Permissões Android

### Configuradas no AndroidManifest.xml

```xml
<!-- Essenciais -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Câmera e Flash -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.FLASHLIGHT" />

<!-- Localização -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- E muitas outras... (ver AndroidManifest.xml)
```

### Como Adicionar Nova Permissão

1. Editar `android/app/src/main/AndroidManifest.xml`
2. Adicionar `<uses-permission android:name="..." />`
3. Executar `npm run android:sync`
4. Testar no dispositivo

## 🚨 Troubleshooting

### Problemas Comuns

**❌ "Command failed: npx cap sync"**

```bash
# Solução:
rm -rf node_modules
npm install
npm run android:sync
```

**❌ "ANDROID_HOME not set"**

```bash
# Windows
set ANDROID_HOME=C:\Users\{user}\AppData\Local\Android\Sdk

# Linux/Mac
export ANDROID_HOME=~/Android/Sdk
```

**❌ "Device not found"**

```bash
# Verificar conexão
adb devices

# Reiniciar ADB
adb kill-server
adb start-server
```

**❌ "Build failed"**

```bash
# Limpar e reconstruir
npm run android:clean
npm run android:build
```

**❌ "Flashlight não funciona"**

- ✅ Testar em dispositivo real (não emulador)
- ✅ Verificar permissões no AndroidManifest.xml
- ✅ Verificar se dispositivo tem flash

### Dicas de Performance

1. **Use Live Reload** para desenvolvimento rápido
2. **Cache do Build** - não delete node_modules desnecessariamente
3. **Teste Incremental** - teste pequenas mudanças frequentemente
4. **Debug Remoto** - use Chrome DevTools para debug
5. **Logs Específicos** - filtre logs por relevância

## 📚 Recursos e Documentação

- 📖 [Quasar Framework](https://quasar.dev/)
- 📖 [Capacitor Docs](https://capacitorjs.com/)
- 📖 [Android Developer Guide](https://developer.android.com/)
- 📖 [PrimeVue Components](https://primevue.org/)
- 📖 [Vue 3 Composition API](https://vuejs.org/)

## 🎯 Próximos Passos

1. **Implementar Plugin Nativo** do flashlight
2. **Adicionar Testes Automatizados**
3. **Configurar CI/CD** para builds
4. **Otimizar Performance** da aplicação
5. **Adicionar Mais Funcionalidades** Android

---

**Happy Coding! 🚀**
