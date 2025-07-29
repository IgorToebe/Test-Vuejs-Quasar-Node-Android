<template>
  <q-page class="q-pa-md full-height">
    <div class="container row justify-center">
      <div class="col-12 col-md-10">
        <div class="row items-start q-col-gutter-md">
          <div class="col-12 col-sm-6 col-md-4">
            <div
              class="mk_card"
              @click="goTickets()"
              @keyup.enter="goTickets()"
              tabindex="0"
              role="button"
              aria-label="Navigate to Tickets page"
            >
              <div class="card-content">
                <q-icon name="confirmation_number" size="48px" color="primary" />
                <h3 class="card-title">Tickets</h3>
              </div>
            </div>
          </div>

          <div class="col-12 col-sm-6 col-md-4">
            <div
              class="mk_card"
              @click="goTestScreen()"
              @keyup.enter="goTestScreen()"
              tabindex="0"
              role="button"
              aria-label="Navigate to Android Test Functions"
            >
              <div class="card-content">
                <q-icon name="android" size="48px" color="positive" />
                <h3 class="card-title">Android Tests</h3>
              </div>
            </div>
          </div>

          <div class="col-12 col-sm-6 col-md-4">
            <div
              class="mk_card"
              @click="goExtras()"
              @keyup.enter="goExtras()"
              tabindex="0"
              role="button"
              aria-label="Explore Extras"
            >
              <div class="card-content">
                <q-icon name="extension" size="48px" color="secondary" />
                <h3 class="card-title">Extras</h3>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useQuasar } from 'quasar'

const router = useRouter()
const $q = useQuasar()

const goTickets = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de Tickets em desenvolvimento',
    position: 'top',
  })
}

const goTestScreen = () => {
  router.push('/android-tests')
}

const goExtras = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de Extras em desenvolvimento',
    position: 'top',
  })
}
</script>

<style scoped>
.full-height {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

.container {
  max-width: 1200px;
  width: 100%;
}

.mk_card {
  transition: all 0.3s ease;
  border-radius: 16px;
  background: #ffffff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  padding: 2rem;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid transparent;
}

.mk_card:hover {
  transform: translateY(-8px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
  border-color: var(--q-primary);
}

.mk_card:focus {
  outline: 2px solid #1976d2;
  outline-offset: 2px;
}

.card-content {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
}

.card-title {
  font-family:
    'Inter',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    sans-serif;
  font-size: 1.5rem;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
  transition: transform 0.2s ease;
}

.mk_card:hover .card-title {
  transform: scale(1.05);
}

@media (max-width: 600px) {
  .mk_card {
    height: 160px;
    padding: 1.5rem;
  }

  .card-title {
    font-size: 1.25rem;
  }
}
</style>
