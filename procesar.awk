#!/usr/bin/awk -f

BEGIN {
    # Cargar stopwords en un array
    stopwords_file = ARGV[ARGC - 1] # Ruta de los stopwords
    while ((getline < stopwords_file) > 0) {
        stopwords[$1] = 1
    }
    close(stopwords_file)

    # Inicializar un archivo JSON
    printf "{\n" > "resultado.json"
}

{
    # Procesamos cada palabra y número en la línea
    for (i = 1; i <= NF; i++) {
        elemento = tolower($i) # Conversion de cada elemento a minúsculas
        # ¿El elemento actual NO está en la lista de stopwords y contiene solocaracteres alfabétocps y/o dígitos? 
        if (!(elemento in stopwords) && elemento ~ /^[a-zA-Z0-9]+$/) {
            # Si el elemento no existe en la lista, la agregamos
            if (!(elemento in lista_invertida)) {
                lista_invertida[elemento] = ""
            }
            # Si el elemento no existe en la lista, la agregamos
            if (index(lista_invertida[elemento], NR) == 0) {
                if (lista_invertida[elemento] != "") {
                    lista_invertida[elemento] = lista_invertida[elemento] ", "
                }
                lista_invertida[elemento] = lista_invertida[elemento] NR
            }
        }
    }
}

END {
    # Generar el archivo JSON
    primero = 1
    for (elemento in lista_invertida) {
        sub(/, $/, "", lista_invertida[elemento]) # Elimina coma y espacio final
        if (!primero) {
            printf ",\n" > "resultado.json"
        }
        printf "    \"%s\": [%s]", elemento, lista_invertida[elemento] > "resultado.json"
        primero = 0
    }

    # Cerrar el archivo JSON
    printf "\n}\n" > "resultado.json"
}

# Ejecutable
# awk -f procesar.awk  data.dat stopwords.txt
