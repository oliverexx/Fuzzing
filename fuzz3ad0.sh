#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Variable global para la URL
TARGET_URL=""

# Función para solicitar la URL
get_target_url() {
    local prompt="$1"
    echo -e "${GREEN}=== Configuración del Objetivo ===${NC}"
    echo -e "${YELLOW}$prompt${NC}"
    echo -n "Ingrese la URL objetivo (ej: http://ejemplo.com): "
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
    
    echo -e "${GREEN}URL objetivo configurada: ${YELLOW}$TARGET_URL${NC}"
    echo
    return 0
}

# Función para mostrar el menú
show_menu() {
    echo -e "${GREEN}=== GUÍA EXTENDIDA DE WEB FUZZING ===${NC}"
    echo
    echo -e "${YELLOW}URL objetivo actual: ${GREEN}$TARGET_URL${NC}"
    echo
    echo "1. Fuzzing de Directorios y Archivos"
    echo "2. Fuzzing de Parámetros y Valores"
    echo "3. Fuzzing de VHOST y Subdominios"
    echo "4. Filtrado de Respuestas"
    echo "5. Validación Manual"
    echo "6. Fuzzing de API REST"
    echo "7. Fuzzing de GraphQL"
    echo "8. Fuzzing de SOAP API"
    echo "9. Configuración y Uso de webfuzz_api"
    echo "10. Cambiar URL objetivo"
    echo "11. Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar la sección de directorios y archivos
show_directory_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE DIRECTORIOS Y ARCHIVOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Wordlists recomendadas:${NC}"
    echo "1. SecLists:"
    echo "   - /usr/share/seclists/Discovery/Web-Content/common.txt"
    echo "   - /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt"
    echo "   - /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt"
    echo "   - /usr/share/seclists/Discovery/Web-Content/big.txt"
    echo "   - /usr/share/seclists/Discovery/Web-Content/quickhits.txt"
    echo
    echo "2. Otras wordlists:"
    echo "   - /usr/share/dirb/wordlists/common.txt"
    echo "   - /usr/share/dirbuster/directory-list-2.3-medium.txt"
    echo "   - /usr/share/wordlists/dirb/common.txt"
    echo
    echo -e "${YELLOW}2. FFUF - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -e .html,.php \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2 \\"
    echo "        -rate 500"
    echo
    echo "2. Fuzzing de extensiones:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de extensiones con filtrado:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -mc 200 \\"
    echo "        -fs 0 \\"
    echo "        -fc 404"
    echo
    echo "4. Fuzzing de extensiones con recursión:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2"
    echo
    echo "5. Fuzzing de extensiones con salida JSON:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -of json \\"
    echo "        -o resultados.json"
    echo
    echo "6. Fuzzing de extensiones con autenticación:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -mc 200"
    echo
    echo "7. Fuzzing de extensiones con rate limit:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -rate 100 \\"
    echo "        -mc 200"
    echo
    echo "8. Fuzzing de extensiones con timeout:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ \\"
    echo "        -timeout 10 \\"
    echo "        -mc 200"
    echo
    echo "9. Fuzzing de extensiones con múltiples archivos:"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u $TARGET_URL/indexFUZZ,adminFUZZ,backupFUZZ \\"
    echo "        -mc 200"
    echo
    echo "10. Fuzzing de extensiones con filtrado avanzado:"
    echo "    ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "         -u $TARGET_URL/indexFUZZ \\"
    echo "         -mc 200 \\"
    echo "         -mr \"admin\" \\"
    echo "         -fr \"error\""
    echo
    echo -e "${YELLOW}3. GOBUSTER - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -x .html,.php,.txt \\"
    echo "            -t 30"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -s 200,204,301,302,307,401,403 \\"
    echo "            -b 404 \\"
    echo "            -t 50"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -r \\"
    echo "            -t 30"
    echo
    echo "4. Fuzzing con salida a archivo:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -o resultados.txt"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -H \"Authorization: Bearer token123\""
    echo
    echo "6. Fuzzing con exclusiones:"
    echo "   gobuster dir -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --exclude-length 0 \\"
    echo "            --exclude-text \"404\""
    echo
    echo -e "${YELLOW}4. FEROXBUSTER - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --depth 3 \\"
    echo "            -x tar.gz \\"
    echo "            --threads 30"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -C 404,403 \\"
    echo "            -S 1024 \\"
    echo "            --threads 30"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --depth 5 \\"
    echo "            --recursion"
    echo
    echo "4. Fuzzing con salida a archivo:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -o resultados.txt"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --headers \"Authorization: Bearer token123\""
    echo
    echo "6. Fuzzing con exclusiones:"
    echo "   feroxbuster -u $TARGET_URL \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -X \"error\" \\"
    echo "            -N 50"
    echo
    echo -e "${YELLOW}5. DIRB - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt"
    echo
    echo "2. Fuzzing con extensiones:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -X .php,.html"
    echo
    echo "3. Fuzzing con autenticación:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -u usuario:password"
    echo
    echo "4. Fuzzing con recursión:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -r"
    echo
    echo "5. Fuzzing con salida a archivo:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -o resultados.txt"
    echo
    echo "6. Fuzzing con exclusiones:"
    echo "   dirb $TARGET_URL /usr/share/dirb/wordlists/common.txt -N 404"
    echo
    echo -e "${YELLOW}6. WFUZZ - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt $TARGET_URL/FUZZ"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404,403 \\"
    echo "         $TARGET_URL/FUZZ"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -R 2 \\"
    echo "         $TARGET_URL/FUZZ"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         $TARGET_URL/FUZZ"
    echo
    echo "5. Fuzzing con salida a archivo:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -f resultados.txt \\"
    echo "         $TARGET_URL/FUZZ"
    echo
    echo "6. Fuzzing con múltiples parámetros:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "         $TARGET_URL/FUZZ1/FUZZ2"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo "6. Considera el rate limiting"
    echo "7. Usa filtros apropiados"
    echo "8. Mantén las herramientas actualizadas"
}

