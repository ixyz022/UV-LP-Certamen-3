#!/usr/bin/awk -f

# Comprobamos que se proporcionen los archivos de datos y stopwords como argumentos
BEGIN {
    if (ARGC < 3) {
        print "Uso: awk -f script.awk data.dat stopwords.txt > resultado.json"
        exit 1
    }

    # Cargamos los stopwords en un array
    stopwords_file = ARGV[ARGC - 1]
    while ((getline < stopwords_file) > 0) {
        stopwords[$1] = 1
    }
    close(stopwords_file)
    # Inicializamos el objeto JSON
    printf "{\n" > "resultado.json"
}

{
    # Procesamos cada palabra y número en la línea
    for (i = 1; i <= NF; i++) {
        elemento = tolower($i) # Convertimos a minúsculas
        # Verificamos si el elemento no está en la lista de stopwords
        if (!(elemento in stopwords) && elemento ~ /^[a-zA-Z0-9]+$/) {
            # Inicializamos la entrada de elemento como un array si no existe
            if (!(elemento in lista_invertida)) {
                lista_invertida[elemento] = ""
            }
            # Verificamos si la página o número no está en la lista del elemento actual
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
    # Generamos el archivo JSON
    primero = 1
    for (elemento in lista_invertida) {
        sub(/, $/, "", lista_invertida[elemento]) # Eliminamos la coma y el espacio final
        if (!primero) {
            printf ",\n" > "resultado.json"
        }
        printf "    \"%s\": [%s]", elemento, lista_invertida[elemento] > "resultado.json"
        primero = 0
    }

    # Cerramos el objeto JSON
    printf "\n}\n" > "resultado.json"
    print "Proceso completado. El resultado se ha guardado en 'resultado.json'."
}






# awk -f procesar.awk  data.dat stopwords.txt > resultado.txt
