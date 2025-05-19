# fuzz3ad0.sh
# Guía de Fuzzing Web
Este script proporciona una guía interactiva para realizar diferentes tipos de fuzzing web, incluyendo directorios, parámetros, subdominios y más.
## 🛠️ Dependencias
El script requiere las siguientes herramientas instaladas:
- **ffuf**: Fuzzer web rápido y flexible
  ```bash
  # Instalación en Debian/Ubuntu
  sudo apt-get install ffuf
  # Instalación en Arch Linux
  sudo pacman -S ffuf
  # Instalación en macOS
  brew install ffuf
  ```

- **gobuster**: Fuzzer de directorios y DNS
  ```bash
  # Instalación en Debian/Ubuntu
  sudo apt-get install gobuster

  # Instalación en Arch Linux
  sudo pacman -S gobuster
  # Instalación en macOS
  brew install gobuster
  ```
- **feroxbuster**: Fuzzer de directorios moderno
  ```bash
  # Instalación en Debian/Ubuntu
  curl -s https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
  # Instalación en Arch Linux
  sudo pacman -S feroxbuster

  # Instalación en macOS
  brew install feroxbuster
  ```
- **SecLists**: Colección de wordlists para pruebas de seguridad
  ```bash
  # Instalación en Debian/Ubuntu
  sudo apt-get install seclists

  # Instalación en Arch Linux
  sudo pacman -S seclists

  # Instalación en macOS
  brew install seclists
  ```

## 📦 Instalación
1. Clona el repositorio:
   git clone https://github.com/tu-usuario/fuzzing-guide.git
   cd fuzzing-guide
2. Dale permisos de ejecución al script:
   chmod +x fuzz.sh
## 🚀 Uso
./fuzz.sh


El script mostrará un menú interactivo con las siguientes opciones:

1. Fuzzing de Directorios (ffuf)
2. Fuzzing de Directorios (feroxbuster)
3. Fuzzing de Directorios (gobuster)
4. Fuzzing de Parámetros GET
5. Fuzzing de Parámetros POST
6. Fuzzing de Virtual Hosts
7. Fuzzing de Subdominios
8. Fuzzing de API

## 📚 Wordlists

El script incluye referencias a varias wordlists de SecLists, organizadas por categorías:

- Directorios y Archivos
- Subdominios
- Parámetros y Valores
- APIs
- Extensiones
- Backups
- Configuración
- CMS
- Frameworks
- Servicios

Todas las wordlists se encuentran en `/usr/share/seclists/`.

## ⚠️ Notas Importantes

1. Este script es solo una guía de referencia y no ejecuta los comandos directamente
2. Siempre obtén permiso antes de realizar pruebas de fuzzing
3. Comienza con wordlists pequeñas y escala gradualmente
4. Considera el impacto en el servidor objetivo
5. Implementa rate limiting para evitar sobrecarga

## ⚠️ Descargo de Responsabilidad

Este script es solo para fines educativos y de prueba. El usuario es responsable de su uso y debe asegurarse de tener los permisos necesarios antes de realizar cualquier prueba de fuzzing. 
