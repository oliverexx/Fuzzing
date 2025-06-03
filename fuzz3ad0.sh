#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Variables globales
TARGET_URL=""
TARGET_IP=""
SESSION_NAME="htb_scan"
SCAN_FILE="scan_${TARGET_IP}.txt"

# Función para mostrar el menú principal
show_main_menu() {
    clear
    echo -e "${GREEN}=== MENÚ PRINCIPAL DE FUZZING ===${NC}"
    echo
    echo -e "${YELLOW}URL objetivo actual: ${GREEN}$TARGET_URL${NC}"
    echo
    echo "1. Fuzzing de Archivos y Directorios"
    echo "2. Fuzzing de Parámetros"
    echo "3. Fuzzing de VHOST y Subdominios"
    echo "4. Fuzzing de API REST"
    echo "5. Validación Manual"
    echo "6. Configuración"
    echo "7. Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el submenú de archivos y directorios
show_files_dirs_menu() {
    clear
    echo -e "${GREEN}=== FUZZING DE ARCHIVOS Y DIRECTORIOS ===${NC}"
    echo
    echo "1. FFUF"
    echo "2. Feroxbuster"
    echo "3. Gobuster"
    echo "4. Wfuzz"
    echo "5. Dirb"
    echo "6. Volver al menú principal"
    echo
    echo -n "Seleccione una herramienta: "
}

# Función para mostrar la sintaxis de FFUF
show_ffuf_syntax() {
    clear
    echo -e "${GREEN}=== FFUF - SINTAXIS Y EJEMPLOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}2. Fuzzing con extensiones:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -e .php,.html,.txt \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}3. Fuzzing recursivo:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -recursion \\"
    echo "     -recursion-depth 2 \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}4. Fuzzing con filtrado:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -mc 200 \\"
    echo "     -fs 0 \\"
    echo "     -fc 404 \\"
    echo "     -mr \"admin\" \\"
    echo "     -fr \"error\""
    echo
    echo -e "${YELLOW}5. Fuzzing con autenticación:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -H \"Authorization: Bearer token123\" \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}6. Fuzzing con rate limit:${NC}"
    echo "ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -rate 100 \\"
    echo "     -mc 200"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina filtros para resultados más precisos"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo
    read -p "Presione Enter para continuar..."
}

# Función para mostrar la sintaxis de Feroxbuster
show_feroxbuster_syntax() {
    clear
    echo -e "${GREEN}=== FEROXBUSTER - SINTAXIS Y EJEMPLOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            --depth 3 \\"
    echo "            --threads 30"
    echo
    echo -e "${YELLOW}2. Fuzzing con filtrado:${NC}"
    echo "feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -C 404,403 \\"
    echo "            -S 1024 \\"
    echo "            --threads 30"
    echo
    echo -e "${YELLOW}3. Fuzzing con recursión:${NC}"
    echo "feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            --depth 5 \\"
    echo "            --recursion"
    echo
    echo -e "${YELLOW}4. Fuzzing con autenticación:${NC}"
    echo "feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            --headers \"Authorization: Bearer token123\""
    echo
    echo -e "${YELLOW}5. Fuzzing con exclusiones:${NC}"
    echo "feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -X \"error\" \\"
    echo "            -N 50"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la profundidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo
    read -p "Presione Enter para continuar..."
}

# Función para mostrar la sintaxis de Gobuster
show_gobuster_syntax() {
    clear
    echo -e "${GREEN}=== GOBUSTER - SINTAXIS Y EJEMPLOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -x .html,.php,.txt \\"
    echo "            -t 30"
    echo
    echo -e "${YELLOW}2. Fuzzing con filtrado:${NC}"
    echo "gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -s 200,204,301,302,307,401,403 \\"
    echo "            -b 404 \\"
    echo "            -t 50"
    echo
    echo -e "${YELLOW}3. Fuzzing con recursión:${NC}"
    echo "gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -r \\"
    echo "            -t 30"
    echo
    echo -e "${YELLOW}4. Fuzzing con autenticación:${NC}"
    echo "gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            -H \"Authorization: Bearer token123\""
    echo
    echo -e "${YELLOW}5. Fuzzing con exclusiones:${NC}"
    echo "gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "            --exclude-length 0 \\"
    echo "            --exclude-text \"404\""
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo
    read -p "Presione Enter para continuar..."
}

# Función para mostrar la sintaxis de Wfuzz
show_wfuzz_syntax() {
    clear
    echo -e "${GREEN}=== WFUZZ - SINTAXIS Y EJEMPLOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "wfuzz -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "      --hc 404 \\"
    echo "      $TARGET_URL/FUZZ"
    echo
    echo -e "${YELLOW}2. Fuzzing con filtrado:${NC}"
    echo "wfuzz -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "      --hc 404,403 \\"
    echo "      --hl 0 \\"
    echo "      --hw 0 \\"
    echo "      $TARGET_URL/FUZZ"
    echo
    echo -e "${YELLOW}3. Fuzzing con recursión:${NC}"
    echo "wfuzz -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "      -R 2 \\"
    echo "      $TARGET_URL/FUZZ"
    echo
    echo -e "${YELLOW}4. Fuzzing con autenticación:${NC}"
    echo "wfuzz -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt \\"
    echo "      -H \"Authorization: Bearer token123\" \\"
    echo "      $TARGET_URL/FUZZ"
    echo
    echo -e "${YELLOW}5. Fuzzing con múltiples parámetros:${NC}"
    echo "wfuzz -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "      -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "      $TARGET_URL/FUZZ1/FUZZ2"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo
    read -p "Presione Enter para continuar..."
}

# Función para mostrar la sintaxis de Dirb
show_dirb_syntax() {
    clear
    echo -e "${GREEN}=== DIRB - SINTAXIS Y EJEMPLOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt"
    echo
    echo -e "${YELLOW}2. Fuzzing con extensiones:${NC}"
    echo "dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -X .php,.html"
    echo
    echo -e "${YELLOW}3. Fuzzing con autenticación:${NC}"
    echo "dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -u usuario:password"
    echo
    echo -e "${YELLOW}4. Fuzzing con recursión:${NC}"
    echo "dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -r"
    echo
    echo -e "${YELLOW}5. Fuzzing con exclusiones:${NC}"
    echo "dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -N 404"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo
    read -p "Presione Enter para continuar..."
}

# Función para manejar el submenú de archivos y directorios
handle_files_dirs_menu() {
    while true; do
        show_files_dirs_menu
        read -r option
        
        case $option in
            1) show_ffuf_syntax ;;
            2) show_feroxbuster_syntax ;;
            3) show_gobuster_syntax ;;
            4) show_wfuzz_syntax ;;
            5) show_dirb_syntax ;;
            6) return ;;
            *) echo -e "${RED}Opción inválida${NC}" ;;
        esac
    done
}

