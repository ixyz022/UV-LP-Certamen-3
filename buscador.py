import json

# Cargar índice invertido
with open('resultado.json', 'r') as file:
    indice_invertido = json.load(file)


def buscar(query, indice_invertido):
    palabras = query.split()  # Dividir la consulta en palabras
    documentos_coincidentes = None

    for palabra in palabras:
        palabra = palabra.lower()  # Convertir a minúsculas
        # ¿La palabra actual está en el índice invertido?
        if palabra in indice_invertido:
            # Obtener la lista de documentos donde aparece la palabra
            lista_documentos = indice_invertido[palabra]
            # ¿La variable documentos_coincidentes es nula?
            if documentos_coincidentes is None:
                documentos_coincidentes = set(lista_documentos)
            else:
                # ¿se intersectan los conjuntos documentos_coincidentes y lista_documentos?
                documentos_coincidentes = documentos_coincidentes.intersection(
                    lista_documentos)

    return documentos_coincidentes


# Leer consultas desde un archivo
with open('consultas.txt', 'r') as consultas_file:
    consultas = consultas_file.readlines()

with open('resultados_consultas.txt', 'w') as resultados_file:
    for consulta in consultas:
        consulta = consulta.strip()  # Porsiacaso eliminar espacios en blanco
        # Buscar en el índice invertido
        resultados = buscar(consulta, indice_invertido)
        # ¿Se encontraron resultados?
        if resultados is not None:  # si hay resultados
            # Escribimos los resultados en el archivo  y los documentos donde aparece la consulta
            resultados_file.write(
                f"Resultados para la consulta '{consulta}':\n")
            for doc in resultados:
                resultados_file.write(f"Documento {doc}\n")
        else:  # no hay resultados
            resultados_file.write(
                f"No se encontraron resultados para la consulta '{consulta}'.\n")

print("Proceso completado. Los resultados de las consultas se han guardado en 'resultados_consultas.txt'.")
