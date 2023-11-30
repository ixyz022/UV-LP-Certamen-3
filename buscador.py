import json

# Cargar el índice invertido desde un archivo JSON
with open('resultado.json', 'r') as file:
    indice_invertido = json.load(file)


def buscar(query, indice_invertido):
    palabras = query.split()  # Dividir la consulta en palabras
    documentos_coincidentes = None

    for palabra in palabras:
        palabra = palabra.lower()  # Convertir a minúsculas
        if palabra in indice_invertido:
            lista_documentos = indice_invertido[palabra]
            if documentos_coincidentes is None:
                documentos_coincidentes = set(lista_documentos)
            else:
                documentos_coincidentes = documentos_coincidentes.intersection(
                    lista_documentos)

    return documentos_coincidentes


# Leer consultas desde un archivo
with open('consultas.txt', 'r') as consultas_file:
    consultas = consultas_file.readlines()

# Procesar consultas y almacenar resultados en un archivo
with open('resultados_consultas.txt', 'w') as resultados_file:
    for consulta in consultas:
        consulta = consulta.strip()  # Eliminar espacios en blanco alrededor
        resultados = buscar(consulta, indice_invertido)
        if resultados is not None:
            resultados_file.write(
                f"Resultados para la consulta '{consulta}':\n")
            for doc in resultados:
                resultados_file.write(f"Documento {doc}\n")
        else:
            resultados_file.write(
                f"No se encontraron resultados para la consulta '{consulta}'.\n")

print("Proceso completado. Los resultados de las consultas se han guardado en 'resultados_consultas.txt'.")