# Función para mostrar la sección de parámetros y valores
show_parameter_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE PARÁMETROS Y VALORES ===${NC}"
    echo
    echo -e "${YELLOW}1. FFUF - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing de parámetros GET:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"$TARGET_URL/page.php?param=FUZZ\" \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing de parámetros POST:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/login.php \\"
    echo "        -X POST \\"
    echo "        -d \"username=admin&password=FUZZ\" \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de parámetros JSON:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/api/login \\"
    echo "        -X POST \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{\"username\":\"admin\",\"password\":\"FUZZ\"}' \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing de múltiples parámetros:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "        -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "        -u \"$TARGET_URL/page.php?param1=FUZZ1&param2=FUZZ2\" \\"
    echo "        -mc 200"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"$TARGET_URL/api?param=FUZZ\" \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -mc 200"
    echo
    echo "6. Fuzzing con filtrado avanzado:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"$TARGET_URL/page.php?param=FUZZ\" \\"
    echo "        -mc 200 \\"
    echo "        -mr \"success\" \\"
    echo "        -fr \"error\""
    echo
    echo -e "${YELLOW}2. WFUZZ - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing de parámetros GET:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404 \\"
    echo "         \"$TARGET_URL/page.php?param=FUZZ\""
    echo
    echo "2. Fuzzing de parámetros POST:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -d \"username=admin&password=FUZZ\" \\"
    echo "         --hc 404 \\"
    echo "         $TARGET_URL/login.php"
    echo
    echo "3. Fuzzing de parámetros JSON:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Content-Type: application/json\" \\"
    echo "         -d '{\"username\":\"admin\",\"password\":\"FUZZ\"}' \\"
    echo "         --hc 404 \\"
    echo "         $TARGET_URL/api/login"
    echo
    echo "4. Fuzzing de múltiples parámetros:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "         --hc 404 \\"
    echo "         \"$TARGET_URL/page.php?param1=FUZZ1&param2=FUZZ2\""
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         --hc 404 \\"
    echo "         \"$TARGET_URL/api?param=FUZZ\""
    echo
    echo "6. Fuzzing con filtrado avanzado:"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404 \\"
    echo "         --hl 0 \\"
    echo "         --hw 0 \\"
    echo "         \"$TARGET_URL/page.php?param=FUZZ\""
    echo
    echo -e "${YELLOW}3. ARJUN - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   arjun -u $TARGET_URL/page.php"
    echo
    echo "2. Fuzzing con salida a archivo:"
    echo "   arjun -u $TARGET_URL/page.php -oJ resultados.json"
    echo
    echo "3. Fuzzing con métodos HTTP:"
    echo "   arjun -u $TARGET_URL/page.php -m GET,POST"
    echo
    echo "4. Fuzzing con headers:"
    echo "   arjun -u $TARGET_URL/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con data:"
    echo "   arjun -u $TARGET_URL/page.php -d \"username=admin\""
    echo
    echo "6. Fuzzing con wordlist personalizada:"
    echo "   arjun -u $TARGET_URL/page.php -w wordlist.txt"
    echo
    echo -e "${YELLOW}4. PARAMSPIDER - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   python3 paramspider.py --domain $TARGET_URL"
    echo
    echo "2. Fuzzing con salida a archivo:"
    echo "   python3 paramspider.py --domain $TARGET_URL --output params.txt"
    echo
    echo "3. Fuzzing con exclusión de subdominios:"
    echo "   python3 paramspider.py --domain $TARGET_URL --exclude api,admin"
    echo
    echo "4. Fuzzing con inclusión de subdominios:"
    echo "   python3 paramspider.py --domain $TARGET_URL --include api,admin"
    echo
    echo "5. Fuzzing con nivel de recursión:"
    echo "   python3 paramspider.py --domain $TARGET_URL --level 2"
    echo
    echo "6. Fuzzing con user agent:"
    echo "   python3 paramspider.py --domain $TARGET_URL --user-agent \"Mozilla/5.0\""
    echo
    echo -e "${YELLOW}5. PARAMETH - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php"
    echo
    echo "2. Fuzzing con salida a archivo:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php -o params.txt"
    echo
    echo "3. Fuzzing con métodos HTTP:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php -m GET,POST"
    echo
    echo "4. Fuzzing con headers:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con data:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php -d \"username=admin\""
    echo
    echo "6. Fuzzing con wordlist personalizada:"
    echo "   python3 parameth.py -u $TARGET_URL/page.php -w wordlist.txt"
    echo
    echo -e "${YELLOW}6. PARAMINATOR - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php"
    echo
    echo "2. Fuzzing con salida a archivo:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php -o params.txt"
    echo
    echo "3. Fuzzing con métodos HTTP:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php -m GET,POST"
    echo
    echo "4. Fuzzing con headers:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con data:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php -d \"username=admin\""
    echo
    echo "6. Fuzzing con wordlist personalizada:"
    echo "   python3 paraminator.py -u $TARGET_URL/page.php -w wordlist.txt"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo "6. Considera el rate limiting"
    echo "7. Usa filtros apropiados"
    echo "8. Mantén las herramientas actualizadas"
}

