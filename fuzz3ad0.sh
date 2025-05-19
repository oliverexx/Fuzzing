#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Función para mostrar el menú
show_menu() {
    echo -e "${GREEN}=== Guía de Sintaxis de Fuzzing ===${NC}"
    echo "1. Fuzzing de Directorios (ffuf)"
    echo "2. Fuzzing de Directorios (feroxbuster)"
    echo "3. Fuzzing de Directorios (gobuster)"
    echo "4. Fuzzing de Parámetros GET"
    echo "5. Fuzzing de Parámetros POST"
    echo "6. Fuzzing de Virtual Hosts"
    echo "7. Fuzzing de Subdominios"
    echo "8. Fuzzing de API"
    echo "9. Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar wordlists recomendadas
show_wordlists() {
    echo -e "\n${PURPLE}=== Wordlists Recomendadas ===${NC}"
    
    echo -e "\n${YELLOW}1. Discovery/Web-Content (Directorios y Archivos):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/${NC}"
    echo "   - common.txt (básico, rápido, ~4.5K entradas)"
    echo "   - directory-list-2.3-medium.txt (equilibrado, ~220K entradas)"
    echo "   - directory-list-2.3-big.txt (completo, ~1.2M entradas)"
    echo "   - raft-large-directories.txt (completo, ~60K entradas)"
    echo "   - big.txt (muy completo, ~2.2M entradas)"
    echo "   - raft-large-files.txt (archivos comunes, ~40K entradas)"
    echo "   - raft-large-words.txt (palabras comunes, ~3.1M entradas)"
    echo "   - directory-list-1.0.txt (clásico, ~140K entradas)"
    
    echo -e "\n${YELLOW}2. Discovery/DNS (Subdominios):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/DNS/${NC}"
    echo "   - subdomains-top1million-5000.txt (subdominios comunes, 5K entradas)"
    echo "   - subdomains-top1million-20000.txt (más subdominios, 20K entradas)"
    echo "   - dns-Jhaddix.txt (completo, ~1.1M entradas)"
    echo "   - subdomains-top1million-110000.txt (muy completo, 110K entradas)"
    echo "   - best-dns-wordlist.txt (optimizado, ~1M entradas)"
    
    echo -e "\n${YELLOW}3. Discovery/Web-Content (Parámetros y Valores):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/${NC}"
    echo "   - burp-parameter-names.txt (nombres de parámetros, ~2.5K entradas)"
    echo "   - common.txt (valores comunes, ~4.5K entradas)"
    echo "   - SQL.txt (inyecciones SQL, ~1.5K entradas)"
    echo "   - XSS.txt (XSS payloads, ~1.2K entradas)"
    echo "   - Command-Injection.txt (inyección de comandos, ~1K entradas)"
    echo "   - fuzz-BoF.txt (buffer overflow, ~500 entradas)"
    echo "   - PHP.fuzz.txt (PHP específico, ~1.8K entradas)"
    echo "   - JavaScript.fuzz.txt (JS específico, ~1.2K entradas)"
    
    echo -e "\n${YELLOW}4. Discovery/Web-Content (APIs):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/api/${NC}"
    echo "   - objects.txt (objetos API comunes)"
    echo "   - actions.txt (acciones API comunes)"
    echo "   - endpoints.txt (endpoints API comunes)"
    echo "   - parameters.txt (parámetros API comunes)"
    
    echo -e "\n${YELLOW}5. Discovery/Web-Content (Extensiones):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/${NC}"
    echo "   - extensions-common.txt (extensiones comunes)"
    echo "   - extensions-all.txt (todas las extensiones)"
    echo "   - extensions-asp.txt (ASP específico)"
    echo "   - extensions-jsp.txt (JSP específico)"
    echo "   - extensions-php.txt (PHP específico)"
    
    echo -e "\n${YELLOW}6. Discovery/Web-Content (Backups):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/${NC}"
    echo "   - backup-files.txt (archivos de backup comunes)"
    echo "   - backup-extensions.txt (extensiones de backup)"
    echo "   - backup-patterns.txt (patrones de backup)"
    
    echo -e "\n${YELLOW}7. Discovery/Web-Content (Configuración):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/${NC}"
    echo "   - configuration-files.txt (archivos de configuración)"
    echo "   - configuration-patterns.txt (patrones de configuración)"
    echo "   - sensitive-files.txt (archivos sensibles)"
    
    echo -e "\n${YELLOW}8. Discovery/Web-Content (CMS):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/cms/${NC}"
    echo "   - wordpress.txt (WordPress específico)"
    echo "   - drupal.txt (Drupal específico)"
    echo "   - joomla.txt (Joomla específico)"
    echo "   - magento.txt (Magento específico)"
    
    echo -e "\n${YELLOW}9. Discovery/Web-Content (Frameworks):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/frameworks/${NC}"
    echo "   - rails.txt (Ruby on Rails)"
    echo "   - django.txt (Django)"
    echo "   - laravel.txt (Laravel)"
    echo "   - symfony.txt (Symfony)"
    
    echo -e "\n${YELLOW}10. Discovery/Web-Content (Servicios):${NC}"
    echo -e "${GREEN}Ruta base: /usr/share/seclists/Discovery/Web-Content/services/${NC}"
    echo "   - aws.txt (AWS específico)"
    echo "   - azure.txt (Azure específico)"
    echo "   - gcp.txt (Google Cloud específico)"
    echo "   - kubernetes.txt (Kubernetes específico)"
    
    echo -e "\n${PURPLE}Notas:${NC}"
    echo "1. Todas las wordlists están en /usr/share/seclists/"
    echo "2. Los tamaños son aproximados y pueden variar"
    echo "3. Se recomienda empezar con wordlists pequeñas y escalar"
    echo "4. Algunas wordlists pueden requerir instalación adicional"
    echo "5. Considerar el contexto del objetivo al elegir wordlists"
    echo -e "6. Para usar una wordlist, copia la ruta base y añade el nombre del archivo"
    echo -e "   Ejemplo: /usr/share/seclists/Discovery/Web-Content/common.txt"
}

# Función para mostrar la sintaxis de ffuf
show_ffuf_syntax() {
    echo -e "\n${BLUE}=== Sintaxis Básica de ffuf ===${NC}"
    echo "ffuf -w WORDLIST -u URL/FUZZ [OPCIONES]"
    echo
    echo -e "${YELLOW}Parámetros principales:${NC}"
    echo "-w: Lista de palabras (wordlist)"
    echo "-u: URL objetivo (usar FUZZ como marcador)"
    echo "-v: Modo verbose"
    echo
    echo -e "${YELLOW}Opciones comunes:${NC}"
    echo "-recursion: Activa el fuzzing recursivo"
    echo "-recursion-depth: Profundidad de recursión (ej: 2)"
    echo "-rate: Tasa de solicitudes por segundo"
    echo "-e: Extensiones a probar (ej: .php,.html,.txt)"
    echo "-mc: Filtrar por códigos de estado (ej: 200,301,302)"
    echo "-fs: Filtrar por tamaño de respuesta"
    echo
    echo -e "${YELLOW}Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/FUZZ \\"
    echo "        -v"
    echo
    echo "2. Fuzzing recursivo con extensiones:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "        -u http://ejemplo.com/FUZZ \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2 \\"
    echo "        -e .php,.html,.txt,.bak,.js \\"
    echo "        -rate 500"
    echo
    echo "3. Fuzzing con filtrado:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/FUZZ \\"
    echo "        -mc 200,301,302 \\"
    echo "        -fs 0,1000"
    echo
    show_wordlists
}

# Función para mostrar la sintaxis de feroxbuster
show_feroxbuster_syntax() {
    echo -e "\n${BLUE}=== Sintaxis Básica de feroxbuster ===${NC}"
    echo "feroxbuster -u URL -w WORDLIST [OPCIONES]"
    echo
    echo -e "${YELLOW}Parámetros principales:${NC}"
    echo "-u: URL objetivo"
    echo "-w: Lista de palabras (wordlist)"
    echo "--depth: Profundidad de recursión"
    echo
    echo -e "${YELLOW}Opciones comunes:${NC}"
    echo "-x: Extensiones a probar (ej: tar.gz)"
    echo "--threads: Número de hilos concurrentes"
    echo "--dont-scan: Patrones a excluir"
    echo
    echo -e "${YELLOW}Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   feroxbuster -u http://ejemplo.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo
    echo "2. Fuzzing recursivo con extensiones:"
    echo "   feroxbuster -u http://ejemplo.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "               --depth 3 \\"
    echo "               -x tar.gz \\"
    echo "               --threads 30"
    echo
    echo "3. Fuzzing con exclusión de patrones:"
    echo "   feroxbuster -u http://ejemplo.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               --dont-scan '*.jpg,*.png'"
    echo
    show_wordlists
}

# Función para mostrar la sintaxis de gobuster
show_gobuster_syntax() {
    echo -e "\n${BLUE}=== Sintaxis Básica de gobuster ===${NC}"
    echo "gobuster dir -u URL -w WORDLIST [OPCIONES]"
    echo
    echo -e "${YELLOW}Parámetros principales:${NC}"
    echo "-u: URL objetivo"
    echo "-w: Lista de palabras (wordlist)"
    echo "-t: Número de hilos"
    echo
    echo -e "${YELLOW}Opciones comunes:${NC}"
    echo "-x: Extensiones a probar (ej: .html,.php,.txt)"
    echo "-s: Códigos de estado a incluir"
    echo "-q: Modo silencioso"
    echo
    echo -e "${YELLOW}Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   gobuster dir -u http://ejemplo.com \\"
    echo "                -w /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo
    echo "2. Fuzzing con extensiones:"
    echo "   gobuster dir -u http://ejemplo.com \\"
    echo "                -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "                -x .html,.php,.txt \\"
    echo "                -t 30"
    echo
    echo "3. Fuzzing con códigos de estado específicos:"
    echo "   gobuster dir -u http://ejemplo.com \\"
    echo "                -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "                -s 200,301,302"
    echo
    show_wordlists
}

# Función para mostrar la sintaxis de fuzzing de parámetros GET
show_get_param_syntax() {
    echo -e "\n${BLUE}=== Sintaxis de Fuzzing de Parámetros GET ===${NC}"
    echo "ffuf -w WORDLIST -u URL?param=FUZZ [OPCIONES]"
    echo
    echo -e "${YELLOW}Casos de uso comunes:${NC}"
    echo "1. Fuzzing de un solo parámetro:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/page.php?param=FUZZ"
    echo
    echo "2. Fuzzing de múltiples parámetros:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/page.php?param1=value&param2=FUZZ"
    echo
    echo "3. Fuzzing con filtrado por tamaño:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/page.php?param=FUZZ \\"
    echo "        -fs 0,1000"
    echo
    echo -e "${YELLOW}Wordlists recomendadas para parámetros:${NC}"
    echo "1. /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt"
    echo "2. /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo "3. /usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
}

# Función para mostrar la sintaxis de fuzzing de parámetros POST
show_post_param_syntax() {
    echo -e "\n${BLUE}=== Sintaxis de Fuzzing de Parámetros POST ===${NC}"
    echo "ffuf -w WORDLIST -u URL -X POST -H 'Content-Type: TYPE' -d 'param=FUZZ' [OPCIONES]"
    echo
    echo -e "${YELLOW}Formatos comunes:${NC}"
    echo "1. application/x-www-form-urlencoded:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/login \\"
    echo "        -X POST \\"
    echo "        -H 'Content-Type: application/x-www-form-urlencoded' \\"
    echo "        -d 'username=admin&password=FUZZ'"
    echo
    echo "2. application/json:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/api \\"
    echo "        -X POST \\"
    echo "        -H 'Content-Type: application/json' \\"
    echo "        -d '{\"param\":\"FUZZ\"}'"
    echo
    echo "3. multipart/form-data:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://ejemplo.com/upload \\"
    echo "        -X POST \\"
    echo "        -H 'Content-Type: multipart/form-data' \\"
    echo "        -F 'file=@/path/to/file;param=FUZZ'"
    echo
    echo -e "${YELLOW}Wordlists recomendadas para POST:${NC}"
    echo "1. /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt"
    echo "2. /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo "3. /usr/share/seclists/Discovery/Web-Content/raft-large-words.txt"
}

# Función para mostrar la sintaxis de fuzzing de virtual hosts
show_vhost_syntax() {
    echo -e "\n${BLUE}=== Sintaxis de Fuzzing de Virtual Hosts ===${NC}"
    echo "gobuster vhost -u URL -w WORDLIST [OPCIONES]"
    echo
    echo -e "${YELLOW}Parámetros principales:${NC}"
    echo "-u: URL objetivo"
    echo "-w: Lista de palabras (wordlist)"
    echo "--append-domain: Añade el dominio base a cada palabra"
    echo
    echo -e "${YELLOW}Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   gobuster vhost -u http://ejemplo.com \\"
    echo "                   -w /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo
    echo "2. Fuzzing con dominio base:"
    echo "   gobuster vhost -u http://ejemplo.com \\"
    echo "                   -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "                   --append-domain \\"
    echo "                   -t 50"
    echo
    echo -e "${YELLOW}Wordlists recomendadas para vhosts:${NC}"
    echo "1. /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo "2. /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo "3. /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt"
}

# Función para mostrar la sintaxis de fuzzing de subdominios
show_subdomain_syntax() {
    echo -e "\n${BLUE}=== Sintaxis de Fuzzing de Subdominios ===${NC}"
    echo "gobuster dns -d DOMAIN -w WORDLIST [OPCIONES]"
    echo
    echo -e "${YELLOW}Parámetros principales:${NC}"
    echo "-d: Dominio objetivo"
    echo "-w: Lista de palabras (wordlist)"
    echo
    echo -e "${YELLOW}Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   gobuster dns -d ejemplo.com \\"
    echo "                -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "2. Fuzzing con más subdominios:"
    echo "   gobuster dns -d ejemplo.com \\"
    echo "                -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt"
    echo
    echo -e "${YELLOW}Wordlists recomendadas para subdominios:${NC}"
    echo "1. /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo "2. /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt"
    echo "3. /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt"
}

# Función para mostrar la sintaxis de fuzzing de API
show_api_syntax() {
    echo -e "\n${BLUE}=== Sintaxis de Fuzzing de API ===${NC}"
    echo "ffuf -w WORDLIST -u URL/FUZZ [OPCIONES]"
    echo
    echo -e "${YELLOW}Casos de uso comunes:${NC}"
    echo "1. Descubrimiento de endpoints:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://api.ejemplo.com/FUZZ"
    echo
    echo "2. Fuzzing de parámetros en endpoints conocidos:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://api.ejemplo.com/users \\"
    echo "        -X POST \\"
    echo "        -H 'Content-Type: application/json' \\"
    echo "        -d '{\"param\":\"FUZZ\"}'"
    echo
    echo "3. Fuzzing de métodos HTTP:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://api.ejemplo.com/endpoint \\"
    echo "        -X FUZZ"
    echo
    echo -e "${YELLOW}Wordlists recomendadas para APIs:${NC}"
    echo "1. /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo "2. /usr/share/seclists/Discovery/Web-Content/api/objects.txt"
    echo "3. /usr/share/seclists/Discovery/Web-Content/api/actions.txt"
}

# Bucle principal
while true; do
    show_menu
    read -r option
    
    case $option in
        1) show_ffuf_syntax ;;
        2) show_feroxbuster_syntax ;;
        3) show_gobuster_syntax ;;
        4) show_get_param_syntax ;;
        5) show_post_param_syntax ;;
        6) show_vhost_syntax ;;
        7) show_subdomain_syntax ;;
        8) show_api_syntax ;;
        9) echo -e "${GREEN}Saliendo...${NC}"; exit 0 ;;
        *) echo -e "${RED}Opción inválida${NC}" ;;
    esac
    
    echo
    read -p "Presione Enter para continuar..."
    clear
done 
