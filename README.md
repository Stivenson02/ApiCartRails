
# API de Carrito de Compras

Esta es una API para gestionar un carrito de compras, construida con Ruby y Rails.

## Requisitos

- Ruby: **3.1.0**
- Rails: **~> 7.2.2**, **>= 7.2.2.1**

## Instalación

Sigue los pasos a continuación para poner en marcha el proyecto:

### 1. Clonar el repositorio

Clona este repositorio en tu máquina local:

```bash
git clone https://github.com/Stivenson02/ApiCartRails.git
```

### 2. Acceder a la carpeta del proyecto

Una vez que hayas clonado el repositorio, accede a la carpeta del proyecto:

```bash
cd ApiCartRails
```

### 3. Instalar las gemas necesarias

Ejecuta el siguiente comando para instalar las gemas que el proyecto necesita:

```bash
bundle install
```

### 4. Correr las migraciones

Es necesario ejecutar las migraciones para crear las tablas en la base de datos:

```bash
rails db:migrate
```

### 5. Correr el SEED para generar productos de ejemplo

Para que el proyecto tenga productos de ejemplo en la base de datos, debes ejecutar el SEED:

```bash
rails db:seed
```

Esto generará una lista de productos que podrás utilizar para probar los endpoints de la API.

## Endpoints de la API

### Productos

- `GET /products` - Devuelve una lista de todos los productos.
- `POST /products` - Crea un nuevo producto.
- `GET /products/:id` - Devuelve un producto por su ID.
- `PUT /products/:id` - Actualiza un producto por su ID.
- `DELETE /products/:id` - Elimina un producto por su ID.

### Carrito

- `GET /carts` - Devuelve una lista de todos los carritos de compras.
- `POST /carts` - Crea un nuevo carrito de compras.
- `GET /carts/:id` - Devuelve un carrito específico por su ID.
- `PUT /carts/:id` - Actualiza un carrito de compras.
- `DELETE /carts/:id` - Elimina un carrito de compras.

### Elementos del Carrito

- `POST /carts/:id/items` - Agrega un producto al carrito.
- `DELETE /carts/:id/items` - Elimina un producto del carrito.

## Notas

- Asegúrate de tener la base de datos configurada correctamente antes de ejecutar las migraciones.
- Si encuentras algún error al ejecutar los comandos o en la API, revisa los logs del servidor para más detalles.
- El archivo `db/seeds.rb` incluye un conjunto de productos de ejemplo que se pueden cargar con el comando `rails db:seed`.

## Contribuciones

Si quieres contribuir a este proyecto, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama para tu característica (`git checkout -b feature/nueva-caracteristica`).
3. Realiza tus cambios y asegúrate de que todo funciona correctamente.
4. Haz un commit con tus cambios (`git commit -am 'Agrega nueva característica'`).
5. Sube tus cambios a tu fork (`git push origin feature/nueva-caracteristica`).
6. Abre un Pull Request para que podamos revisar tu contribución.

## Licencia

Este proyecto está bajo la Licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.