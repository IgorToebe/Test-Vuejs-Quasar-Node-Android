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
import { ref, reactive } from 'vue'
import { useQuasar } from 'quasar'
import Button from 'primevue/button'

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

// Helper function to simulate API calls
const simulateApiCall = async (functionName, duration = 1500) => {
  loadingStates[functionName] = true
  await new Promise((resolve) => setTimeout(resolve, duration))
  loadingStates[functionName] = false
}

// Test functions
const testCamera = async () => {
  try {
    await simulateApiCall('camera')
    testResult.value = `Camera Test:\nCamera access requested\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Camera access simulated successfully',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Camera test failed',
      position: 'top',
    })
  }
}

const testGPS = async () => {
  try {
    await simulateApiCall('gps', 2000)
    testResult.value = `GPS Test:\nLocation: -23.5505, -46.6333 (São Paulo)\nAccuracy: 10m\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'GPS location obtained',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'GPS test failed',
      position: 'top',
    })
  }
}

const testFlashlight = async () => {
  try {
    await simulateApiCall('flashlight', 500)
    flashlightOn.value = !flashlightOn.value
    testResult.value = `Flashlight Test:\nStatus: ${flashlightOn.value ? 'ON' : 'OFF'}\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'info',
      message: `Flashlight ${flashlightOn.value ? 'turned on' : 'turned off'}`,
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Flashlight test failed',
      position: 'top',
    })
  }
}

const testVibration = async () => {
  try {
    await simulateApiCall('vibration', 1000)
    testResult.value = `Vibration Test:\nPattern: Short buzz (200ms)\nIntensity: Medium\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Vibration triggered',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Vibration test failed',
      position: 'top',
    })
  }
}

const testDeviceInfo = async () => {
  try {
    await simulateApiCall('deviceInfo')
    testResult.value = `Device Info Test:\nModel: Samsung Galaxy S21\nOS: Android 12\nApp Version: 1.0.0\nMemory: 8GB RAM\nStorage: 128GB\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'info',
      message: 'Device information retrieved',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Device info test failed',
      position: 'top',
    })
  }
}

const testNetwork = async () => {
  try {
    await simulateApiCall('network')
    testResult.value = `Network Test:\nConnection: WiFi\nSpeed: 50 Mbps\nSignal: Strong\nProvider: Vivo\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Network status checked',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Network test failed',
      position: 'top',
    })
  }
}

const testBattery = async () => {
  try {
    await simulateApiCall('battery')
    const batteryLevel = Math.floor(Math.random() * 100) + 1
    testResult.value = `Battery Test:\nLevel: ${batteryLevel}%\nCharging: ${batteryLevel < 50 ? 'Yes' : 'No'}\nHealth: Good\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'info',
      message: `Battery level: ${batteryLevel}%`,
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Battery test failed',
      position: 'top',
    })
  }
}

const testAudio = async () => {
  try {
    await simulateApiCall('audio')
    testResult.value = `Audio Test:\nMicrophone: Available\nSpeakers: Working\nVolume: 75%\nAudio Quality: High\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Audio system tested',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Audio test failed',
      position: 'top',
    })
  }
}

const testContacts = async () => {
  try {
    await simulateApiCall('contacts')
    testResult.value = `Contacts Test:\nTotal Contacts: 156\nAccess Granted: Yes\nSync Status: Updated\nTimestamp: ${new Date().toLocaleString()}`

    $q.notify({
      type: 'positive',
      message: 'Contacts access granted',
      position: 'top',
    })
  } catch {
    $q.notify({
      type: 'negative',
      message: 'Contacts test failed',
      position: 'top',
    })
  }
}
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
