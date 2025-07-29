
import { boot } from 'quasar/wrappers'
import PrimeVue from 'primevue/config'
import 'primeicons/primeicons.css' // Ícones do PrimeIcons

// PrimeVue 4.x usa um sistema de temas diferente
// Vamos usar o tema Aura (novo sistema de temas do PrimeVue 4.x)
import Aura from '@primevue/themes/aura'

// Você pode importar componentes específicos aqui para registro global,
// mas geralmente é melhor importá-los localmente nos componentes que os usam.
// Exemplo de registro global (se quisesse):
// import Button from 'primevue/button';

export default boot(({ app }) => {
  // Use o PrimeVue na instância do aplicativo Vue
  app.use(PrimeVue, {
    theme: {
      preset: Aura,
      options: {
        darkModeSelector: '.dark-mode',
        cssLayer: {
          name: 'primevue',
          order: 'tailwind-base, primevue, tailwind-utilities'
        }
      }
    },
    // Configurações opcionais do PrimeVue aqui
    // Por exemplo, para definir o ripple effect globalmente:
    ripple: true,
    // Configurações de localização (opcional, para traduzir componentes)
    // locale: { ... }
  })

  // Se você registrasse componentes globalmente:
  // app.component('Button', Button);
})