# Función para solicitar la URL
get_target_url() {
    local prompt="$1"
    echo -e "${GREEN}=== Configuración del Objetivo ===${NC}"
    echo -e "${YELLOW}$prompt${NC}"
    echo -n "Ingrese la URL objetivo (ej: http://ejemplo.com o http://10.10.10.10): "
    read -r TARGET_URL
    
    # Validar que la URL no esté vacía
    if [ -z "$TARGET_URL" ]; then
        echo -e "${RED}Error: La URL no puede estar vacía${NC}"
        return 1
    fi
    
    # Validar formato básico de URL
    if ! [[ $TARGET_URL =~ ^https?:// ]]; then
        echo -e "${RED}Error: La URL debe comenzar con http:// o https://${NC}"
        return 1
    fi
    
    # Extraer el dominio/IP de la URL
    local domain=$(echo "$TARGET_URL" | sed -E 's|^https?://([^/]+).*|\1|')
    
    # Validar que el dominio/IP no esté vacío
    if [ -z "$domain" ]; then
        echo -e "${RED}Error: La URL debe contener un dominio o dirección IP válida${NC}"
        return 1
    fi
    
    # Validar formato de IP o dominio
    if ! [[ $domain =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && ! [[ $domain =~ ^[a-zA-Z0-9][a-zA-Z0-9-]*(\.[a-zA-Z0-9][a-zA-Z0-9-]*)*$ ]]; then
        echo -e "${RED}Error: El formato del dominio o IP no es válido${NC}"
        return 1
    fi
    
    echo -e "${GREEN}URL objetivo configurada: ${YELLOW}$TARGET_URL${NC}"
    echo -e "${GREEN}Dominio/IP objetivo: ${YELLOW}$domain${NC}"
    echo
    return 0
}

# Bucle principal
while true; do
    # Solicitar URL al inicio si no está configurada
    if [ -z "$TARGET_URL" ]; then
        if ! get_target_url "Configuración inicial del objetivo"; then
            echo -e "${RED}Error: Debe proporcionar una URL válida para continuar${NC}"
            exit 1
        fi
    fi

    show_main_menu
    read -r option
    
    case $option in
        1) handle_files_dirs_menu ;;
        2) echo "Fuzzing de Parámetros - En desarrollo" ;;
        3) echo "Fuzzing de VHOST y Subdominios - En desarrollo" ;;
        4) echo "Fuzzing de API REST - En desarrollo" ;;
        5) echo "Validación Manual - En desarrollo" ;;
        6) echo "Configuración - En desarrollo" ;;
        7) echo -e "${GREEN}Saliendo...${NC}"; exit 0 ;;
        *) echo -e "${RED}Opción inválida${NC}" ;;
    esac
    
    echo
    read -p "Presione Enter para continuar..."
    clear
done
