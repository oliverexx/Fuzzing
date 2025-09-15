#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables globales
TARGET_URL="http://example.com"
TARGET_IP=""
WORDLIST_DIR="/usr/share/wordlists/seclists"
SESSION_NAME="htb_scan"
SCAN_FILE="scan_${TARGET_IP}.txt"
CURRENT_TOOL=""
CURRENT_CATEGORY=""

# Función para mostrar encabezados
show_header() {
    clear
    echo -e "${GREEN}============================================${NC}"
    echo -e "${GREEN}        GUÍA INTERACTIVA DE FUZZING         ${NC}"
    echo -e "${GREEN}============================================${NC}"
    echo
}

# Función para mostrar el menú principal
show_main_menu() {
    show_header
    echo -e "${YELLOW}URL objetivo actual: ${GREEN}$TARGET_URL${NC}"
    echo -e "${YELLOW}Categoría actual: ${GREEN}$CURRENT_CATEGORY${NC}"
    echo -e "${YELLOW}Herramienta actual: ${GREEN}$CURRENT_TOOL${NC}"
    echo
    echo -e "${CYAN}1.${NC} Fuzzing de Archivos y Directorios"
    echo -e "${CYAN}2.${NC} Fuzzing de Parámetros"
    echo -e "${CYAN}3.${NC} Fuzzing de VHOST y Subdominios"
    echo -e "${CYAN}4.${NC} Fuzzing de API REST"
    echo -e "${CYAN}5.${NC} Validación Manual"
    echo -e "${CYAN}6.${NC} Configuración"
    echo -e "${CYAN}7.${NC} Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar pie de página con información contextual
show_footer() {
    echo
    echo -e "${PURPLE}============================================${NC}"
    echo -e "${PURPLE}Nota: Esta es una guía de referencia. Los comandos no se ejecutan.${NC}"
    if [ ! -z "$CURRENT_TOOL" ]; then
        echo -e "${PURPLE}Herramienta: $CURRENT_TOOL${NC}"
    fi
    echo -e "${PURPLE}============================================${NC}"
    echo
}

# Función para pausar y esperar entrada
press_enter() {
    echo
    echo -n "Presione Enter para continuar..."
    read
}

# Función para mostrar opciones de herramientas comunes
show_tool_options() {
    echo
    echo -e "${YELLOW}Opciones disponibles:${NC}"
    echo -e "${CYAN}1.${NC} Ver sintaxis y ejemplos"
    echo -e "${CYAN}2.${NC} Ver wordlists recomendadas"
    echo -e "${CYAN}3.${NC} Ver parámetros comunes"
    echo -e "${CYAN}4.${NC} Volver al menú anterior"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar wordlists recomendadas
show_wordlists() {
    echo
    echo -e "${YELLOW}Wordlists recomendadas:${NC}"
    echo -e "${CYAN}1.${NC} Directorios comunes: $WORDLIST_DIR/Discovery/Web-Content/common.txt"
    echo -e "${CYAN}2.${NC} Directorios grandes: $WORDLIST_DIR/Discovery/Web-Content/big.txt"
    echo -e "${CYAN}3.${NC} Parámetros: $WORDLIST_DIR/Discovery/Web-Content/burp-parameter-names.txt"
    echo -e "${CYAN}4.${NC} Subdominios: $WORDLIST_DIR/Discovery/DNS/subdomains-top1million-110000.txt"
    echo -e "${CYAN}5.${NC} APIs: $WORDLIST_DIR/Discovery/Web-Content/api/common.txt"
    echo
    echo -e "${YELLOW}Otras wordlists útiles:${NC}"
    echo -e "${CYAN}•${NC} raft-small-words.txt"
    echo -e "${CYAN}•${NC} directory-list-2.3-medium.txt"
    echo -e "${CYAN}•${NC} robotstxt.txt"
}

# Función para mostrar el submenú de archivos y directorios
show_files_dirs_menu() {
    CURRENT_CATEGORY="Archivos y Directorios"
    local option
    while true; do
        show_header
        echo -e "${YELLOW}CATEGORÍA: ${GREEN}$CURRENT_CATEGORY${NC}"
        echo
        echo -e "${CYAN}1.${NC} FFUF"
        echo -e "${CYAN}2.${NC} Feroxbuster"
        echo -e "${CYAN}3.${NC} Gobuster"
        echo -e "${CYAN}4.${NC} Wfuzz"
        echo -e "${CYAN}5.${NC} Dirb"
        echo -e "${CYAN}6.${NC} Comparativa de herramientas"
        echo -e "${CYAN}7.${NC} Volver al menú principal"
        echo
        echo -n "Seleccione una herramienta: "
        read option
        
        case $option in
            1) 
                CURRENT_TOOL="FFUF"
                show_ffuf_options
                ;;
            2) 
                CURRENT_TOOL="Feroxbuster"
                show_feroxbuster_options
                ;;
            3) 
                CURRENT_TOOL="Gobuster"
                show_gobuster_options
                ;;
            4) 
                CURRENT_TOOL="Wfuzz"
                show_wfuzz_options
                ;;
            5) 
                CURRENT_TOOL="Dirb"
                show_dirb_options
                ;;
            6) 
                show_tools_comparison
                ;;
            7) 
                CURRENT_CATEGORY=""
                CURRENT_TOOL=""
                break
                ;;
            *) 
                echo -e "${RED}Opción inválida${NC}"
                press_enter
                ;;
        esac
    done
}

