# 🔧 Troubleshooting: Erros de Build

## ❌ Problema: "Erro no build! Verifique o codigo"

### 🔍 **Diagnóstico Rápido**

```bash
# 1. Verificar se há erros específicos
npm run build

# 2. Verificar sintaxe do código
npm run lint

# 3. Limpar cache e tentar novamente
npx quasar clean
npm run build
```

## 🛠️ **Soluções Comuns**

### **1. Erros de Sintaxe JavaScript/Vue**

**Verificar:**

```bash
npm run lint
```

**Corrigir:**

- Verificar todas as importações
- Verificar sintaxe Vue 3 Composition API
- Verificar fechamento de tags/parênteses

### **2. Problemas de Importação**

**Erro comum:**

```javascript
// ❌ Importação incorreta
import { Component } from './path/wrong'

// ✅ Importação correta
import { Component } from '../path/correct'
```

**Verificar:**

- Caminhos relativos corretos (`../`, `./`)
- Extensões de arquivo (`.js`, `.vue`)
- Nomes de importação corretos

### **3. Problemas com Plugins Capacitor**

**Se usando plugins customizados:**

```javascript
// Verificar se todas as importações estão corretas
import { Device } from '@capacitor/device'
import { FlashlightPlugin } from '../plugins/flashlight.js'
```

### **4. Problemas de Cache**

```bash
# Limpar todos os caches
npx quasar clean
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
npm run build
```

### **5. Problemas de Memória**

```bash
# Aumentar memória para build
set NODE_OPTIONS=--max-old-space-size=4096
npm run build
```

## 🎯 **Verificações Específicas**

### **Arquivo routes.js**

```javascript
// Verificar se todas as páginas existem
const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [{ path: '', component: () => import('pages/AndroidTestPageSimple.vue') }],
  },
]
```

### **Páginas Vue**

```vue
<!-- Verificar estrutura básica -->
<template>
  <!-- Conteúdo aqui -->
</template>

<script setup>
// Importações e lógica aqui
</script>

<style scoped>
/* Estilos aqui */
</style>
```

### **Plugin Flashlight**

```javascript
// Verificar se o plugin está bem estruturado
export class FlashlightPlugin {
  static async isAvailable() {
    // implementação
  }
}
```

## 🚀 **Script de Diagnóstico Automático**

Adicione esta função ao `comandos-dev.bat`:

```batch
:diagnostico
echo.
echo ========================================
echo     DIAGNOSTICO DE BUILD
echo ========================================
echo.
echo 🔍 Executando verificacoes...
echo.

echo 1/5 Verificando sintaxe...
call npm run lint
if %errorlevel% neq 0 (
    echo ❌ Erro de sintaxe encontrado!
    goto :diagnostico_end
)

echo 2/5 Limpando cache...
call npx quasar clean

echo 3/5 Verificando dependencias...
call npm audit

echo 4/5 Testando build...
call npm run build
if %errorlevel% equ 0 (
    echo ✅ Build executado com sucesso!
) else (
    echo ❌ Erro no build detectado!
)

echo 5/5 Verificando arquivos gerados...
if exist "dist\spa\index.html" (
    echo ✅ Arquivos de build gerados!
) else (
    echo ❌ Arquivos de build não encontrados!
)

:diagnostico_end
echo.
pause
goto :menu
```

## 📝 **Logs Úteis**

### **Verificar logs detalhados:**

```bash
# Build com logs verbosos
npm run build -- --verbose

# Verificar estrutura gerada
ls -la dist/spa/
```

### **Arquivos que devem existir após build:**

```
dist/spa/
├── index.html
├── assets/
│   ├── [hash].js
│   └── [hash].css
├── icons/
└── favicon.ico
```

## ✅ **Checklist de Verificação**

Antes de reportar erro, verificar:

- [ ] `npm run lint` executa sem erros
- [ ] Todas as importações estão corretas
- [ ] Não há arquivos faltando
- [ ] Cache foi limpo
- [ ] Dependências estão instaladas
- [ ] Pasta `dist/spa` é criada após build
- [ ] Arquivo `dist/spa/index.html` existe

## 🎉 **Build Bem-sucedido**

Após build com sucesso, você deve ver:

```
✓ Build completed successfully
App • Generated SPA...
```

E a pasta `dist/spa` deve conter todos os arquivos necessários.

---

**💡 Dica**: Se o problema persistir, use a opção de diagnóstico no script para identificar o problema específico!
