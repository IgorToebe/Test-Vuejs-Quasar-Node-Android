# 📱 Como Gerar APK Release (Produção)

## 🎯 Diferenças: Debug vs Release

### **APK Debug (Desenvolvimento):**

- ✅ Instala rapidamente
- ✅ Permite depuração
- ❌ Arquivo maior
- ❌ Performance não otimizada
- ❌ Não pode ser distribuído

### **APK Release (Produção):**

- ✅ Código otimizado/minificado
- ✅ Performance máxima
- ✅ Arquivo menor
- ✅ Pronto para distribuição
- ✅ Pode ser publicado na Play Store
- ❌ Demora mais para gerar

## 🚀 Método 1: Via Script (Automático)

Execute o script e escolha a opção **10**:

```bash
.\scripts\comandos-dev.bat
# Escolha: 10. Gerar APK Release (Producao)
```

### **O que o script faz:**

1. **Build de produção** - Otimiza e minifica código
2. **Sync Android** - Atualiza projeto Android
3. **Abre Android Studio** - Para finalizar o APK

## 🔧 Método 2: Manual (Passo a Passo)

### **Passo 1: Build de Produção**

```bash
npm run build
# OU
quasar build
```

### **Passo 2: Sync com Android**

```bash
npx cap sync android
```

### **Passo 3: Abrir Android Studio**

```bash
npx cap open android
```

### **Passo 4: No Android Studio**

#### **4.1: Aguardar Carregamento**

- ✅ Aguarde indexação completa
- ✅ Aguarde sync do Gradle

#### **4.2: Gerar APK Assinado**

1. **Menu**: `Build` → `Generate Signed Bundle / APK...`
2. **Escolha**: `APK` (não Bundle)
3. **Clique**: `Next`

#### **4.3: Configurar Keystore**

**Se é a PRIMEIRA VEZ:**

1. **Clique**: `Create new...`
2. **Preencha**:
   - **Key store path**: `C:\caminho\para\sua\keystore.jks`
   - **Password**: Senha forte
   - **Key alias**: Nome do app (ex: quasar-test)
   - **Key password**: Mesma senha ou diferente
   - **Validity**: 25 anos
   - **First and Last Name**: Seu nome
   - **Organization**: Sua empresa
   - **Country**: BR

**Se JÁ TEM keystore:**

1. **Clique**: `Choose existing...`
2. **Selecione**: Arquivo `.jks` existente
3. **Digite**: Senhas do keystore e key

#### **4.4: Finalizar APK**

1. **Escolha**: `release` (não debug)
2. **Marque**: `V1 (Jar Signature)` e `V2 (Full APK Signature)`
3. **Clique**: `Finish`

## 📂 Onde Encontrar o APK

```
android/app/build/outputs/apk/release/app-release.apk
```

## 🛡️ Keystore - MUITO IMPORTANTE

### **⚠️ ATENÇÃO - GUARDE BEM:**

- **Arquivo .jks**: Faça backup em local seguro
- **Senhas**: Anote em local seguro
- **Se perder**: NUNCA MAIS poderá atualizar o app na Play Store

### **📝 Recomendações:**

```bash
# Fazer backup do keystore
copy android\app\keystore.jks "C:\Backup\Keystore\"

# Criar arquivo com senhas (criptografado)
# keystore_info.txt:
# Keystore: minha_senha_keystore
# Key: minha_senha_key
# Alias: quasar-test-app
```

## 🎯 Verificar APK Release

### **Instalar no Celular:**

```bash
adb install android/app/build/outputs/apk/release/app-release.apk
```

### **Verificar Assinatura:**

```bash
# Verificar se está assinado
jarsigner -verify -verbose android/app/build/outputs/apk/release/app-release.apk
```

### **Tamanho do APK:**

- **Debug**: ~15-25 MB
- **Release**: ~8-15 MB (otimizado)

## 🚀 Para Play Store

### **Antes de Publicar:**

1. **Teste completo** no APK Release
2. **Versão atualizada** em `package.json`
3. **Ícones corretos** em todas as resoluções
4. **Permissões mínimas** no AndroidManifest.xml

### **Arquivo para Upload:**

```
android/app/build/outputs/apk/release/app-release.apk
```

## 🔄 Próximas Atualizações

Para atualizações futuras:

1. **Mesmo keystore** (obrigatório)
2. **Version Code maior** que a anterior
3. **Mesmo processo** de build Release

---

**🎉 Agora você pode distribuir seu app!** 📱