# Función para mostrar opciones de FFUF
show_ffuf_options() {
    local option
    while true; do
        show_header
        echo -e "${YELLOW}CATEGORÍA: ${GREEN}$CURRENT_CATEGORY${NC}"
        echo -e "${YELLOW}HERRAMIENTA: ${GREEN}$CURRENT_TOOL${NC}"
        show_tool_options
        read option
        
        case $option in
            1) show_ffuf_syntax ;;
            2) 
                show_wordlists
                press_enter 
                ;;
            3) show_ffuf_parameters ;;
            4) break ;;
            *) 
                echo -e "${RED}Opción inválida${NC}"
                press_enter
                ;;
        esac
    done
}

# Función para mostrar la sintaxis de FFUF
show_ffuf_syntax() {
    show_header
    echo -e "${YELLOW}CATEGORÍA: ${GREEN}$CURRENT_CATEGORY${NC}"
    echo -e "${YELLOW}HERRAMIENTA: ${GREEN}$CURRENT_TOOL - SINTAXIS${NC}"
    echo
    echo -e "${YELLOW}1. Fuzzing básico:${NC}"
    echo "ffuf -w ${WORDLIST_DIR}/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}2. Fuzzing con extensiones:${NC}"
    echo "ffuf -w ${WORDLIST_DIR}/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -e .php,.html,.txt \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}3. Fuzzing recursivo:${NC}"
    echo "ffuf -w ${WORDLIST_DIR}/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -recursion \\"
    echo "     -recursion-depth 2 \\"
    echo "     -mc 200"
    echo
    echo -e "${YELLOW}4. Fuzzing con filtrado:${NC}"
    echo "ffuf -w ${WORDLIST_DIR}/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -mc 200 \\"
    echo "     -fs 0 \\"
    echo "     -fc 404 \\"
    echo "     -mr \"admin\" \\"
    echo "     -fr \"error\""
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "• Ajusta la velocidad (-rate) según el objetivo"
    echo "• Usa diferentes wordlists para mejor cobertura"
    echo "• Combina filtros para resultados más precisos"
    echo "• Documenta los hallazgos importantes"
    echo "• Valida manualmente los resultados"
    
    show_footer
    press_enter
}