# Función para mostrar la sección de VHOST y subdominios
show_vhost_subdomain_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE VHOST Y SUBDOMINIOS ===${NC}"
    echo
    echo -e "${YELLOW}1. Configuración inicial:${NC}"
    echo "1. Editar /etc/hosts:"
    echo "   echo \"IP inlanefreight.htb\" | sudo tee -a /etc/hosts"
    echo
    echo "2. Verificar resolución DNS:"
    echo "   dig @8.8.8.8 inlanefreight.htb"
    echo "   nslookup inlanefreight.htb 8.8.8.8"
    echo
    echo -e "${YELLOW}2. FFUF - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico de VHOST:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "        -u http://FUZZ.academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -mc 200,204,301,302,307,401,403 \\"
    echo "        -fs 0"
    echo
    echo "2. Fuzzing con puerto específico (CTF):"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb:54651/ \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing con filtrado por tamaño:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 0-1000 \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing con múltiples filtros:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -mr \"admin\" \\"
    echo "        -fr \"error\""
    echo
    echo "5. Fuzzing con rate limit:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -rate 100"
    echo
    echo "6. Fuzzing con timeout:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -timeout 10"
    echo
    echo "7. Fuzzing con recursión:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2"
    echo
    echo "8. Fuzzing con salida JSON:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -of json \\"
    echo "        -o resultados.json"
    echo
    echo "9. Fuzzing con autenticación:"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://academy.htb \\"
    echo "        -H \"Host: FUZZ.academy.htb\" \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200"
    echo
    echo "10. Fuzzing con múltiples wordlists:"
    echo "    ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt:FUZZ2 \\"
    echo "         -u http://FUZZ1.FUZZ2.academy.htb \\"
    echo "         -H \"Host: FUZZ1.FUZZ2.academy.htb\" \\"
    echo "         -fs 985 \\"
    echo "         -mc 200"
    echo
    echo -e "${YELLOW}3. GOBUSTER - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico de VHOST:"
    echo "   gobuster vhost -u $TARGET_URL \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               --append-domain \\"
    echo "               -t 50"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   gobuster vhost -u $TARGET_URL \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               -s 200,204,301,302,307,401,403 \\"
    echo "               -b 404 \\"
    echo "               --append-domain"
    echo
    echo "3. Fuzzing DNS:"
    echo "   gobuster dns -d inlanefreight.com \\"
    echo "            -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "4. Fuzzing con salida a archivo:"
    echo "   gobuster vhost -u $TARGET_URL \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               -o resultados.txt"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   gobuster vhost -u $TARGET_URL \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               -H \"Authorization: Bearer token123\""
    echo
    echo "6. Fuzzing con exclusiones:"
    echo "   gobuster vhost -u $TARGET_URL \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               --exclude-length 0 \\"
    echo "               --exclude-text \"404\""
    echo
    echo -e "${YELLOW}4. SUBLIST3R - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   sublist3r -d academy.htb -o subdominios.txt"
    echo
    echo "2. Fuzzing con threads:"
    echo "   sublist3r -d academy.htb -t 40 -o subdominios.txt"
    echo
    echo "3. Fuzzing con búsqueda en motores:"
    echo "   sublist3r -d academy.htb -b -o subdominios.txt"
    echo
    echo "4. Fuzzing con timeout:"
    echo "   sublist3r -d academy.htb -t 40 -o subdominios.txt --timeout 30"
    echo
    echo "5. Fuzzing con verbose:"
    echo "   sublist3r -d academy.htb -v -o subdominios.txt"
    echo
    echo "6. Fuzzing con save:"
    echo "   sublist3r -d academy.htb -o subdominios.txt --save"
    echo
    echo -e "${YELLOW}5. AMASS - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing pasivo:"
    echo "   amass enum -passive -d academy.htb"
    echo
    echo "2. Fuzzing activo:"
    echo "   amass enum -active -d academy.htb"
    echo
    echo "3. Fuzzing con bruteforce:"
    echo "   amass enum -brute -d academy.htb"
    echo
    echo "4. Fuzzing con wordlist:"
    echo "   amass enum -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -d academy.htb"
    echo
    echo "5. Fuzzing con salida a archivo:"
    echo "   amass enum -passive -d academy.htb -o subdominios.txt"
    echo
    echo "6. Fuzzing con timeout:"
    echo "   amass enum -passive -d academy.htb -timeout 30"
    echo
    echo -e "${YELLOW}6. DNSRECON - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   dnsrecon -d academy.htb"
    echo
    echo "2. Fuzzing con wordlist:"
    echo "   dnsrecon -d academy.htb -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "3. Fuzzing con tipos de registro:"
    echo "   dnsrecon -d academy.htb -t A,AAAA,CNAME,MX,TXT"
    echo
    echo "4. Fuzzing con salida a archivo:"
    echo "   dnsrecon -d academy.htb -o resultados.xml"
    echo
    echo "5. Fuzzing con threads:"
    echo "   dnsrecon -d academy.htb -t 50"
    echo
    echo "6. Fuzzing con verbose:"
    echo "   dnsrecon -d academy.htb -v"
    echo
    echo -e "${YELLOW}7. VHOSTSCAN - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   vhostscan -t academy.htb"
    echo
    echo "2. Fuzzing con wordlist:"
    echo "   vhostscan -t academy.htb -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "3. Fuzzing con puerto:"
    echo "   vhostscan -t academy.htb -p 443"
    echo
    echo "4. Fuzzing con SSL:"
    echo "   vhostscan -t academy.htb -s"
    echo
    echo "5. Fuzzing con salida a archivo:"
    echo "   vhostscan -t academy.htb -o resultados.txt"
    echo
    echo "6. Fuzzing con verbose:"
    echo "   vhostscan -t academy.htb -v"
    echo
    echo -e "${YELLOW}8. WFUZZ - Múltiples sintaxis:${NC}"
    echo "1. Fuzzing básico:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.academy.htb\" \\"
    echo "         -u http://academy.htb \\"
    echo "         --hc 404"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.academy.htb\" \\"
    echo "         -u http://academy.htb \\"
    echo "         --hc 404 \\"
    echo "         --hl 0 \\"
    echo "         --hw 0"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.academy.htb\" \\"
    echo "         -u http://academy.htb \\"
    echo "         -R 2"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.academy.htb\" \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         -u http://academy.htb"
    echo
    echo "5. Fuzzing con salida a archivo:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.academy.htb\" \\"
    echo "         -u http://academy.htb \\"
    echo "         -f resultados.txt"
    echo
    echo "6. Fuzzing con múltiples parámetros:"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt:FUZZ2 \\"
    echo "         -H \"Host: FUZZ1.FUZZ2.academy.htb\" \\"
    echo "         -u http://academy.htb"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según el objetivo"
    echo "2. Usa diferentes wordlists para mejor cobertura"
    echo "3. Combina herramientas para mejores resultados"
    echo "4. Documenta los hallazgos importantes"
    echo "5. Valida manualmente los resultados"
    echo "6. Considera el rate limiting"
    echo "7. Usa filtros apropiados"
    echo "8. Mantén las herramientas actualizadas"
}

