# hola_mundo

Hola Mundo y plantilla base para una aplicacion en Flutter.

## Empecemos
Este proyecto es el punto de partida para una aplicación Flutter


## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado lo siguiente:

- **Flutter SDK**: Asegúrate de tener Flutter instalado en tu máquina. Puedes descargarlo desde [aquí](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: Viene incluido con Flutter, pero asegúrate de que esté actualizado.
- **Android Studio** o **Xcode**: Dependiendo de la plataforma en la que desees compilar la aplicación.
- **Git**: Para clonar el repositorio.

## Clonar el Repositorio
- navega hasta la ruta del proyecto.
ejecuta:
- flutter pub get
- Compilar App.

## Otros recursos
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


Para obtener ayuda para comenzar con el desarrollo de Flutter, consulte la
[documentacíon Online](https://docs.flutter.dev/), que ofrece tutoriales, ejemplos, orientación sobre desarrollo móvil y una referencia completa de API.

## Archivos Principales

### 1. `app_router.dart`
Este archivo define las rutas de la aplicación utilizando el paquete `GoRouter`. `GoRouter` facilita la gestión de rutas y la navegación en aplicaciones Flutter.

**Rutas definidas**:
- `/`: Página principal (HomeView)
- `/settings`: Página de configuración (SettingsView)
- `/profile`: Página de perfil (ProfileView)
- `/paso_parametros`: Pantalla donde se gestionan parámetros en una aplicación.
- `/detalle/:parametro/:metodoNavegacion`: Página de detalles donde se muestra información basada en el parámetro recibido.
- `/ciclo_vida`: Pantalla que demuestra el ciclo de vida de un `StatefulWidget`.

### 2. `paso_parametros_screen.dart`
Este archivo contiene la pantalla principal de la aplicación, donde se gestiona la navegación a través de un `TabBar`. La pantalla tiene dos pestañas: una con un `GridView` de ítems y otra con un carrusel de imágenes. Al hacer clic en un ítem del `GridView`, se navega a la pantalla de detalles, pasando el índice del ítem como parámetro.

**Características**:
- `GridView`: Muestra una lista de 20 ítems, donde cada uno se puede seleccionar para navegar a la página de detalles.
- `CarouselSlider`: Muestra un carrusel de imágenes.
- **Navegación**: Se utiliza `GoRouter` para navegar a la pantalla de detalles, pasando el índice del ítem como parámetro.

### 3. `detalle_screen.dart`
Este archivo define la pantalla de detalles, que recibe dos parámetros a través de la URL: `parametro` y `metodoNavegacion`. Se muestra el valor de estos parámetros en la pantalla, y se incluye un botón para regresar a la pantalla anterior mediante `context.pop()`.

**Características**:
- Muestra los parámetros pasados desde la pantalla anterior.
- Permite volver a la pantalla anterior usando el botón "Volver".

### 4. `ciclo_vida_screen.dart`
Este archivo define una pantalla que muestra el ciclo de vida de un `StatefulWidget` en Flutter. Los métodos `initState()`, `didChangeDependencies()`, `build()`, `setState()` y `dispose()` están implementados con `print()` para que puedas observar cuándo se ejecuta cada uno de ellos durante la vida del widget.

**Características**:
- **`initState()`**: Se ejecuta una vez cuando el widget es creado.
- **`didChangeDependencies()`**: Se ejecuta cuando las dependencias del widget cambian.
- **`build()`**: Se ejecuta cada vez que el widget es reconstruido.
- **`setState()`**: Se usa para actualizar el estado del widget y reconstruirlo.
- **`dispose()`**: Se ejecuta cuando el widget es destruido.
