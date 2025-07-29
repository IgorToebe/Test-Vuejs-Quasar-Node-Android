<template>
  <q-page class="flex flex-center login-page">
    <div class="login-container">
      <q-card class="login-card" flat bordered>
        <q-card-section class="text-center q-pb-none">
          <div class="logo-section">
            <q-icon name="business" size="64px" color="primary" />
            <h4 class="text-h4 q-mt-md q-mb-none">Desko™</h4>
            <p class="text-subtitle2 text-grey-6 q-mt-sm">Um app Makode.</p>
          </div>
        </q-card-section>

        <q-card-section class="q-pt-md">
          <q-form @submit.prevent="onSubmit" class="q-gutter-md">
            <q-input
              v-model="email"
              type="email"
              label="E-mail"
              outlined
              dense
              :rules="emailRules"
              autocomplete="email"
            >
              <template v-slot:prepend>
                <q-icon name="email" />
              </template>
            </q-input>

            <q-input
              v-model="password"
              :type="showPassword ? 'text' : 'password'"
              label="Senha"
              outlined
              dense
              :rules="passwordRules"
              autocomplete="current-password"
            >
              <template v-slot:prepend>
                <q-icon name="lock" />
              </template>
              <template v-slot:append>
                <q-icon
                  :name="showPassword ? 'visibility_off' : 'visibility'"
                  class="cursor-pointer"
                  @click="showPassword = !showPassword"
                />
              </template>
            </q-input>

            <div class="row justify-between items-center q-mt-sm">
              <q-checkbox v-model="rememberMe" label="Lembrar-me" color="primary" dense />
              <q-btn
                flat
                dense
                color="primary"
                label="Esqueci a senha"
                class="text-caption"
                @click="forgotPassword"
              />
            </div>

            <div class="q-mt-lg">
              <Button
                type="button"
                color="primary"
                label="Entrar"
                class="full-width bounce-btn"
                size="md"
                :loading="loading"
                @click="handleLogin"
              />
            </div>
          </q-form>
        </q-card-section>

        <q-card-section class="text-center q-pt-none">
          <q-separator class="q-mb-md" />
          <p class="text-caption text-grey-6">
            Não tem uma conta?
            <q-btn
              flat
              dense
              color="primary"
              label="Cadastre-se"
              class="text-caption q-pa-none"
              @click="register"
            />
          </p>
        </q-card-section>
      </q-card>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from 'vue'
import { useQuasar } from 'quasar'
import { useRouter } from 'vue-router'
import Button from 'primevue/button'

const $q = useQuasar()
const router = useRouter()

// Dados do formulário
const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const showPassword = ref(false)
const loading = ref(false)

// Regras de validação
const emailRules = [
  (val) => !!val || 'E-mail é obrigatório',
  (val) => /.+@.+\..+/.test(val) || 'E-mail deve ser válido',
]

const passwordRules = [
  (val) => !!val || 'Senha é obrigatória',
  (val) => val.length >= 6 || 'Senha deve ter pelo menos 6 caracteres',
]

// Métodos
const onSubmit = async () => {
  console.log('onSubmit chamado!')
  console.log('Email:', email.value)
  console.log('Password:', password.value)
  
  // Hard-coded credentials for testing
  const testEmail = 'igor.toebe@makode.com.br'
  const testPassword = '123456'

  loading.value = true

  try {
    // Simulate a brief loading for better UX
    await new Promise((resolve) => setTimeout(resolve, 1000))

    // Check credentials
    if (email.value === testEmail && password.value === testPassword) {
      console.log('Credenciais corretas - redirecionando...')
      
      $q.notify({
        type: 'positive',
        message: 'Login realizado com sucesso! Redirecionando...',
        position: 'top',
      })

      // Navigate to HomePage
      setTimeout(() => {
        router.push('/home')
      }, 1500)
    } else {
      console.log('Credenciais incorretas')
      
      $q.notify({
        type: 'negative',
        message: 'Credenciais inválidas. Use: igor.toebe@makode.com.br / 123456',
        position: 'top',
        timeout: 5000,
      })
    }
  } catch (error) {
    console.error('Erro no login:', error)
    
    $q.notify({
      type: 'negative',
      message: 'Erro ao fazer login. Tente novamente.',
      position: 'top',
    })
  } finally {
    loading.value = false
  }
}

const forgotPassword = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de recuperação de senha em desenvolvimento',
    position: 'top',
  })
}

const register = () => {
  $q.notify({
    type: 'info',
    message: 'Funcionalidade de cadastro em desenvolvimento',
    position: 'top',
  })
}

const handleLogin = async () => {
  // Adiciona a animação primeiro
  animateButton()
  
  // Depois chama a função de login
  await onSubmit()
}

const animateButton = () => {
  // Adiciona a classe de animação temporariamente
  const button = document.querySelector('.bounce-btn')
  if (button) {
    button.classList.add('animate-bounce')
    setTimeout(() => {
      button.classList.remove('animate-bounce')
    }, 600)
  }
}
</script>

<style scoped>
.login-page {
  background: linear-gradient(135deg, #91e995 0%, #4ba29e 100%);
  min-height: 100vh;
  padding: 20px;
}

.login-container {
  width: 100%;
  max-width: 400px;
}

.login-card {
  border-radius: 16px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(10px);
  background: rgba(255, 255, 255, 0.95);
}

.logo-section {
  padding: 20px 0;
}

.q-input {
  margin-bottom: 8px;
}

.q-btn {
  border-radius: 8px;
}

.q-btn.full-width {
  width: 100%;
  margin: 0 auto;
  display: block;
  transition: transform 0.2s ease;
}

.bounce-btn {
  transform-origin: center;
}

.animate-bounce {
  animation: bounce 0.6s ease-in-out;
}

@keyframes bounce {
  0%,
  20%,
  53%,
  80%,
  100% {
    transform: translate3d(0, 0, 0);
  }
  40%,
  43% {
    transform: translate3d(0, -15px, 0);
  }
  70% {
    transform: translate3d(0, -8px, 0);
  }
  90% {
    transform: translate3d(0, -3px, 0);
  }
}

.text-caption {
  font-size: 12px;
}

@media (max-width: 600px) {
  .login-container {
    max-width: 100%;
  }

  .login-card {
    margin: 0 10px;
  }
}
</style>
