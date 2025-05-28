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
    echo -e "${BLUE}Redes:${NC}"
    echo -e "${YELLOW}LinkedIn:${NC} www.linkedin.com/in/axel-tear"
    echo -e "${YELLOW}GitHub:${NC} https://github.com/oliverexx"
    echo
    echo "1. Fuzzing de Directorios y Archivos"
    echo "2. Fuzzing de Parámetros y Valores"
    echo "3. Fuzzing de VHOST y Subdominios"
    echo "4. Validación Manual"
    echo "5. Fuzzing de API REST"
    echo "6. Configuración y Uso de webfuzz_api"
    echo "7. Salir"
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
    echo -e "${YELLOW}2. FFUF - Técnicas de Fuzzing:${NC}"
    echo "1. Fuzzing básico (directorios + extensiones + recursión):"
    echo "   # Busca directorios y archivos con extensiones .html y .php"
    echo "   # La recursión permite buscar en subdirectorios hasta 2 niveles"
    echo "   # Rate limit de 500 peticiones por segundo"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://asdas.com/FUZZ \\"
    echo "        -e .html,.php \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2 \\"
    echo "        -rate 500"
    echo
    echo "2. Fuzzing de extensiones de archivo:"
    echo "   # Prueba diferentes extensiones para un archivo específico (index)"
    echo "   # Útil para encontrar versiones de archivos (index.php, index.html, etc.)"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing con filtrado de respuestas:"
    echo "   # Filtra respuestas por tamaño (-fs) y código de estado (-mc)"
    echo "   # -fs 0: ignora respuestas vacías"
    echo "   # -fc 404: ignora respuestas con código 404"
    echo "   # -mr \"admin\": solo muestra respuestas que contengan \"admin\""
    echo "   # -fr \"error\": ignora respuestas que contengan \"error\""
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -mc 200 \\"
    echo "        -fs 0 \\"
    echo "        -fc 404 \\"
    echo "        -mr \"admin\" \\"
    echo "        -fr \"error\""
    echo
    echo "4. Fuzzing recursivo de extensiones:"
    echo "   # Combina búsqueda de extensiones con recursión"
    echo "   # Útil para encontrar archivos con diferentes extensiones en subdirectorios"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación en las peticiones"
    echo "   # Útil para acceder a áreas protegidas"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -mc 200"
    echo
    echo "6. Fuzzing con control de velocidad:"
    echo "   # Limita las peticiones a 100 por segundo"
    echo "   # Útil para evitar bloqueos por rate limiting"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -rate 100 \\"
    echo "        -mc 200"
    echo
    echo "7. Fuzzing con timeout:"
    echo "   # Establece un tiempo máximo de espera de 10 segundos por petición"
    echo "   # Útil para evitar peticiones que se quedan colgadas"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ \\"
    echo "        -timeout 10 \\"
    echo "        -mc 200"
    echo
    echo "8. Fuzzing de múltiples archivos:"
    echo "   # Prueba diferentes nombres de archivo con extensiones"
    echo "   # Útil para encontrar versiones de archivos importantes"
    echo "   ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ \\"
    echo "        -u http://asdas.com/indexFUZZ,adminFUZZ,backupFUZZ \\"
    echo "        -mc 200"
    echo
    echo -e "${YELLOW}3. GOBUSTER - Técnicas de Fuzzing:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Búsqueda de directorios con extensiones comunes"
    echo "   # -x: especifica las extensiones a probar"
    echo "   # -t: número de hilos concurrentes"
    echo "   gobuster dir -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -x .html,.php,.txt \\"
    echo "            -t 30"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   # Filtra por códigos de estado HTTP"
    echo "   # -s: incluye códigos específicos"
    echo "   # -b: excluye códigos específicos"
    echo "   gobuster dir -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -s 200,204,301,302,307,401,403 \\"
    echo "            -b 404 \\"
    echo "            -t 50"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   # Busca en subdirectorios encontrados"
    echo "   # -r: habilita la recursión"
    echo "   gobuster dir -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -r \\"
    echo "            -t 30"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación en las peticiones"
    echo "   # Útil para acceder a áreas protegidas"
    echo "   gobuster dir -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -H \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con exclusiones:"
    echo "   # Excluye respuestas por longitud o contenido"
    echo "   # --exclude-length: ignora respuestas de cierta longitud"
    echo "   # --exclude-text: ignora respuestas que contengan cierto texto"
    echo "   gobuster dir -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --exclude-length 0 \\"
    echo "            --exclude-text \"404\""
    echo
    echo -e "${YELLOW}4. FEROXBUSTER - Técnicas de Fuzzing:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Búsqueda rápida y eficiente de directorios"
    echo "   # --depth: profundidad máxima de recursión"
    echo "   # -x: extensiones a probar"
    echo "   feroxbuster -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --depth 3 \\"
    echo "            -x tar.gz \\"
    echo "            --threads 30"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   # Filtra por códigos HTTP y tamaño de respuesta"
    echo "   # -C: excluye códigos HTTP"
    echo "   # -S: excluye por tamaño de respuesta"
    echo "   feroxbuster -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -C 404,403 \\"
    echo "            -S 1024 \\"
    echo "            --threads 30"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   # Búsqueda recursiva en subdirectorios"
    echo "   # --depth: controla la profundidad de la recursión"
    echo "   feroxbuster -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --depth 5 \\"
    echo "            --recursion"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   # Incluye headers de autenticación"
    echo "   # --headers: permite agregar headers personalizados"
    echo "   feroxbuster -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            --headers \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con exclusiones:"
    echo "   # Excluye respuestas por contenido o número de líneas"
    echo "   # -X: excluye respuestas que contengan cierto texto"
    echo "   # -N: excluye por número de líneas"
    echo "   feroxbuster -u http://asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt \\"
    echo "            -X \"error\" \\"
    echo "            -N 50"
    echo
    echo -e "${YELLOW}5. DIRB - Técnicas de Fuzzing:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta clásica para búsqueda de directorios"
    echo "   # Sintaxis simple y directa"
    echo "   dirb http://asdas.com /usr/share/dirb/wordlists/common.txt"
    echo
    echo "2. Fuzzing con extensiones:"
    echo "   # Prueba diferentes extensiones de archivo"
    echo "   # -X: especifica las extensiones a probar"
    echo "   dirb http://asdas.com /usr/share/dirb/wordlists/common.txt -X .php,.html"
    echo
    echo "3. Fuzzing con autenticación:"
    echo "   # Incluye credenciales de autenticación"
    echo "   # -u: formato usuario:contraseña"
    echo "   dirb http://asdas.com /usr/share/dirb/wordlists/common.txt -u usuario:password"
    echo
    echo "4. Fuzzing con recursión:"
    echo "   # Busca en subdirectorios encontrados"
    echo "   # -r: habilita la recursión"
    echo "   dirb http://asdas.com /usr/share/dirb/wordlists/common.txt -r"
    echo
    echo "5. Fuzzing con exclusiones:"
    echo "   # Excluye respuestas por código HTTP"
    echo "   # -N: excluye códigos HTTP específicos"
    echo "   dirb http://asdas.com /usr/share/dirb/wordlists/common.txt -N 404"
    echo
    echo -e "${YELLOW}6. WFUZZ - Técnicas de Fuzzing:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta flexible para fuzzing web"
    echo "   # FUZZ: palabra clave para el reemplazo"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt http://asdas.com/FUZZ"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   # Filtra por códigos HTTP"
    echo "   # --hc: oculta códigos específicos"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404,403 \\"
    echo "         http://asdas.com/FUZZ"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   # Busca en subdirectorios encontrados"
    echo "   # -R: nivel de recursión"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -R 2 \\"
    echo "         http://asdas.com/FUZZ"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación"
    echo "   # -H: agrega headers personalizados"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         http://asdas.com/FUZZ"
    echo
    echo "5. Fuzzing con múltiples parámetros:"
    echo "   # Prueba múltiples palabras clave simultáneamente"
    echo "   # FUZZ1, FUZZ2: diferentes palabras clave"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "         http://asdas.com/FUZZ1/FUZZ2"
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
    echo -e "${YELLOW}1. FFUF - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing de parámetros GET:"
    echo "   # Prueba diferentes valores para un parámetro GET"
    echo "   # Útil para encontrar parámetros ocultos o vulnerables"
    echo "   # -mc 200: solo muestra respuestas con código 200"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"http://asdas.com/page.php?param=FUZZ\" \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing de parámetros POST:"
    echo "   # Prueba diferentes valores en formularios POST"
    echo "   # -X POST: especifica el método HTTP"
    echo "   # -d: define los datos a enviar"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://asdas.com/login.php \\"
    echo "        -X POST \\"
    echo "        -d \"username=admin&password=FUZZ\" \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de parámetros JSON:"
    echo "   # Prueba diferentes valores en peticiones JSON"
    echo "   # -H: define el Content-Type como JSON"
    echo "   # -d: envía datos en formato JSON"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u http://asdas.com/api/login \\"
    echo "        -X POST \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{\"username\":\"admin\",\"password\":\"FUZZ\"}' \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing de múltiples parámetros:"
    echo "   # Prueba diferentes valores para varios parámetros"
    echo "   # FUZZ1, FUZZ2: diferentes palabras clave"
    echo "   # Útil para encontrar combinaciones de parámetros"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "        -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "        -u \"http://asdas.com/page.php?param1=FUZZ1&param2=FUZZ2\" \\"
    echo "        -mc 200"
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación en las peticiones"
    echo "   # Útil para probar endpoints protegidos"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"http://asdas.com/api?param=FUZZ\" \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -mc 200"
    echo
    echo "6. Fuzzing con filtrado avanzado:"
    echo "   # Filtra respuestas por contenido específico"
    echo "   # -mr: solo muestra respuestas que contengan el texto"
    echo "   # -fr: ignora respuestas que contengan el texto"
    echo "   ffuf -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "        -u \"http://asdas.com/page.php?param=FUZZ\" \\"
    echo "        -mc 200 \\"
    echo "        -mr \"success\" \\"
    echo "        -fr \"error\""
    echo
    echo -e "${YELLOW}2. WFUZZ - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing de parámetros GET:"
    echo "   # Prueba diferentes valores para parámetros GET"
    echo "   # --hc 404: oculta respuestas con código 404"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404 \\"
    echo "         \"http://asdas.com/page.php?param=FUZZ\""
    echo
    echo "2. Fuzzing de parámetros POST:"
    echo "   # Prueba diferentes valores en formularios POST"
    echo "   # -d: define los datos a enviar"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -d \"username=admin&password=FUZZ\" \\"
    echo "         --hc 404 \\"
    echo "         http://asdas.com/login.php"
    echo
    echo "3. Fuzzing de parámetros JSON:"
    echo "   # Prueba diferentes valores en peticiones JSON"
    echo "   # -H: define el Content-Type como JSON"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Content-Type: application/json\" \\"
    echo "         -d '{\"username\":\"admin\",\"password\":\"FUZZ\"}' \\"
    echo "         --hc 404 \\"
    echo "         http://asdas.com/api/login"
    echo
    echo "4. Fuzzing de múltiples parámetros:"
    echo "   # Prueba diferentes valores para varios parámetros"
    echo "   # FUZZ1, FUZZ2: diferentes palabras clave"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/Web-Content/common.txt:FUZZ2 \\"
    echo "         --hc 404 \\"
    echo "         \"http://asdas.com/page.php?param1=FUZZ1&param2=FUZZ2\""
    echo
    echo "5. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación en las peticiones"
    echo "   # -H: agrega headers personalizados"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         --hc 404 \\"
    echo "         \"http://asdas.com/api?param=FUZZ\""
    echo
    echo "6. Fuzzing con filtrado avanzado:"
    echo "   # Filtra respuestas por tamaño y contenido"
    echo "   # --hl: oculta por número de líneas"
    echo "   # --hw: oculta por número de palabras"
    echo "   wfuzz -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "         --hc 404 \\"
    echo "         --hl 0 \\"
    echo "         --hw 0 \\"
    echo "         \"http://asdas.com/page.php?param=FUZZ\""
    echo
    echo -e "${YELLOW}3. ARJUN - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta especializada en descubrimiento de parámetros"
    echo "   # Detecta automáticamente parámetros ocultos"
    echo "   arjun -u http://asdas.com/page.php"
    echo
    echo "2. Fuzzing con métodos HTTP:"
    echo "   # Prueba diferentes métodos HTTP"
    echo "   # -m: especifica los métodos a probar"
    echo "   arjun -u http://asdas.com/page.php -m GET,POST"
    echo
    echo "3. Fuzzing con headers:"
    echo "   # Incluye headers personalizados"
    echo "   # -H: agrega headers a las peticiones"
    echo "   arjun -u http://asdas.com/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "4. Fuzzing con data:"
    echo "   # Incluye datos en las peticiones"
    echo "   # -d: define los datos a enviar"
    echo "   arjun -u http://asdas.com/page.php -d \"username=admin\""
    echo
    echo "5. Fuzzing con wordlist personalizada:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   arjun -u http://asdas.com/page.php -w wordlist.txt"
    echo
    echo -e "${YELLOW}4. PARAMSPIDER - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta para descubrir parámetros en todo el dominio"
    echo "   # --domain: especifica el dominio objetivo"
    echo "   python3 paramspider.py --domain asdas.com"
    echo
    echo "2. Fuzzing con exclusión de subdominios:"
    echo "   # Excluye subdominios específicos"
    echo "   # --exclude: lista de subdominios a excluir"
    echo "   python3 paramspider.py --domain asdas.com --exclude api,admin"
    echo
    echo "3. Fuzzing con inclusión de subdominios:"
    echo "   # Solo incluye subdominios específicos"
    echo "   # --include: lista de subdominios a incluir"
    echo "   python3 paramspider.py --domain asdas.com --include api,admin"
    echo
    echo "4. Fuzzing con nivel de recursión:"
    echo "   # Controla la profundidad de la búsqueda"
    echo "   # --level: nivel máximo de recursión"
    echo "   python3 paramspider.py --domain asdas.com --level 2"
    echo
    echo "5. Fuzzing con user agent:"
    echo "   # Personaliza el User-Agent"
    echo "   # --user-agent: especifica el User-Agent"
    echo "   python3 paramspider.py --domain asdas.com --user-agent \"Mozilla/5.0\""
    echo
    echo -e "${YELLOW}5. PARAMETH - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta para descubrir parámetros HTTP"
    echo "   # -u: especifica la URL objetivo"
    echo "   python3 parameth.py -u http://asdas.com/page.php"
    echo
    echo "2. Fuzzing con métodos HTTP:"
    echo "   # Prueba diferentes métodos HTTP"
    echo "   # -m: especifica los métodos a probar"
    echo "   python3 parameth.py -u http://asdas.com/page.php -m GET,POST"
    echo
    echo "3. Fuzzing con headers:"
    echo "   # Incluye headers personalizados"
    echo "   # -H: agrega headers a las peticiones"
    echo "   python3 parameth.py -u http://asdas.com/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "4. Fuzzing con data:"
    echo "   # Incluye datos en las peticiones"
    echo "   # -d: define los datos a enviar"
    echo "   python3 parameth.py -u http://asdas.com/page.php -d \"username=admin\""
    echo
    echo "5. Fuzzing con wordlist personalizada:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   python3 parameth.py -u http://asdas.com/page.php -w wordlist.txt"
    echo
    echo -e "${YELLOW}6. PARAMINATOR - Técnicas de Fuzzing de Parámetros:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Herramienta para descubrir parámetros ocultos"
    echo "   # -u: especifica la URL objetivo"
    echo "   python3 paraminator.py -u http://asdas.com/page.php"
    echo
    echo "2. Fuzzing con métodos HTTP:"
    echo "   # Prueba diferentes métodos HTTP"
    echo "   # -m: especifica los métodos a probar"
    echo "   python3 paraminator.py -u http://asdas.com/page.php -m GET,POST"
    echo
    echo "3. Fuzzing con headers:"
    echo "   # Incluye headers personalizados"
    echo "   # -H: agrega headers a las peticiones"
    echo "   python3 paraminator.py -u http://asdas.com/page.php -H \"Authorization: Bearer token123\""
    echo
    echo "4. Fuzzing con data:"
    echo "   # Incluye datos en las peticiones"
    echo "   # -d: define los datos a enviar"
    echo "   python3 paraminator.py -u http://asdas.com/page.php -d \"username=admin\""
    echo
    echo "5. Fuzzing con wordlist personalizada:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   python3 paraminator.py -u http://asdas.com/page.php -w wordlist.txt"
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
    echo "   # Agrega la IP y el dominio al archivo hosts"
    echo "   # Necesario para la resolución local"
    echo "   echo \"IP inlanefreight.htb\" | sudo tee -a /etc/hosts"
    echo
    echo "2. Verificar resolución DNS:"
    echo "   # Comprueba la resolución DNS del dominio"
    echo "   # Útil para verificar la configuración"
    echo "   dig @8.8.8.8 inlanefreight.htb"
    echo "   nslookup inlanefreight.htb 8.8.8.8"
    echo
    echo -e "${YELLOW}2. FFUF - Técnicas de Fuzzing de VHOST:${NC}"
    echo "1. Fuzzing básico de VHOST:"
    echo "   # Busca subdominios y VHOSTs"
    echo "   # -H: modifica el header Host"
    echo "   # -mc: filtra por códigos de estado"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "        -u http://FUZZ.asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -mc 200,204,301,302,307,401,403 \\"
    echo "        -fs 0"
    echo
    echo "2. Fuzzing con puerto específico (CTF):"
    echo "   # Prueba en un puerto específico"
    echo "   # Útil para CTFs y entornos no estándar"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com:54651/ \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing con filtrado por tamaño:"
    echo "   # Filtra respuestas por tamaño"
    echo "   # -fs: ignora respuestas de cierto tamaño"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 0-1000 \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing con múltiples filtros:"
    echo "   # Combina diferentes tipos de filtrado"
    echo "   # -mr: solo muestra respuestas que contengan el texto"
    echo "   # -fr: ignora respuestas que contengan el texto"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -mr \"admin\" \\"
    echo "        -fr \"error\""
    echo
    echo "5. Fuzzing con rate limit:"
    echo "   # Controla la velocidad de las peticiones"
    echo "   # Útil para evitar bloqueos"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -rate 100"
    echo
    echo "6. Fuzzing con timeout:"
    echo "   # Establece un tiempo máximo de espera"
    echo "   # Evita peticiones que se quedan colgadas"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -timeout 10"
    echo
    echo "7. Fuzzing con recursión:"
    echo "   # Busca en subdominios encontrados"
    echo "   # Útil para descubrir subdominios anidados"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200 \\"
    echo "        -recursion \\"
    echo "        -recursion-depth 2"
    echo
    echo "8. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación"
    echo "   # Útil para áreas protegidas"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ \\"
    echo "        -u http://asdas.com \\"
    echo "        -H \"Host: FUZZ.asdas.com\" \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200"
    echo
    echo "9. Fuzzing con múltiples wordlists:"
    echo "   # Combina diferentes listas de palabras"
    echo "   # Útil para mayor cobertura"
    echo "   ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt:FUZZ1 \\"
    echo "        -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt:FUZZ2 \\"
    echo "        -u http://FUZZ1.FUZZ2.asdas.com \\"
    echo "        -H \"Host: FUZZ1.FUZZ2.asdas.com\" \\"
    echo "        -fs 985 \\"
    echo "        -mc 200"
    echo
    echo -e "${YELLOW}3. GOBUSTER - Técnicas de Fuzzing de VHOST:${NC}"
    echo "1. Fuzzing básico de VHOST:"
    echo "   # Búsqueda de VHOSTs"
    echo "   # --append-domain: agrega el dominio a cada palabra"
    echo "   gobuster vhost -u http://asdas.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               --append-domain \\"
    echo "               -t 50"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   # Filtra por códigos de estado"
    echo "   # -s: incluye códigos específicos"
    echo "   # -b: excluye códigos específicos"
    echo "   gobuster vhost -u http://asdas.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               -s 200,204,301,302,307,401,403 \\"
    echo "               -b 404 \\"
    echo "               --append-domain"
    echo
    echo "3. Fuzzing DNS:"
    echo "   # Búsqueda de subdominios por DNS"
    echo "   # -d: especifica el dominio objetivo"
    echo "   gobuster dns -d asdas.com \\"
    echo "            -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación"
    echo "   # -H: agrega headers personalizados"
    echo "   gobuster vhost -u http://asdas.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               -H \"Authorization: Bearer token123\""
    echo
    echo "5. Fuzzing con exclusiones:"
    echo "   # Excluye respuestas por longitud o contenido"
    echo "   # --exclude-length: ignora respuestas de cierta longitud"
    echo "   # --exclude-text: ignora respuestas que contengan cierto texto"
    echo "   gobuster vhost -u http://asdas.com \\"
    echo "               -w /usr/share/seclists/Discovery/Web-Content/common.txt \\"
    echo "               --exclude-length 0 \\"
    echo "               --exclude-text \"404\""
    echo
    echo -e "${YELLOW}4. SUBLIST3R - Técnicas de Fuzzing de Subdominios:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Búsqueda pasiva de subdominios"
    echo "   # -d: especifica el dominio objetivo"
    echo "   # -o: guarda los resultados en un archivo"
    echo "   sublist3r -d asdas.com -o subdominios.txt"
    echo
    echo "2. Fuzzing con threads:"
    echo "   # Controla el número de hilos"
    echo "   # -t: número de hilos concurrentes"
    echo "   sublist3r -d asdas.com -t 40 -o subdominios.txt"
    echo
    echo "3. Fuzzing con búsqueda en motores:"
    echo "   # Incluye búsqueda en motores de búsqueda"
    echo "   # -b: habilita la búsqueda en motores"
    echo "   sublist3r -d asdas.com -b -o subdominios.txt"
    echo
    echo "4. Fuzzing con timeout:"
    echo "   # Establece un tiempo máximo de espera"
    echo "   # --timeout: tiempo máximo en segundos"
    echo "   sublist3r -d asdas.com -t 40 -o subdominios.txt --timeout 30"
    echo
    echo "5. Fuzzing con verbose:"
    echo "   # Muestra información detallada"
    echo "   # -v: modo verbose"
    echo "   sublist3r -d asdas.com -v -o subdominios.txt"
    echo
    echo -e "${YELLOW}5. AMASS - Técnicas de Fuzzing de Subdominios:${NC}"
    echo "1. Fuzzing pasivo:"
    echo "   # Búsqueda sin interactuar directamente"
    echo "   # -passive: modo pasivo"
    echo "   amass enum -passive -d asdas.com"
    echo
    echo "2. Fuzzing activo:"
    echo "   # Búsqueda con interacción directa"
    echo "   # -active: modo activo"
    echo "   amass enum -active -d asdas.com"
    echo
    echo "3. Fuzzing con bruteforce:"
    echo "   # Fuerza bruta de subdominios"
    echo "   # -brute: habilita el modo de fuerza bruta"
    echo "   amass enum -brute -d asdas.com"
    echo
    echo "4. Fuzzing con wordlist:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   amass enum -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -d asdas.com"
    echo
    echo "5. Fuzzing con timeout:"
    echo "   # Establece un tiempo máximo de espera"
    echo "   # -timeout: tiempo máximo en segundos"
    echo "   amass enum -passive -d asdas.com -timeout 30"
    echo
    echo -e "${YELLOW}6. DNSRECON - Técnicas de Fuzzing de DNS:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Análisis básico de DNS"
    echo "   # -d: especifica el dominio objetivo"
    echo "   dnsrecon -d asdas.com"
    echo
    echo "2. Fuzzing con wordlist:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   dnsrecon -d asdas.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "3. Fuzzing con tipos de registro:"
    echo "   # Especifica tipos de registros DNS"
    echo "   # -t: tipos de registros a buscar"
    echo "   dnsrecon -d asdas.com -t A,AAAA,CNAME,MX,TXT"
    echo
    echo "4. Fuzzing con threads:"
    echo "   # Controla el número de hilos"
    echo "   # -t: número de hilos concurrentes"
    echo "   dnsrecon -d asdas.com -t 50"
    echo
    echo "5. Fuzzing con verbose:"
    echo "   # Muestra información detallada"
    echo "   # -v: modo verbose"
    echo "   dnsrecon -d asdas.com -v"
    echo
    echo -e "${YELLOW}7. VHOSTSCAN - Técnicas de Fuzzing de VHOST:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Búsqueda básica de VHOSTs"
    echo "   # -t: especifica el dominio objetivo"
    echo "   vhostscan -t asdas.com"
    echo
    echo "2. Fuzzing con wordlist:"
    echo "   # Usa una lista de palabras personalizada"
    echo "   # -w: especifica el archivo de wordlist"
    echo "   vhostscan -t asdas.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    echo
    echo "3. Fuzzing con puerto:"
    echo "   # Especifica un puerto personalizado"
    echo "   # -p: número de puerto"
    echo "   vhostscan -t asdas.com -p 443"
    echo
    echo "4. Fuzzing con SSL:"
    echo "   # Habilita el modo SSL"
    echo "   # -s: usa SSL/TLS"
    echo "   vhostscan -t asdas.com -s"
    echo
    echo "5. Fuzzing con verbose:"
    echo "   # Muestra información detallada"
    echo "   # -v: modo verbose"
    echo "   vhostscan -t asdas.com -v"
    echo
    echo -e "${YELLOW}8. WFUZZ - Técnicas de Fuzzing de VHOST:${NC}"
    echo "1. Fuzzing básico:"
    echo "   # Búsqueda básica de VHOSTs"
    echo "   # -c: muestra colores en la salida"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.asdas.com\" \\"
    echo "         -u http://asdas.com \\"
    echo "         --hc 404"
    echo
    echo "2. Fuzzing con filtrado:"
    echo "   # Filtra respuestas por tamaño y contenido"
    echo "   # --hl: oculta por número de líneas"
    echo "   # --hw: oculta por número de palabras"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.asdas.com\" \\"
    echo "         -u http://asdas.com \\"
    echo "         --hc 404 \\"
    echo "         --hl 0 \\"
    echo "         --hw 0"
    echo
    echo "3. Fuzzing con recursión:"
    echo "   # Busca en subdominios encontrados"
    echo "   # -R: nivel de recursión"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.asdas.com\" \\"
    echo "         -u http://asdas.com \\"
    echo "         -R 2"
    echo
    echo "4. Fuzzing con autenticación:"
    echo "   # Incluye token de autenticación"
    echo "   # -H: agrega headers personalizados"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt \\"
    echo "         -H \"Host: FUZZ.asdas.com\" \\"
    echo "         -H \"Authorization: Bearer token123\" \\"
    echo "         -u http://asdas.com"
    echo
    echo "5. Fuzzing con múltiples parámetros:"
    echo "   # Prueba múltiples palabras clave"
    echo "   # FUZZ1, FUZZ2: diferentes palabras clave"
    echo "   wfuzz -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ1 \\"
    echo "         -w /usr/share/seclists/Discovery/DNS/dns-Jhaddix.txt:FUZZ2 \\"
    echo "         -H \"Host: FUZZ1.FUZZ2.asdas.com\" \\"
    echo "         -u http://asdas.com"
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

