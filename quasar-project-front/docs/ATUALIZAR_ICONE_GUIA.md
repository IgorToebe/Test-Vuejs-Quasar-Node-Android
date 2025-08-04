# 🎨 Guia: Como Atualizar o Ícone do App Android

## 📁 **Localização dos Ícones**

Os ícones estão nas pastas:

```
android/app/src/main/res/
├── mipmap-mdpi/          (48x48px)
├── mipmap-hdpi/          (72x72px)
├── mipmap-xhdpi/         (96x96px)
├── mipmap-xxhdpi/        (144x144px)
├── mipmap-xxxhdpi/       (192x192px)
└── mipmap-anydpi-v26/    (ícones adaptativos)
```

## 🎯 **Método 1: Substituir Ícones Manualmente**

### **Tamanhos Necessários:**

- **mdpi**: 48x48px
- **hdpi**: 72x72px
- **xhdpi**: 96x96px
- **xxhdpi**: 144x144px
- **xxxhdpi**: 192x192px

### **Arquivos a Substituir:**

```
ic_launcher.png         (ícone principal)
ic_launcher_round.png   (ícone redondo)
ic_launcher_foreground.png (para ícones adaptativos)
```

### **Passos:**

1. **Crie seu ícone** nas 5 resoluções acima
2. **Nomeie os arquivos** como `ic_launcher.png`, `ic_launcher_round.png`
3. **Substitua** os arquivos em cada pasta mipmap
4. **Rebuild** o projeto

## 🚀 **Método 2: Usar Android Studio (Recomendado)**

1. **Abra o Android Studio**
2. **Clique direito** em `app` → **New** → **Image Asset**
3. **Asset Type**: Launcher Icons (Adaptive and Legacy)
4. **Name**: ic_launcher
5. **Foreground Layer**: Escolha sua imagem
6. **Background Layer**: Cor ou imagem de fundo
7. **Clique Next** → **Finish**

## 🛠️ **Método 3: Ferramentas Online**

### **Geradores de Ícones:**

- [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html)
- [App Icon Generator](https://appicon.co/)
- [Icon Kitchen](https://icon.kitchen/)

### **Como usar:**

1. **Upload** sua imagem (recomendo 512x512px)
2. **Configure** padding, cor de fundo, etc.
3. **Download** o pacote com todas as resoluções
4. **Extraia** e substitua nas pastas mipmap

## 📝 **Método 4: Script Automático**

Vou criar um script para facilitar:

### **Converter uma imagem para todos os tamanhos:**

```bash
# Usando ImageMagick (instale primeiro)
convert seu_icone.png -resize 48x48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png
convert seu_icone.png -resize 72x72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png
convert seu_icone.png -resize 96x96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
convert seu_icone.png -resize 144x144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
convert seu_icone.png -resize 192x192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
```

## 🎨 **Ícones Adaptativos (Android 8.0+)**

### **Arquivos necessários:**

```
mipmap-anydpi-v26/
├── ic_launcher.xml
└── ic_launcher_round.xml
```

### **Exemplo de ic_launcher.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
```

## ⚙️ **Configurações no Manifest**

Verifique se o `AndroidManifest.xml` está correto:

```xml
<application
    android:icon="@mipmap/ic_launcher"
    android:roundIcon="@mipmap/ic_launcher_round"
    ...>
```

## 🔄 **Após Atualizar o Ícone:**

1. **Limpe o projeto:**

   ```bash
   cd android
   ./gradlew clean
   ```

2. **Sincronize:**

   ```bash
   npx cap sync
   ```

3. **Rebuilde:**

   ```bash
   ./gradlew assembleDebug
   ```

4. **Instale novamente:**
   ```bash
   adb install -r app/build/outputs/apk/debug/app-debug.apk
   ```

## 💡 **Dicas Importantes:**

### **Design do Ícone:**

- **Resolução base**: 512x512px ou 1024x1024px
- **Formato**: PNG com transparência
- **Estilo**: Simples, reconhecível, legível
- **Cores**: Contrastantes, não muito detalhado

### **Testes:**

- **Teste em diferentes dispositivos**
- **Verifique em temas claro/escuro**
- **Confirme em diferentes versões do Android**

### **Problemas Comuns:**

- **Cache**: Limpe cache do dispositivo
- **Permissões**: Verifique se os arquivos têm as permissões corretas
- **Formato**: Use PNG, não JPEG

## 📱 **Ícone Quasar (Opcional)**

Se quiser usar o sistema de ícones do Quasar:

```bash
# Instalar ferramenta de ícones
npm install -g @quasar/icongenie

# Gerar ícones a partir de uma imagem
icongenie generate -i seu_icone.png
```

## 🎯 **Resumo Rápido:**

1. **Crie** seu ícone em 512x512px
2. **Use** Android Asset Studio para gerar todas as resoluções
3. **Substitua** os arquivos nas pastas mipmap
4. **Rebuilde** o projeto
5. **Teste** no dispositivo

---

🎉 **Pronto!** Seu app terá um novo ícone personalizado!