# Función para mostrar la sección de filtrado de respuestas
show_response_filtering() {
    echo -e "\n${BLUE}=== FILTRADO DE RESPUESTAS ===${NC}"
    echo
    echo -e "${YELLOW}1. FFUF - Filtrado básico:${NC}"
    echo "Opciones:"
    echo "-mc 200                # Coincidir código de estado"
    echo "-fc 404,403           # Filtrar códigos"
    echo "-ms 500-1000          # Coincidir tamaño de respuesta"
    echo "-fs 0-300             # Filtrar tamaño"
    echo "-mt >500              # Coincidir tiempo >500ms"
    echo "-fw 100               # Filtrar conteo de palabras"
    echo "-fl 20                # Filtrar conteo de líneas"
    echo "-s                    # Silencioso"
    echo "-v                    # Detallado"
    echo
    echo -e "${YELLOW}2. FFUF - Filtrado avanzado:${NC}"
    echo "Opciones:"
    echo "-mr \"admin\"          # Coincidir regex en respuesta"
    echo "-fr \"error\"          # Filtrar regex en respuesta"
    echo "-mr \"admin.*panel\"   # Coincidir múltiples regex"
    echo "-of json              # Salida en formato JSON"
    echo "-o resultados.json    # Guardar resultados"
    echo "-od /ruta/resultados  # Directorio de salida"
    echo
    echo -e "${YELLOW}3. Ejemplos de implementación FFUF:${NC}"
    echo "1. Fuzzing básico con filtrado de códigos:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -mc 200,301,302 \\"
    echo "        -fc 404,403"
    echo
    echo "2. Fuzzing con filtrado por tamaño y contenido:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -ms 500-1000 \\"
    echo "        -mr \"admin\" \\"
    echo "        -fr \"error\""
    echo
    echo "3. Fuzzing con filtrado por tiempo y palabras:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -mt >500 \\"
    echo "        -fw 100"
    echo
    echo "4. Fuzzing con salida JSON:"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -of json \\"
    echo "        -o resultados.json"
    echo
    echo -e "${YELLOW}4. GOBUSTER - Filtrado:${NC}"
    echo "Opciones:"
    echo "-s 200,301            # Incluir códigos específicos"
    echo "-b 404                # Excluir códigos específicos"
    echo "--exclude-length 0    # Excluir por longitud"
    echo "--exclude-text \"404\"  # Excluir por texto"
    echo "--exclude-regex \"error\" # Excluir por regex"
    echo
    echo -e "${YELLOW}5. FEROXBUSTER - Filtrado:${NC}"
    echo "Opciones:"
    echo "-C 404,500            # Filtrar por códigos HTTP"
    echo "-S 1024               # Filtrar por tamaño"
    echo "-W 0-10               # Filtrar por conteo de palabras"
    echo "-N 50                 # Filtrar por conteo de líneas"
    echo "-X \"error\"           # Filtrar cuerpo que coincida"
    echo
    echo -e "${YELLOW}6. WENUM - Filtrado:${NC}"
    echo "Opciones:"
    echo "--hc 404              # Ocultar código"
    echo "--sc 200,301          # Mostrar código"
    echo "--hl 5-10             # Ocultar por conteo de líneas"
    echo "--hw 20               # Ocultar por conteo de palabras"
    echo "--sr \"admin\"         # Mostrar respuestas que coincidan"
    echo "--hr \"Access Denied\" # Ocultar respuestas que coincidan"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta los valores de filtrado según el objetivo"
    echo "2. Combina diferentes filtros para resultados más precisos"
    echo "3. Usa el modo verbose (-v) para depuración"
    echo "4. Guarda los resultados en un archivo para análisis posterior"
    echo "5. Considera el rate limiting del servidor"
    echo "6. Prueba diferentes combinaciones de filtros"
    echo "7. Valida manualmente los resultados importantes"
}

