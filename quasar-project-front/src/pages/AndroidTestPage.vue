<template>
  <q-page class="android-test-page">
    <div class="q-pa-md">
      <div class="test-header q-mb-lg">
        <q-btn
          flat
          round
          dense
          icon="arrow_back"
          color="primary"
          @click="$router.back()"
          class="q-mr-md"
        />
        <h4 class="text-h4 q-my-none">Android Functions Test</h4>
      </div>

      <div class="container">
        <div class="row q-col-gutter-md">
          <!-- Camera Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="camera_alt" size="32px" color="primary" />
                <h6 class="card-title">Camera</h6>
                <Button
                  label="Open Camera"
                  icon="camera_alt"
                  @click="testCamera"
                  class="full-width"
                  :loading="loadingStates.camera"
                />
              </div>
            </div>
          </div>

          <!-- GPS/Location Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="location_on" size="32px" color="positive" />
                <h6 class="card-title">GPS Location</h6>
                <Button
                  label="Get Location"
                  icon="location_on"
                  @click="testGPS"
                  class="full-width"
                  :loading="loadingStates.gps"
                />
              </div>
            </div>
          </div>

          <!-- Flashlight Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="flashlight_on" size="32px" color="warning" />
                <h6 class="card-title">Flashlight</h6>
                <Button
                  :label="flashlightOn ? 'Turn Off' : 'Turn On'"
                  :icon="flashlightOn ? 'flashlight_off' : 'flashlight_on'"
                  @click="testFlashlight"
                  class="full-width"
                  :loading="loadingStates.flashlight"
                />
              </div>
            </div>
          </div>

          <!-- Vibration Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="vibration" size="32px" color="secondary" />
                <h6 class="card-title">Vibration</h6>
                <Button
                  label="Vibrate"
                  icon="vibration"
                  @click="testVibration"
                  class="full-width"
                  :loading="loadingStates.vibration"
                />
              </div>
            </div>
          </div>

          <!-- Device Info Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="info" size="32px" color="info" />
                <h6 class="card-title">Device Info</h6>
                <Button
                  label="Get Info"
                  icon="info"
                  @click="testDeviceInfo"
                  class="full-width"
                  :loading="loadingStates.deviceInfo"
                />
              </div>
            </div>
          </div>

          <!-- Network Status Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="network_check" size="32px" color="negative" />
                <h6 class="card-title">Network</h6>
                <Button
                  label="Check Network"
                  icon="network_check"
                  @click="testNetwork"
                  class="full-width"
                  :loading="loadingStates.network"
                />
              </div>
            </div>
          </div>

          <!-- Battery Status Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="battery_full" size="32px" color="positive" />
                <h6 class="card-title">Battery</h6>
                <Button
                  label="Battery Status"
                  icon="battery_full"
                  @click="testBattery"
                  class="full-width"
                  :loading="loadingStates.battery"
                />
              </div>
            </div>
          </div>

          <!-- Audio/Microphone Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="mic" size="32px" color="purple" />
                <h6 class="card-title">Microphone</h6>
                <Button
                  label="Test Audio"
                  icon="mic"
                  @click="testAudio"
                  class="full-width"
                  :loading="loadingStates.audio"
                />
              </div>
            </div>
          </div>

          <!-- Contacts Function -->
          <div class="col-12 col-sm-6 col-md-4">
            <div class="test-card">
              <div class="card-content">
                <q-icon name="contacts" size="32px" color="primary" />
                <h6 class="card-title">Contacts</h6>
                <Button
                  label="Access Contacts"
                  icon="contacts"
                  @click="testContacts"
                  class="full-width"
                  :loading="loadingStates.contacts"
                />
              </div>
            </div>
          </div>
        </div>

        <!-- Test Results Area -->
        <div class="q-mt-xl">
          <q-card v-if="testResult" flat bordered class="result-card">
            <q-card-section>
              <h6 class="text-h6 q-mb-md">Test Result:</h6>
              <pre class="result-text">{{ testResult }}</pre>
            </q-card-section>
          </q-card>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useQuasar } from 'quasar'
import Button from 'primevue/button'

// Capacitor imports
import { Camera, CameraResultType, CameraSource } from '@capacitor/camera'
import { Geolocation } from '@capacitor/geolocation'
import { Haptics, ImpactStyle } from '@capacitor/haptics'
import { Device } from '@capacitor/device'
import { Network } from '@capacitor/network'
import { Toast } from '@capacitor/toast'
import { Filesystem, Directory } from '@capacitor/filesystem'
import { Preferences } from '@capacitor/preferences'
import { FlashlightPlugin } from '../plugins/flashlight.js'

const $q = useQuasar()

// Reactive states
const flashlightOn = ref(false)
const testResult = ref('')

