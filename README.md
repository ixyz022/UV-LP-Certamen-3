# Construcción de un Índice Invertido en Python

Este repositorio contiene un ejemplo de construcción de un índice invertido en Python utilizando los textos proporcionados. El índice invertido se genera a partir de los textos contenidos en un archivo de datos y se almacena en un archivo JSON. Además, se incluye un buscador simple para realizar consultas en el índice invertido.

## Contenido del Repositorio

- `procesar_textos.awk`: Un script AWK para procesar los textos y generar un índice invertido en formato JSON.

- `buscador.py`: Un script en Python que carga el índice invertido y permite realizar consultas en él.

- `consultas.txt`: Un archivo de texto que contiene consultas de búsqueda.

- `resultado.json`: El archivo JSON que almacena el índice invertido generado.

- `resultados_consultas.txt`: El archivo que almacena los resultados de las consultas realizadas.

## Uso

### Paso 1: Generar el Índice Invertido

Para generar el índice invertido, ejecuta el siguiente comando:

```bash
awk -f procesar_textos.awk data.dat stopwords.txt > resultado.json
```

Esto generará el archivo `resultado.json` que contiene el índice invertido.

### Paso 2: Realizar Consultas

Puedes realizar consultas en el índice invertido utilizando el script `buscador.py`. Para ejecutar el buscador y realizar consultas, sigue estos pasos:

1. Asegúrate de tener un archivo de consultas llamado `consultas.txt`. Cada consulta debe estar en una línea separada.

2. Ejecuta el siguiente comando:

```bash
python buscador.py
```

Los resultados de las consultas se almacenarán en el archivo `resultados_consultas.txt`.

## Ejemplo de Consultas

Puedes utilizar consultas como las siguientes en el archivo `consultas.txt`:

```
random words
maximum lines text
generate generate text
lines of random
lines maximum
```

Estas son solo algunas de las consultas de ejemplo que puedes probar.

## Requisitos

- Python 3.x
- AWK (para generar el índice invertido)