# Función para mostrar la sección de validación manual
show_manual_validation() {
    echo -e "\n${BLUE}=== VALIDACIÓN MANUAL ===${NC}"
    echo
    echo -e "${YELLOW}1. Validación básica con curl:${NC}"
    echo "curl $TARGET_URL/backup/"
    echo "curl -I $TARGET_URL/backup/password.txt"
    echo
    echo -e "${YELLOW}2. Validación de headers:${NC}"
    echo "curl -H \"X-Forwarded-For: 127.0.0.1\" $TARGET_URL"
    echo "curl -H \"User-Agent: Mozilla/5.0\" $TARGET_URL"
    echo "curl -H \"Referer: https://google.com\" $TARGET_URL"
    echo
    echo -e "${YELLOW}3. Validación de cookies:${NC}"
    echo "curl -b \"session=abc123\" $TARGET_URL"
    echo "curl -b \"admin=true\" $TARGET_URL"
    echo
    echo -e "${YELLOW}4. Validación de métodos HTTP:${NC}"
    echo "curl -X OPTIONS $TARGET_URL"
    echo "curl -X HEAD $TARGET_URL"
    echo "curl -X TRACE $TARGET_URL"
    echo
    echo -e "${YELLOW}5. Validación de parámetros:${NC}"
    echo "curl \"$TARGET_URL/page.php?param=value\""
    echo "curl \"$TARGET_URL/page.php?param[]=value\""
    echo "curl \"$TARGET_URL/page.php?param=value&param2=value2\""
    echo
    echo -e "${YELLOW}6. Validación de contenido:${NC}"
    echo "curl -s $TARGET_URL | grep -i \"admin\""
    echo "curl -s $TARGET_URL | grep -i \"password\""
    echo "curl -s $TARGET_URL | grep -i \"error\""
    echo
    echo -e "${YELLOW}7. Validación de redirecciones:${NC}"
    echo "curl -L $TARGET_URL"
    echo "curl -I $TARGET_URL"
    echo
    echo -e "${YELLOW}8. Validación de SSL/TLS:${NC}"
    echo "curl -k $TARGET_URL"
    echo "openssl s_client -connect $TARGET_URL:443"
    echo
    echo -e "${YELLOW}9. Validación de archivos:${NC}"
    echo "curl -O $TARGET_URL/robots.txt"
    echo "curl -O $TARGET_URL/sitemap.xml"
    echo
    echo -e "${YELLOW}10. Validación de APIs:${NC}"
    echo "curl -H \"Content-Type: application/json\" $TARGET_URL/api"
    echo "curl -H \"Accept: application/json\" $TARGET_URL/api"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "- Usar -v para ver detalles completos de la petición"
    echo "- Usar -i para ver headers de respuesta"
    echo "- Usar -L para seguir redirecciones"
    echo "- Usar -k para ignorar certificados SSL"
    echo "- Usar -b para enviar cookies"
    echo "- Usar -H para enviar headers personalizados"
}

# Función para mostrar la sección de API REST
show_rest_api_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE API REST ===${NC}"
    echo
    echo -e "${YELLOW}1. Endpoints REST comunes:${NC}"
    echo "GET /items/"
    echo "GET /items/{id}"
    echo "POST /items/"
    echo "PUT /items/{id}"
    echo "DELETE /items/{id}"
    echo "curl $TARGET_URL/docs         # Swagger"
    echo
    echo -e "${YELLOW}2. Autenticación básica:${NC}"
    echo "curl -u usuario:password $TARGET_URL/api"
    echo "curl -H \"Authorization: Basic $(echo -n 'usuario:password' | base64)\" $TARGET_URL/api"
    echo
    echo -e "${YELLOW}3. Autenticación Bearer:${NC}"
    echo "curl -H \"Authorization: Bearer token123\" $TARGET_URL/api"
    echo "curl -H \"Authorization: Bearer $(cat token.txt)\" $TARGET_URL/api"
    echo
    echo -e "${YELLOW}4. Headers comunes:${NC}"
    echo "curl -H \"Content-Type: application/json\" $TARGET_URL/api"
    echo "curl -H \"Accept: application/json\" $TARGET_URL/api"
    echo "curl -H \"X-API-Key: key123\" $TARGET_URL/api"
    echo "curl -H \"X-Custom-Header: value\" $TARGET_URL/api"
    echo
    echo -e "${YELLOW}5. FFUF para API:${NC}"
    echo "1. Fuzzing de endpoints:"
    echo "   ffuf -X GET \\"
    echo "        -u $TARGET_URL/items/FUZZ \\"
    echo "        -w ids.txt \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing con autenticación:"
    echo "   ffuf -X GET \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -u $TARGET_URL/api/FUZZ \\"
    echo "        -w endpoints.txt \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de parámetros:"
    echo "   ffuf -X GET \\"
    echo "        -u $TARGET_URL/api?param=FUZZ \\"
    echo "        -w params.txt \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing de valores JSON:"
    echo "   ffuf -X POST \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{\"user\":\"FUZZ\"}' \\"
    echo "        -w values.txt \\"
    echo "        -u $TARGET_URL/api/login \\"
    echo "        -mc 200"
    echo
    echo -e "${YELLOW}6. Técnicas avanzadas:${NC}"
    echo "1. Fuzzing de versiones de API:"
    echo "   ffuf -u $TARGET_URL/vFUZZ/api \\"
    echo "        -w versions.txt \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing de métodos HTTP:"
    echo "   ffuf -X FUZZ \\"
    echo "        -u $TARGET_URL/api \\"
    echo "        -w methods.txt \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de headers:"
    echo "   ffuf -H \"FUZZ: value\" \\"
    echo "        -u $TARGET_URL/api \\"
    echo "        -w headers.txt \\"
    echo "        -mc 200"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Documenta los endpoints encontrados"
    echo "2. Prueba diferentes métodos HTTP"
    echo "3. Verifica la autenticación requerida"
    echo "4. Revisa los headers necesarios"
    echo "5. Considera el rate limiting"
    echo "6. Valida las respuestas manualmente"
    echo "7. Busca documentación (Swagger, OpenAPI)"
}