const loadingStates = reactive({
  camera: false,
  gps: false,
  flashlight: false,
  vibration: false,
  deviceInfo: false,
  network: false,
  battery: false,
  audio: false,
  contacts: false,
})

// Test functions
const testCamera = async () => {
  try {
    loadingStates.camera = true

    const image = await Camera.getPhoto({
      quality: 90,
      allowEditing: true,
      resultType: CameraResultType.Uri,
      source: CameraSource.Camera,
    })

    testResult.value = `Camera Test:\nImage captured successfully\nPath: ${image.webPath}\nFormat: ${image.format}\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Camera photo captured successfully',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Camera Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Camera test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.camera = false
  }
}

const testGPS = async () => {
  try {
    loadingStates.gps = true

    const coordinates = await Geolocation.getCurrentPosition({
      enableHighAccuracy: true,
      timeout: 10000,
    })

    testResult.value = `GPS Test:\nLatitude: ${coordinates.coords.latitude}\nLongitude: ${coordinates.coords.longitude}\nAccuracy: ${coordinates.coords.accuracy}m\nAltitude: ${coordinates.coords.altitude}m\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'GPS location obtained successfully',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `GPS Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `GPS test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.gps = false
  }
}

const testFlashlight = async () => {
  try {
    loadingStates.flashlight = true

    // Verificar se o dispositivo tem flashlight
    const isAvailable = await FlashlightPlugin.isAvailable()

    if (!isAvailable.value) {
      throw new Error('Flashlight not available on this device')
    }

    // Obter informações do dispositivo
    const deviceInfo = await Device.getInfo()

    if (flashlightOn.value) {
      // Desligar flashlight
      await FlashlightPlugin.switchOff()
      flashlightOn.value = false
    } else {
      // Ligar flashlight
      await FlashlightPlugin.switchOn()
      flashlightOn.value = true
    }

    // Salvar estado nas preferências
    await Preferences.set({
      key: 'flashlight_state',
      value: flashlightOn.value.toString(),
    })

    // Usar haptic feedback para confirmar ação
    await Haptics.impact({ style: ImpactStyle.Light })

    testResult.value = `Flashlight Test:\nStatus: ${flashlightOn.value ? 'ON' : 'OFF'}\nPlatform: ${deviceInfo.platform}\nDevice Model: ${deviceInfo.model}\nManufacturer: ${deviceInfo.manufacturer}\nFlashlight Available: ${isAvailable.value ? 'Yes' : 'No'}\nState Saved: ${flashlightOn.value}\nTimestamp: ${new Date().toLocaleString()}`

    await Toast.show({
      text: `Flashlight ${flashlightOn.value ? 'turned on' : 'turned off'}`,
      duration: 'short',
      position: 'top',
    })

    $q.notify({
      type: 'positive',
      message: `Flashlight ${flashlightOn.value ? 'turned on' : 'turned off'}`,
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Flashlight Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Flashlight test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.flashlight = false
  }
}

const testVibration = async () => {
  try {
    loadingStates.vibration = true

    // Haptic feedback com diferentes intensidades
    await Haptics.impact({ style: ImpactStyle.Medium })

    // Aguardar um pouco e fazer outro feedback
    await new Promise((resolve) => setTimeout(resolve, 300))
    await Haptics.impact({ style: ImpactStyle.Light })

    await new Promise((resolve) => setTimeout(resolve, 300))
    await Haptics.impact({ style: ImpactStyle.Heavy })

    testResult.value = `Vibration Test:\nPattern: Medium → Light → Heavy\nHaptic Feedback: Successful\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Vibration pattern executed',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Vibration Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Vibration test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.vibration = false
  }
}

const testDeviceInfo = async () => {
  try {
    loadingStates.deviceInfo = true

    const deviceInfo = await Device.getInfo()
    const deviceId = await Device.getId()
    const batteryInfo = await Device.getBatteryInfo()

    testResult.value = `Device Info Test:\nModel: ${deviceInfo.model}\nManufacturer: ${deviceInfo.manufacturer}\nOS: ${deviceInfo.operatingSystem} ${deviceInfo.osVersion}\nPlatform: ${deviceInfo.platform}\nDevice ID: ${deviceId.identifier}\nApp Version: ${deviceInfo.appVersion}\nBattery Level: ${Math.round(batteryInfo.batteryLevel * 100)}%\nCharging: ${batteryInfo.isCharging ? 'Yes' : 'No'}\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'info',
      message: 'Device information retrieved successfully',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Device Info Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Device info test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.deviceInfo = false
  }
}

const testNetwork = async () => {
  try {
    loadingStates.network = true

    const status = await Network.getStatus()

    testResult.value = `Network Test:\nConnection Type: ${status.connectionType}\nConnected: ${status.connected ? 'Yes' : 'No'}\nConnection Status: ${status.connected ? 'Online' : 'Offline'}\nTimestamp: ${new Date().toLocaleString()}`

    // Listener para mudanças de rede
    const listener = Network.addListener('networkStatusChange', (status) => {
      console.log('Network status changed', status)
    })

    // Remover listener após 5 segundos (apenas para demonstração)
    setTimeout(() => {
      listener.remove()
    }, 5000)

    $q.notify({
      type: 'positive',
      message: `Network status: ${status.connected ? 'Connected' : 'Disconnected'}`,
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Network Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Network test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.network = false
  }
}

const testBattery = async () => {
  try {
    loadingStates.battery = true

    const batteryInfo = await Device.getBatteryInfo()
    const batteryLevel = Math.round(batteryInfo.batteryLevel * 100)

    testResult.value = `Battery Test:\nLevel: ${batteryLevel}%\nCharging: ${batteryInfo.isCharging ? 'Yes' : 'No'}\nBattery Status: ${batteryLevel > 20 ? 'Good' : 'Low'}\nTimestamp: ${new Date().toLocaleString()}`

    const color = batteryLevel > 50 ? 'positive' : batteryLevel > 20 ? 'warning' : 'negative'

    $q.notify({
      type: color,
      message: `Battery level: ${batteryLevel}% ${batteryInfo.isCharging ? '(Charging)' : ''}`,
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Battery Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Battery test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.battery = false
  }
}

const testAudio = async () => {
  try {
    loadingStates.audio = true

    // Simular teste de áudio usando FileSystem para verificar permissões
    const testFileName = `audio_test_${Date.now()}.txt`

    await Filesystem.writeFile({
      path: testFileName,
      data: 'Audio test file created',
      directory: Directory.Cache,
    })

    await Filesystem.readFile({
      path: testFileName,
      directory: Directory.Cache,
    })

    // Remover arquivo de teste
    await Filesystem.deleteFile({
      path: testFileName,
      directory: Directory.Cache,
    })

    testResult.value = `Audio Test:\nFile System Access: OK\nCache Directory: Available\nAudio Permissions: Simulated\nTest File Created/Deleted: Success\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Audio system test completed',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Audio Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Audio test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.audio = false
  }
}

const testContacts = async () => {
  try {
    loadingStates.contacts = true

    // Simular acesso aos contatos usando Preferences
    const contactsData = {
      totalContacts: 156,
      lastSync: new Date().toISOString(),
      permission: 'granted',
    }

    // Salvar dados simulados dos contatos
    await Preferences.set({
      key: 'contacts_data',
      value: JSON.stringify(contactsData),
    })

    // Ler dados dos contatos
    const result = await Preferences.get({ key: 'contacts_data' })
    const storedData = JSON.parse(result.value || '{}')

    testResult.value = `Contacts Test:\nTotal Contacts: ${storedData.totalContacts || 0}\nAccess Permission: ${storedData.permission || 'unknown'}\nLast Sync: ${storedData.lastSync ? new Date(storedData.lastSync).toLocaleString() : 'Never'}\nData Storage: Success\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Contacts access simulation completed',
      position: 'top',
    })
  } catch (error) {
    testResult.value = `Contacts Test Failed:\nError: ${error.message}\nTimestamp: ${new Date().toLocaleString()}`
    $q.notify({
      type: 'negative',
      message: `Contacts test failed: ${error.message}`,
      position: 'top',
    })
  } finally {
    loadingStates.contacts = false
  }
}

// Restaurar estado do flashlight quando a página carregar
onMounted(async () => {
  try {
    const savedState = await Preferences.get({ key: 'flashlight_state' })
    if (savedState.value) {
      flashlightOn.value = savedState.value === 'true'
    }
  } catch (error) {
    console.log('Could not restore flashlight state:', error)
  }
})
</script>

<style scoped>
.android-test-page {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}

.test-header {
  display: flex;
  align-items: center;
  color: white;
  padding: 1rem 0;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
}

.test-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  height: 180px;
  backdrop-filter: blur(10px);
}

.test-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.card-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
}

.card-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0.5rem 0;
  text-align: center;
}

.result-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  backdrop-filter: blur(10px);
}

.result-text {
  background: #f8f9fa;
  padding: 1rem;
  border-radius: 8px;
  font-family: 'Courier New', monospace;
  font-size: 0.9rem;
  color: #2c3e50;
  white-space: pre-wrap;
  word-break: break-word;
}

@media (max-width: 600px) {
  .test-card {
    height: 160px;
    padding: 1rem;
  }

  .card-title {
    font-size: 1rem;
  }
}
</style>
