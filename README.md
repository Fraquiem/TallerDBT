Hecho por: Emanuel Quintero y Sebastian Perez

# 1. Introducción e instalación

¿Qué es dbt y para qué sirve?

Es una herramienta que transforma datos dentro de una base o almacén mediante SQL, con control de dependencias, pruebas y documentación.

¿Cuál es la diferencia entre ETL y ELT?

ETL transforma antes de cargar; ELT carga primero y transforma en el sistema de destino.

¿Qué papel cumple dbt en un proceso ELT?

Realiza la transformación posterior a la carga y organiza los modelos resultantes.

Mencione tres ventajas y tres desventajas de dbt.

Ventajas: SQL modular, pruebas integradas y trazabilidad. Desventajas: requiere un motor de datos, no extrae datos y puede elevar el costo de cómputo.

¿En qué situaciones utilizaría dbt?

Al construir modelos analíticos reproducibles sobre datos ya cargados en una plataforma compatible.

¿Qué es un adaptador de dbt?

Es el complemento que traduce y ejecuta dbt para un motor específico, como DuckDB o PostgreSQL.

# 2. Configuración del proyecto

¿Qué es un proyecto dbt?

Es una colección versionable de modelos, pruebas, macros y configuración para transformar datos.

¿Para qué sirve el archivo `dbt_project.yml`?

Define el nombre, rutas y configuración general del proyecto y sus recursos.

¿Para qué sirve el archivo `profiles.yml`?

Define conexiones, credenciales, destinos y ambientes de ejecución.

¿Cuál es la función del directorio `models/`?

Contiene los archivos SQL y YAML que forman los modelos y sus pruebas.

¿Por qué las credenciales no deben escribirse directamente en el proyecto?

Para evitar filtrarlas en el repositorio y poder cambiarlas según el ambiente.

¿Para qué sirve el comando `dbt debug`?

Valida el proyecto, el perfil, las dependencias y la conexión al destino.

# 4. Fuentes de datos

¿Qué es una fuente o `source` en dbt?

Es una tabla externa de origen declarada en el proyecto.

¿Cómo se declaran las fuentes?

En un archivo YAML, dentro de `sources`, indicando base, esquema y tablas.

¿Para qué sirve la función `source()`?

Genera una referencia segura a una tabla de origen declarada.

¿Qué ventajas tiene declarar las tablas de origen como fuentes?

Aporta trazabilidad, documentación, pruebas y nombres centralizados.

# 5. Modelos, referencias y materializaciones

¿Qué es un modelo en dbt?

Es una consulta SQL que dbt convierte en una relación de datos.

¿Cómo se construye un modelo a partir de un archivo SQL?

Se guarda un `SELECT` en `models/` y dbt lo ejecuta con la materialización configurada.

¿Para qué sirve la función `ref()`?

Referencia otro modelo y registra la dependencia entre ambos.

¿Qué es una materialización?

Es la forma en que dbt persiste un modelo, por ejemplo como vista o tabla.

¿Cuál es la diferencia entre las materializaciones `view` y `table`?

Una vista guarda la consulta y se calcula al leerla; una tabla guarda el resultado físicamente.

¿Cómo utiliza dbt las referencias para determinar el orden de ejecución?

Construye un grafo de dependencias y ejecuta primero los modelos requeridos por otros.

# 6. Construcción del modelo OLAP

¿Qué es una clave subrogada?

Es un identificador artificial creado para una fila, independiente de los datos del negocio.

¿Cuál es la diferencia entre una clave natural y una clave sustituta o subrogada?

La natural proviene del negocio; la subrogada se genera para el modelo de datos.

¿Por qué se utilizan claves subrogadas en un modelo dimensional?

Dan estabilidad, simplifican relaciones y permiten conservar distintas versiones de una entidad.

¿Qué características debe tener una buena clave subrogada?

Debe ser única, no nula, estable y ajena al significado del negocio.

¿Cómo puede generarse una clave subrogada utilizando SQL o dbt?

Con secuencias, `row_number()`, una función hash o una macro como `dbt_utils.generate_surrogate_key()`.

¿Qué ventajas y limitaciones tiene `row_number()`?

Es simple y compacto, pero puede cambiar si varían el orden o los datos.

¿Qué ventajas y limitaciones tienen los hashes y `dbt_utils.generate_surrogate_key()`?

Son reproducibles y aceptan varias columnas; consumen más espacio y la macro añade una dependencia.

# 7. Pruebas de datos

¿Qué es una prueba de datos en dbt?

Es una consulta que detecta filas que incumplen una regla de calidad.

¿Para qué sirven las pruebas `not_null` y `unique`?

Comprueban que una columna no tenga nulos ni valores repetidos.

¿Para qué sirve la prueba `relationships`?

Comprueba que cada clave foránea exista en el modelo relacionado.

¿En qué tipo de archivo se configuran estas pruebas?

Normalmente en archivos YAML de propiedades dentro de `models/`.

¿Cuál es la diferencia entre `dbt run`, `dbt test` y `dbt build`?

`run` construye modelos, `test` ejecuta pruebas y `build` construye y prueba respetando dependencias.