# Función para mostrar la sección de GraphQL
show_graphql_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE GRAPHQL ===${NC}"
    echo
    echo -e "${YELLOW}1. Introspección básica:${NC}"
    echo "curl -X POST $TARGET_URL/graphql \\"
    echo "     -H \"Content-Type: application/json\" \\"
    echo "     -d '{ \"query\": \"{ __schema { types { name } } }\" }'"
    echo
    echo -e "${YELLOW}2. Autenticación:${NC}"
    echo "1. Bearer Token:"
    echo "   curl -X POST $TARGET_URL/graphql \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{ \"query\": \"{ __schema { types { name } } }\" }'"
    echo
    echo "2. API Key:"
    echo "   curl -X POST $TARGET_URL/graphql \\"
    echo "        -H \"X-API-Key: key123\" \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{ \"query\": \"{ __schema { types { name } } }\" }'"
    echo
    echo -e "${YELLOW}3. Queries comunes:${NC}"
    echo "1. Query básica:"
    echo "query {"
    echo "  user(id: 123) {"
    echo "    name"
    echo "    email"
    echo "    posts(limit: 5) {"
    echo "      title"
    echo "      body"
    echo "    }"
    echo "  }"
    echo "}"
    echo
    echo "2. Query con variables:"
    echo "query GetUser(\$id: ID!) {"
    echo "  user(id: \$id) {"
    echo "    name"
    echo "    email"
    echo "  }"
    echo "}"
    echo
    echo -e "${YELLOW}4. Mutations:${NC}"
    echo "1. Crear usuario:"
    echo "mutation {"
    echo "  createUser(input: {"
    echo "    name: \"John Doe\""
    echo "    email: \"john@example.com\""
    echo "  }) {"
    echo "    id"
    echo "    name"
    echo "    email"
    echo "  }"
    echo "}"
    echo
    echo "2. Actualizar usuario:"
    echo "mutation {"
    echo "  updateUser(id: \"123\", input: {"
    echo "    name: \"Jane Doe\""
    echo "  }) {"
    echo "    id"
    echo "    name"
    echo "  }"
    echo "}"
    echo
    echo -e "${YELLOW}5. Técnicas de fuzzing:${NC}"
    echo "1. Fuzzing de campos:"
    echo "query {"
    echo "  __type(name: \"User\") {"
    echo "    fields {"
    echo "      name"
    echo "      type {"
    echo "        name"
    echo "      }"
    echo "    }"
    echo "  }"
    echo "}"
    echo
    echo "2. Fuzzing de argumentos:"
    echo "query {"
    echo "  user(id: FUZZ) {"
    echo "    name"
    echo "  }"
    echo "}"
    echo
    echo "3. Fuzzing de tipos:"
    echo "query {"
    echo "  __type(name: FUZZ) {"
    echo "    name"
    echo "    fields {"
    echo "      name"
    echo "    }"
    echo "  }"
    echo "}"
    echo
    echo -e "${YELLOW}6. Herramientas específicas:${NC}"
    echo "1. GraphQL Coprocessor:"
    echo "   graphql-cop -t $TARGET_URL/graphql -s schema.json"
    echo
    echo "2. GraphQL Map:"
    echo "   python3 graphqlmap.py -u $TARGET_URL/graphql"
    echo
    echo "3. InQL Scanner:"
    echo "   inql -t $TARGET_URL/graphql"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Verifica si la introspección está habilitada"
    echo "2. Prueba diferentes métodos de autenticación"
    echo "3. Documenta el esquema encontrado"
    echo "4. Busca campos sensibles"
    echo "5. Prueba inyecciones en argumentos"
    echo "6. Verifica el rate limiting"
    echo "7. Revisa los errores para información"
    echo "8. Considera usar herramientas especializadas"
}