# Función para mostrar parámetros de FFUF
show_ffuf_parameters() {
    show_header
    echo -e "${YELLOW}CATEGORÍA: ${GREEN}$CURRENT_CATEGORY${NC}"
    echo -e "${YELLOW}HERRAMIENTA: ${GREEN}$CURRENT_TOOL - PARÁMETROS${NC}"
    echo
    echo -e "${YELLOW}Parámetros comunes:${NC}"
    echo -e "${CYAN}-w${NC}         Especificar wordlist"
    echo -e "${CYAN}-u${NC}         URL objetivo (usar FUZZ donde aplicar fuzzing)"
    echo -e "${CYAN}-mc${NC}        Filtrar por códigos de estado HTTP"
    echo -e "${CYAN}-fs${NC}        Filtrar por tamaño de respuesta"
    echo -e "${CYAN}-fc${NC}        Filtrar por código de estado HTTP"
    echo -e "${CYAN}-H${NC}         Agregar headers personalizados"
    echo -e "${CYAN}-d${NC}         Datos para peticiones POST"
    echo -e "${CYAN}-X${NC}         Método HTTP a usar"
    echo -e "${CYAN}-rate${NC}      Límite de peticiones por segundo"
    echo -e "${CYAN}-recursion${NC} Habilitar recursión"
    echo -e "${CYAN}-e${NC}         Extensiones a probar"
    echo -e "${CYAN}-c${NC}         Mostrar output con colores"
    echo -e "${CYAN}-v${NC}         Output verbose"
    echo
    echo -e "${YELLOW}Ejemplo avanzado:${NC}"
    echo "ffuf -w ${WORDLIST_DIR}/Discovery/Web-Content/common.txt \\"
    echo "     -u $TARGET_URL/FUZZ \\"
    echo "     -H \"User-Agent: Mozilla/5.0\" \\"
    echo "     -H \"Authorization: Bearer token123\" \\"
    echo "     -recursion -recursion-depth 2 \\"
    echo "     -e .php,.html,.txt,.bak \\"
    echo "     -mc 200,301,302 \\"
    echo "     -fs 0 \\"
    echo "     -rate 100 \\"
    echo "     -c -v"
    
    show_footer
    press_enter
}

# Funciones similares para otras herramientas (Feroxbuster, Gobuster, etc.)
# Se implementarían siguiendo el mismo patrón que show_ffuf_options

# Función para mostrar comparativa de herramientas
show_tools_comparison() {
    show_header
    echo -e "${YELLOW}COMPARATIVA DE HERRAMIENTAS DE FUZZING${NC}"
    echo
    echo -e "${CYAN}Herramienta   Velocidad   Recursión  Características únicas${NC}"
    echo -e "${GREEN}----------------------------------------------------------------${NC}"
    echo -e "FFUF         Alta       Sí        Filtrado flexible, múltiples métodos"
    echo -e "Feroxbuster  Muy Alta   Sí        Auto-recuperación, recursión inteligente"
    echo -e "Gobuster     Media      Sí        Fácil de usar, múltiples modos"
    echo -e "Wfuzz        Media      Limitada  Fuzzing múltiple, scripting"
    echo -e "Dirb         Baja       Sí        Preinstalada, simple"
    echo
    echo -e "${YELLOW}Recomendaciones:${NC}"
    echo -e "• ${GREEN}FFUF${NC}: Para la mayoría de casos, flexibilidad y rendimiento"
    echo -e "• ${GREEN}Feroxbuster${NC}: Para scans rápidos y grandes objetivos"
    echo -e "• ${GREEN}Gobuster${NC}: Para usuarios principiantes o scripts simples"
    echo -e "• ${GREEN}Wfuzz${NC}: Para fuzzing complejo con múltiples parámetros"
    echo -e "• ${GREEN}Dirb${NC}: Como herramienta básica cuando otras no están disponibles"
    
    show_footer
    press_enter
}

# Función para cambiar la URL objetivo
change_target_url() {
    show_header
    echo -e "${YELLOW}CAMBIO DE URL OBJETIVO${NC}"
    echo
    echo -e "URL actual: ${GREEN}$TARGET_URL${NC}"
    echo
    echo -n "Introduzca la nueva URL objetivo: "
    read new_url
    if [ ! -z "$new_url" ]; then
        TARGET_URL=$new_url
        echo -e "${GREEN}URL actualizada correctamente${NC}"
    else
        echo -e "${RED}URL no válida. No se realizaron cambios.${NC}"
    fi
    press_enter
}