# Función para mostrar la sección de API REST
show_rest_api_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE API REST ===${NC}"
    echo
    echo -e "${YELLOW}1. Endpoints REST comunes:${NC}"
    echo "GET    /items/"
    echo "GET    /items/{id}"
    echo "POST   /items/"
    echo "PUT    /items/{id}"
    echo "DELETE /items/{id}"
    echo "GET    /docs         # Swagger/OpenAPI"
    echo
    echo -e "${YELLOW}2. Autenticación:${NC}"
    echo "1. Basic Auth:"
    echo "   curl -u usuario:password http://adasda.com/api"
    echo "   curl -H \"Authorization: Basic dXN1YXJpbzpwYXNzd29yZA==\" http://adasda.com/api"
    echo
    echo "2. Bearer Token:"
    echo "   curl -H \"Authorization: Bearer token123\" http://adasda.com/api"
    echo "   curl -H \"Authorization: Bearer \$(cat token.txt)\" http://adasda.com/api"
    echo
    echo -e "${YELLOW}3. Headers comunes:${NC}"
    echo "Content-Type: application/json"
    echo "Accept: application/json"
    echo "X-API-Key: key123"
    echo "X-Custom-Header: value"
    echo
    echo -e "${YELLOW}4. FFUF para API:${NC}"
    echo "1. Fuzzing de endpoints:"
    echo "   ffuf -X GET \\"
    echo "        -u http://adasda.com/items/FUZZ \\"
    echo "        -w ids.txt \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing con autenticación:"
    echo "   ffuf -X GET \\"
    echo "        -H \"Authorization: Bearer token123\" \\"
    echo "        -u http://adasda.com/api/FUZZ \\"
    echo "        -w endpoints.txt \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de parámetros:"
    echo "   ffuf -X GET \\"
    echo "        -u http://adasda.com/api?param=FUZZ \\"
    echo "        -w params.txt \\"
    echo "        -mc 200"
    echo
    echo "4. Fuzzing de valores JSON:"
    echo "   ffuf -X POST \\"
    echo "        -H \"Content-Type: application/json\" \\"
    echo "        -d '{\"user\":\"FUZZ\"}' \\"
    echo "        -u http://adasda.com/api/login \\"
    echo "        -mc 200"
    echo
    echo -e "${YELLOW}5. Técnicas avanzadas:${NC}"
    echo "1. Fuzzing de versiones:"
    echo "   ffuf -u http://adasda.com/vFUZZ/api \\"
    echo "        -w versions.txt \\"
    echo "        -mc 200"
    echo
    echo "2. Fuzzing de métodos HTTP:"
    echo "   ffuf -X FUZZ \\"
    echo "        -u http://adasda.com/api \\"
    echo "        -w methods.txt \\"
    echo "        -mc 200"
    echo
    echo "3. Fuzzing de headers:"
    echo "   ffuf -H \"FUZZ: value\" \\"
    echo "        -u http://adasda.com/api \\"
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

