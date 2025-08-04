# 📱 INSTRUÇÕES PARA GERAR APK RELEASE

## 🎯 Status Atual: Build em Progresso

O comando está executando automaticamente:

1. ✅ `quasar build` - Build de produção (em progresso)
2. ⏳ `npx cap sync android` - Sincronização (próximo)
3. ⏳ `npx cap open android` - Abrir Android Studio (próximo)

## 📋 QUANDO O ANDROID STUDIO ABRIR:

### **Passo 1: Aguardar Carregamento**

- ✅ Aguarde o Android Studio terminar de indexar
- ✅ Aguarde sincronização do Gradle (barra de progresso embaixo)

### **Passo 2: Gerar APK Assinado**

1. **Menu**: `Build` → `Generate Signed Bundle / APK...`
2. **Escolha**: `APK` (não Bundle)
3. **Clique**: `Next`

### **Passo 3: Configurar Keystore**

**Se é a PRIMEIRA VEZ:**

1. **Clique**: `Create new...`
2. **Preencha**:
   - **Key store path**: `C:\APK-Keys\quasar-test.jks`
   - **Password**: Uma senha forte (anote bem!)
   - **Key alias**: `quasar-test-key`
   - **Key password**: Mesma senha ou diferente
   - **Validity**: 25 anos
   - **First and Last Name**: Seu nome
   - **Organization**: Sua empresa
   - **Country**: BR

**⚠️ IMPORTANTE: GUARDE MUITO BEM O ARQUIVO .jks E AS SENHAS!**

### **Passo 4: Finalizar**

1. **Escolha**: `release` (não debug)
2. **Marque**: `V1 (Jar Signature)` e `V2 (Full APK Signature)`
3. **Clique**: `Finish`

### **Passo 5: Aguardar Geração**

- O Android Studio vai compilar e gerar o APK
- Pode demorar 2-5 minutos
- Você verá o progresso na barra inferior

## 📂 Onde Encontrar o APK

```
android/app/build/outputs/apk/release/app-release.apk
```

## 🎉 Resultado Final

Após a geração bem-sucedida:

- ✅ APK otimizado para produção
- ✅ Arquivo assinado digitalmente
- ✅ Pronto para instalação e distribuição
- ✅ Tamanho reduzido (código minificado)

## 📱 Como Instalar o APK

### **No seu celular:**

```bash
adb install android/app/build/outputs/apk/release/app-release.apk
```

### **Ou copiar manualmente:**

1. Copie o arquivo `app-release.apk` para o celular
2. Abra o arquivo no celular
3. Permita "Instalar apps de origens desconhecidas"
4. Instale o app

---

**⏳ Aguarde o Android Studio abrir e siga os passos acima!**