# Función para mostrar la sección de SOAP API
show_soap_api_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE SOAP API ===${NC}"
    echo
    echo -e "${YELLOW}1. Estructura básica SOAP:${NC}"
    echo "POST /api HTTP/1.1"
    echo "Content-Type: text/xml"
    echo "SOAPAction: \"http://example.com/GetStockPrice\""
    echo
    echo "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    echo "  <Body>"
    echo "    <GetStockPrice xmlns=\"http://example.com/stocks\">"
    echo "      <StockName>AAPL</StockName>"
    echo "    </GetStockPrice>"
    echo "  </Body>"
    echo "</Envelope>"
    echo
    echo -e "${YELLOW}2. Autenticación:${NC}"
    echo "1. Basic Auth:"
    echo "POST /api HTTP/1.1"
    echo "Authorization: Basic $(echo -n 'user:pass' | base64)"
    echo "Content-Type: text/xml"
    echo
    echo "2. WS-Security:"
    echo "<Envelope>"
    echo "  <Header>"
    echo "    <Security>"
    echo "      <UsernameToken>"
    echo "        <Username>user</Username>"
    echo "        <Password>pass</Password>"
    echo "      </UsernameToken>"
    echo "    </Security>"
    echo "  </Header>"
    echo "  <Body>...</Body>"
    echo "</Envelope>"
    echo
    echo -e "${YELLOW}3. Técnicas de fuzzing:${NC}"
    echo "1. Fuzzing de parámetros:"
    echo "<GetStockPrice>"
    echo "  <StockName>FUZZ</StockName>"
    echo "</GetStockPrice>"
    echo
    echo "2. Fuzzing de métodos:"
    echo "<FUZZ>"
    echo "  <param>value</param>"
    echo "</FUZZ>"
    echo
    echo "3. Fuzzing de namespaces:"
    echo "<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    echo "  <Body>"
    echo "    <GetStockPrice xmlns=\"FUZZ\">"
    echo "      <StockName>AAPL</StockName>"
    echo "    </GetStockPrice>"
    echo "  </Body>"
    echo "</Envelope>"
    echo
    echo -e "${YELLOW}4. Herramientas recomendadas:${NC}"
    echo "1. SoapUI:"
    echo "   - Crear proyecto SOAP"
    echo "   - Importar WSDL"
    echo "   - Generar requests"
    echo "   - Ejecutar pruebas"
    echo
    echo "2. Burp Suite:"
    echo "   - Interceptar tráfico SOAP"
    echo "   - Modificar requests"
    echo "   - Analizar respuestas"
    echo "   - Fuzzing automático"
    echo
    echo "3. Wireshark:"
    echo "   - Capturar tráfico SOAP"
    echo "   - Analizar protocolo"
    echo "   - Filtrar por SOAP"
    echo
    echo -e "${YELLOW}5. Ejemplos de requests:${NC}"
    echo "1. Consulta simple:"
    echo "curl -X POST $TARGET_URL/api \\"
    echo "     -H \"Content-Type: text/xml\" \\"
    echo "     -H \"SOAPAction: \\\"http://example.com/GetStockPrice\\\"\" \\"
    echo "     -d @request.xml"
    echo
    echo "2. Consulta con autenticación:"
    echo "curl -X POST $TARGET_URL/api \\"
    echo "     -H \"Content-Type: text/xml\" \\"
    echo "     -H \"Authorization: Basic $(echo -n 'user:pass' | base64)\" \\"
    echo "     -d @request.xml"
    echo
    echo -e "${YELLOW}6. Análisis WSDL:${NC}"
    echo "1. Obtener WSDL:"
    echo "curl $TARGET_URL?wsdl"
    echo
    echo "2. Analizar endpoints:"
    echo "grep -i \"<soap:address\" wsdl.xml"
    echo
    echo "3. Extraer métodos:"
    echo "grep -i \"<operation name=\" wsdl.xml"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Busca el archivo WSDL para entender la API"
    echo "2. Verifica los métodos disponibles"
    echo "3. Prueba diferentes tipos de autenticación"
    echo "4. Analiza las respuestas de error"
    echo "5. Considera el rate limiting"
    echo "6. Documenta los endpoints encontrados"
    echo "7. Prueba inyecciones XML"
    echo "8. Verifica la validación de entrada"
}

# Función para mostrar consejos finales
show_final_tips() {
    echo -e "\n${BLUE}=== CONSEJOS FINALES ===${NC}"
    echo
    echo -e "${YELLOW}Recomendaciones generales:${NC}"
    echo "- Usar Seclists como base: /usr/share/seclists/"
    echo "- Validar con curl antes de automatizar"
    echo "- Fuzzing ≠ Exploiting: ser ético, no dañar los sistemas"
    echo "- Ajustar los filtros para no perder resultados relevantes"
    echo "- Mantener un registro de los resultados"
    echo "- Documentar los hallazgos importantes"
    echo "- Realizar pruebas en un entorno controlado"
    echo "- Respetar los límites de rate y tiempo de respuesta"
}

# Función para mostrar la sintaxis de fuzzing de API con webfuzz_api
show_webfuzz_api_syntax() {
    echo -e "\n${BLUE}=== Configuración y Uso de webfuzz_api ===${NC}"
    echo
    echo -e "${YELLOW}1. Configuración inicial:${NC}"
    echo "   git clone https://github.com/PandaSt0rm/webfuzz_api.git"
    echo "   cd webfuzz_api"
    echo "   python3 -m venv venv"
    echo "   source venv/bin/activate"
    echo "   pip3 install -r requirements.txt"
    echo
    echo -e "${YELLOW}2. Uso básico:${NC}"
    echo "   python3 webfuzz.py -u $TARGET_URL"
    echo
    echo -e "${YELLOW}3. Opciones principales:${NC}"
    echo "-u: URL objetivo"
    echo "-w: Lista de palabras personalizada"
    echo "-t: Número de hilos"
    echo "-o: Archivo de salida"
    echo "-v: Modo detallado"
    echo
    echo -e "${YELLOW}4. Ejemplos de uso:${NC}"
    echo "1. Fuzzing básico:"
    echo "   python3 webfuzz.py -u $TARGET_URL"
    echo
    echo "2. Fuzzing con lista de palabras personalizada:"
    echo "   python3 webfuzz.py -u $TARGET_URL -w lista_personalizada.txt"
    echo
    echo "3. Fuzzing con múltiples hilos:"
    echo "   python3 webfuzz.py -u $TARGET_URL -t 10"
    echo
    echo "4. Fuzzing con salida a archivo:"
    echo "   python3 webfuzz.py -u $TARGET_URL -o resultados.txt"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Asegúrate de tener Python 3.x instalado en tu sistema"
    echo "2. El entorno virtual debe estar activado antes de usar la herramienta"
    echo "3. Verifica que todas las dependencias estén instaladas correctamente"
    echo "4. Esta herramienta es especialmente útil para APIs REST"
    echo "5. Mantén el entorno virtual activado mientras uses la herramienta"
    echo "6. Si encuentras errores, verifica la instalación de las dependencias"
}

