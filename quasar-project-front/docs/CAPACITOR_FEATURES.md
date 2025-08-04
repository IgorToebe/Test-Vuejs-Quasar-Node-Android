# Funcionalidades Android com Capacitor

Este documento descreve as funcionalidades Android implementadas usando os plugins do Capacitor na página `AndroidTestPage.vue`.

## Plugins Capacitor Implementados

### 1. **Camera** (@capacitor/camera)

- **Funcionalidade**: Captura de fotos usando a câmera do dispositivo
- **Implementação**: `testCamera()` - Abre a câmera e captura uma foto
- **Permissões necessárias**: `CAMERA`
- **Recursos**: Qualidade configurável, edição permitida, fonte da câmera

### 2. **Geolocation** (@capacitor/geolocation)

- **Funcionalidade**: Obtenção da localização GPS atual
- **Implementação**: `testGPS()` - Obtém coordenadas de latitude/longitude
- **Permissões necessárias**: `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`
- **Recursos**: Alta precisão, altitude, accuracy

### 3. **Haptics** (@capacitor/haptics)

- **Funcionalidade**: Feedback tátil/vibração
- **Implementação**: `testVibration()` - Executa padrão de vibração
- **Permissões necessárias**: `VIBRATE`
- **Recursos**: Diferentes intensidades (Light, Medium, Heavy)

### 4. **Device** (@capacitor/device)

- **Funcionalidade**: Informações do dispositivo e bateria
- **Implementação**: `testDeviceInfo()` e `testBattery()`
- **Informações**: Modelo, fabricante, OS, versão, ID do dispositivo, nível da bateria
- **Recursos**: Status de carregamento, informações detalhadas do hardware

### 5. **Network** (@capacitor/network)

- **Funcionalidade**: Status da conexão de rede
- **Implementação**: `testNetwork()` - Verifica status da conexão
- **Permissões necessárias**: `ACCESS_NETWORK_STATE`
- **Recursos**: Tipo de conexão, status online/offline, listener para mudanças

### 6. **Toast** (@capacitor/toast)

- **Funcionalidade**: Mensagens toast nativas
- **Implementação**: Usado em `testFlashlight()`
- **Recursos**: Posicionamento configurável, duração

### 7. **Filesystem** (@capacitor/filesystem)

- **Funcionalidade**: Acesso ao sistema de arquivos
- **Implementação**: `testAudio()` - Cria, lê e deleta arquivos de teste
- **Permissões necessárias**: `WRITE_EXTERNAL_STORAGE`, `READ_EXTERNAL_STORAGE`
- **Recursos**: Diferentes diretórios (Cache, Documents, etc.)

### 8. **Preferences** (@capacitor/preferences)

- **Funcionalidade**: Armazenamento de preferências locais
- **Implementação**: `testFlashlight()` e `testContacts()`
- **Recursos**: Armazenamento chave-valor persistente

## Permissões Android

As seguintes permissões foram adicionadas ao `AndroidManifest.xml`:

```xml
<!-- Permissões básicas -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.FLASHLIGHT" />

<!-- Features de hardware -->
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
<uses-feature android:name="android.hardware.location" android:required="false" />
<uses-feature android:name="android.hardware.location.gps" android:required="false" />
<uses-feature android:name="android.hardware.camera.flash" android:required="false" />
```

## Como Usar

1. **Build do projeto**:

   ```bash
   npm run build
   ```

2. **Sincronizar com Capacitor**:

   ```bash
   npx cap sync
   ```

3. **Abrir no Android Studio**:

   ```bash
   npx cap open android
   ```

4. **Testar no dispositivo**: Execute o app em um dispositivo Android real para testar todas as funcionalidades.

## Notas Importantes

- **Dispositivo Real**: Muitas funcionalidades (câmera, GPS, vibração) só funcionam em dispositivos reais, não em emuladores.
- **Permissões Runtime**: No Android 6.0+, algumas permissões precisam ser solicitadas em tempo de execução.
- **Flashlight**: Não há plugin oficial do Capacitor para flashlight. A implementação atual simula a funcionalidade.
- **Contatos**: A implementação atual simula acesso aos contatos usando Preferences.

## Funcionalidades Simuladas vs Reais

| Funcionalidade             | Status      | Plugin                 |
| -------------------------- | ----------- | ---------------------- |
| Câmera                     | ✅ Real     | @capacitor/camera      |
| GPS/Localização            | ✅ Real     | @capacitor/geolocation |
| Vibração                   | ✅ Real     | @capacitor/haptics     |
| Informações do Dispositivo | ✅ Real     | @capacitor/device      |
| Status da Rede             | ✅ Real     | @capacitor/network     |
| Bateria                    | ✅ Real     | @capacitor/device      |
| Sistema de Arquivos        | ✅ Real     | @capacitor/filesystem  |
| Toast Nativo               | ✅ Real     | @capacitor/toast       |
| Flashlight                 | ⚠️ Simulado | -                      |
| Contatos                   | ⚠️ Simulado | -                      |
| Áudio/Microfone            | ⚠️ Simulado | -                      |

## Melhorias Futuras

1. **Flashlight**: Implementar plugin da comunidade ou código nativo
2. **Contatos**: Implementar plugin da comunidade para acesso real aos contatos
3. **Áudio**: Implementar gravação de áudio real
4. **Push Notifications**: Adicionar suporte a notificações push
5. **Biometria**: Adicionar autenticação biométrica