# Función para mostrar la sección de redes
show_network_fuzzing() {
    echo -e "\n${BLUE}=== FUZZING DE REDES ===${NC}"
    echo
    echo -e "${YELLOW}1. NMAP - Escaneo básico:${NC}"
    echo "1. Escaneo rápido:"
    echo "   # Escaneo rápido de puertos comunes"
    echo "   # -T4: velocidad de escaneo"
    echo "   # -F: solo puertos más comunes"
    echo "   nmap -T4 -F asdas.com"
    echo
    echo "2. Escaneo completo:"
    echo "   # Escaneo de todos los puertos"
    echo "   # -p-: todos los puertos"
    echo "   # -sV: detección de versiones"
    echo "   nmap -p- -sV asdas.com"
    echo
    echo "3. Escaneo con scripts:"
    echo "   # Ejecuta scripts de detección"
    echo "   # -sC: scripts por defecto"
    echo "   # --script vuln: scripts de vulnerabilidades"
    echo "   nmap -sC --script vuln asdas.com"
    echo
    echo -e "${YELLOW}2. MASSCAN - Escaneo rápido:${NC}"
    echo "1. Escaneo de puertos:"
    echo "   # Escaneo rápido de puertos"
    echo "   # -p: puertos a escanear"
    echo "   # --rate: paquetes por segundo"
    echo "   masscan asdas.com -p80,443,8080 --rate=1000"
    echo
    echo "2. Escaneo de rangos:"
    echo "   # Escaneo de rangos de IP"
    echo "   # -p: puertos a escanear"
    echo "   masscan 10.0.0.0/24 -p80,443"
    echo
    echo -e "${YELLOW}3. RUSTSCAN - Escaneo moderno:${NC}"
    echo "1. Escaneo básico:"
    echo "   # Escaneo rápido y moderno"
    echo "   # -a: dirección objetivo"
    echo "   # -r: rango de puertos"
    echo "   rustscan -a asdas.com -r 1-1000"
    echo
    echo "2. Escaneo con nmap:"
    echo "   # Combina con nmap para más detalles"
    echo "   # -- -sV: pasa argumentos a nmap"
    echo "   rustscan -a asdas.com -r 1-1000 -- -sV"
    echo
    echo -e "${YELLOW}4. NETCAT - Pruebas manuales:${NC}"
    echo "1. Conexión TCP:"
    echo "   # Prueba de conexión TCP"
    echo "   # -v: modo verbose"
    echo "   nc -v asdas.com 80"
    echo
    echo "2. Escaneo de puertos:"
    echo "   # Escaneo básico de puertos"
    echo "   # -z: solo escaneo"
    echo "   # -v: modo verbose"
    echo "   nc -zv asdas.com 20-30"
    echo
    echo -e "${YELLOW}5. HYDRA - Fuerza bruta:${NC}"
    echo "1. Fuerza bruta SSH:"
    echo "   # Prueba credenciales SSH"
    echo "   # -l: usuario"
    echo "   # -P: archivo de contraseñas"
    echo "   hydra -l admin -P passwords.txt ssh://asdas.com"
    echo
    echo "2. Fuerza bruta FTP:"
    echo "   # Prueba credenciales FTP"
    echo "   # -L: archivo de usuarios"
    echo "   # -P: archivo de contraseñas"
    echo "   hydra -L users.txt -P passwords.txt ftp://asdas.com"
    echo
    echo -e "${PURPLE}Notas importantes:${NC}"
    echo "1. Ajusta la velocidad según la red"
    echo "2. Usa diferentes herramientas para mejor cobertura"
    echo "3. Documenta los hallazgos importantes"
    echo "4. Considera el firewall y las políticas de red"
    echo "5. Valida manualmente los resultados"
    echo "6. Mantén las herramientas actualizadas"
    echo "7. Respeta las políticas de seguridad"
    echo "8. Obtén autorización antes de escanear"
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
        4) show_manual_validation ;;
        5) show_rest_api_fuzzing ;;
        6) show_webfuzz_api_syntax ;;
        7) echo -e "${GREEN}Saliendo...${NC}"; exit 0 ;;
        *) echo -e "${RED}Opción inválida${NC}" ;;
    esac
    
    echo
    read -p "Presione Enter para continuar..."
    clear
done 