# Función para mostrar la sección de troubleshooting
show_troubleshooting() {
    echo -e "\n${BLUE}=== SOLUCIÓN DE PROBLEMAS ===${NC}"
    echo
    echo -e "${YELLOW}1. Problemas comunes:${NC}"
    echo "1. Rate limiting:"
    echo "   - Reducir velocidad de requests"
    echo "   - Usar proxies rotativos"
    echo "   - Implementar delays"
    echo
    echo "2. Timeouts:"
    echo "   - Aumentar tiempo de espera"
    echo "   - Verificar conectividad"
    echo "   - Comprobar firewall"
    echo
    echo "3. Errores de autenticación:"
    echo "   - Verificar credenciales"
    echo "   - Comprobar formato de tokens"
    echo "   - Revisar headers"
    echo
    echo -e "${YELLOW}2. Soluciones:${NC}"
    echo "1. Para rate limiting:"
    echo "   ffuf -w wordlist.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -rate 100 \\"
    echo "        -p 0.1"
    echo
    echo "2. Para timeouts:"
    echo "   ffuf -w wordlist.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -timeout 10"
    echo
    echo "3. Para autenticación:"
    echo "   ffuf -w wordlist.txt \\"
    echo "        -u $TARGET_URL/FUZZ \\"
    echo "        -H \"Authorization: Bearer token\""
    echo
    echo -e "${YELLOW}3. Herramientas de diagnóstico:${NC}"
    echo "1. curl:"
    echo "   curl -v $TARGET_URL"
    echo "   curl -I $TARGET_URL"
    echo
    echo "2. netcat:"
    echo "   nc -v $TARGET_URL 80"
    echo "   nc -v $TARGET_URL 443"
    echo
    echo "3. nmap:"
    echo "   nmap -p 80,443 $TARGET_URL"
    echo "   nmap -sV $TARGET_URL"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Documenta los errores encontrados"
    echo "2. Prueba diferentes configuraciones"
    echo "3. Verifica logs del servidor"
    echo "4. Comprueba la conectividad"
    echo "5. Valida las credenciales"
    echo "6. Revisa los headers"
    echo "7. Considera usar VPN"
    echo "8. Mantén un registro de soluciones"
}

# Función para mostrar best practices
show_best_practices() {
    echo -e "\n${BLUE}=== MEJORES PRÁCTICAS ===${NC}"
    echo
    echo -e "${YELLOW}1. Preparación:${NC}"
    echo "1. Documentación:"
    echo "   - Documentar el objetivo"
    echo "   - Registrar endpoints"
    echo "   - Mantener logs"
    echo
    echo "2. Configuración:"
    echo "   - Usar wordlists apropiadas"
    echo "   - Configurar timeouts"
    echo "   - Ajustar rate limiting"
    echo
    echo -e "${YELLOW}2. Durante el fuzzing:${NC}"
    echo "1. Monitoreo:"
    echo "   - Supervisar recursos"
    echo "   - Verificar respuestas"
    echo "   - Analizar errores"
    echo
    echo "2. Ajustes:"
    echo "   - Modificar velocidad"
    echo "   - Ajustar filtros"
    echo "   - Cambiar wordlists"
    echo
    echo -e "${YELLOW}3. Seguridad:${NC}"
    echo "1. Ética:"
    echo "   - Obtener permiso"
    echo "   - Respetar límites"
    echo "   - No causar daño"
    echo
    echo "2. Protección:"
    echo "   - Usar VPN"
    echo "   - Rotar IPs"
    echo "   - Ocultar identidad"
    echo
    echo -e "${YELLOW}4. Optimización:${NC}"
    echo "1. Rendimiento:"
    echo "   - Usar múltiples hilos"
    echo "   - Optimizar wordlists"
    echo "   - Filtrar resultados"
    echo
    echo "2. Eficiencia:"
    echo "   - Priorizar objetivos"
    echo "   - Automatizar tareas"
    echo "   - Reutilizar resultados"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Siempre obtén autorización"
    echo "2. Documenta todo el proceso"
    echo "3. Mantén copias de seguridad"
    echo "4. Valida los resultados"
    echo "5. Respeta los límites"
    echo "6. Usa herramientas apropiadas"
    echo "7. Mantén las herramientas actualizadas"
    echo "8. Comparte conocimiento"
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

    show_menu
    read -r option
    
    case $option in
        1) show_directory_fuzzing ;;
        2) show_parameter_fuzzing ;;
        3) show_vhost_subdomain_fuzzing ;;
        4) show_response_filtering ;;
        5) show_manual_validation ;;
        6) show_rest_api_fuzzing ;;
        7) show_graphql_fuzzing ;;
        8) show_soap_api_fuzzing ;;
        9) show_webfuzz_api_syntax ;;
        10) get_target_url "Cambiar URL objetivo" ;;
        11) echo -e "${GREEN}Saliendo...${NC}"; exit 0 ;;
        *) echo -e "${RED}Opción inválida${NC}" ;;
    esac
    
    echo
    read -p "Presione Enter para continuar..."
    clear
done 