# Función para mostrar el submenú de configuración
show_config_menu() {
    local option
    while true; do
        show_header
        echo -e "${YELLOW}CONFIGURACIÓN${NC}"
        echo
        echo -e "${CYAN}1.${NC} Cambiar URL Objetivo"
        echo -e "${CYAN}2.${NC} Configurar Wordlists"
        echo -e "${CYAN}3.${NC} Configurar Headers Personalizados"
        echo -e "${CYAN}4.${NC} Volver al menú principal"
        echo
        echo -n "Seleccione una opción: "
        read option
        
        case $option in
            1) change_target_url ;;
            2) show_wordlists_config ;;
            3) show_headers_config ;;
            4) break ;;
            *) 
                echo -e "${RED}Opción inválida${NC}"
                press_enter
                ;;
        esac
    done
}

# Función para configurar wordlists
show_wordlists_config() {
    show_header
    echo -e "${YELLOW}CONFIGURACIÓN DE WORDLISTS${NC}"
    echo
    echo -e "Directorio actual: ${GREEN}$WORDLIST_DIR${NC}"
    echo
    echo -e "${YELLOW}Wordlists disponibles:${NC}"
    find $WORDLIST_DIR -name "*.txt" | head -10 | nl
    echo
    echo -e "${YELLOW}Nota:${NC} Esta es solo una visualización. Para cambiar el directorio,"
    echo -e "edite la variable WORDLIST_DIR en el script."
    
    press_enter
}

# Función para configurar headers
show_headers_config() {
    show_header
    echo -e "${YELLOW}CONFIGURACIÓN DE HEADERS PERSONALIZADOS${NC}"
    echo
    echo -e "${YELLOW}Headers comunes utilizados en fuzzing:${NC}"
    echo
    echo -e "${CYAN}User-Agent:${NC}"
    echo "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"
    echo
    echo -e "${CYAN}Authorization:${NC}"
    echo "Basic YWRtaW46YWRtaW4="
    echo "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    echo
    echo -e "${CYAN}X-Forwarded-For:${NC}"
    echo "127.0.0.1"
    echo
    echo -e "${CYAN}Referer:${NC}"
    echo "$TARGET_URL"
    echo
    echo -e "${YELLOW}Ejemplo de uso:${NC}"
    echo "ffuf -w wordlist.txt -u $TARGET_URL/FUZZ \\"
    echo "     -H \"User-Agent: Custom Agent\" \\"
    echo "     -H \"X-Forwarded-For: 127.0.0.1\" \\"
    echo "     -H \"Authorization: Basic YWRtaW46YWRtaW4=\""
    
    press_enter
}

# Menú principal
while true; do
    show_main_menu
    read option
    
    case $option in
        1) show_files_dirs_menu ;;
        2) 
            CURRENT_CATEGORY="Parámetros"
            echo -e "${GREEN}Redirigiendo a Fuzzing de Parámetros...${NC}"
            sleep 1
            ;;
        3) 
            CURRENT_CATEGORY="VHOST y Subdominios"
            echo -e "${GREEN}Redirigiendo a Fuzzing de VHOST...${NC}"
            sleep 1
            ;;
        4) 
            CURRENT_CATEGORY="API REST"
            echo -e "${GREEN}Redirigiendo a Fuzzing de API...${NC}"
            sleep 1
            ;;
        5) 
            CURRENT_CATEGORY="Validación Manual"
            echo -e "${GREEN}Redirigiendo a Validación Manual...${NC}"
            sleep 1
            ;;
        6) show_config_menu ;;
        7) 
            echo -e "${GREEN}Saliendo de la guía de fuzzing. ¡Hasta pronto!${NC}"
            exit 0
            ;;
        *) 
            echo -e "${RED}Opción inválida${NC}"
            press_enter
            ;;
    esac
done
