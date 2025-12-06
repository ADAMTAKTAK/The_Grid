# 🕹 TheGrid - Catálogo de Juegos

> *"We kept dreaming of a world We thought we'd never see, and then one day we got In"*

## 📄 Descripción
TheGrid es una aplicación móvil inmersiva desarrollada en Flutter que funciona como un catálogo de videojuegos futurista. Con una identidad visual inspirada en el universo de *TRON*, la app consume datos en tiempo real para ofrecer a los usuarios información detallada, calificaciones y sinopsis de miles de títulos.

La aplicación no es solo un listado; es una experiencia que incluye ambiente sonoro y una interfaz diseñada para sentirse como una terminal de acceso al sistema.

## 🚀 Cómo usar la App
La navegación en TheGrid es intuitiva y se divide en tres secciones principales:

1.  Home (The Grid):
    * Explora los juegos en tendencia a través de un carrusel interactivo (Swiper).
    * Descubre juegos populares mediante listas horizontales.
    * Disfruta de la música de fondo integrada ("The Grid") con controles de reproducción.
2.  Buscador:
    * Utiliza la lupa en la barra superior para encontrar cualquier juego específico en la base de datos.
3.  Detalles:
    * Toca cualquier tarjeta de juego para ver su ficha técnica completa, incluyendo descripción, puntuación y equipo de desarrollo.
4.  System Admin (Info):
    * Accede a la ficha del equipo "ENCOM" para ver los perfiles de los desarrolladores y sus enlaces de contacto.

## 🛠 Tecnologías Empleadas
Este proyecto demuestra una arquitectura sólida utilizando las siguientes herramientas y librerías:

* Framework: [Flutter](https://flutter.dev/) & Dart.
* Gestión de Estado: provider (Patrón MVVM).
* Conexión API: http para consumo de datos REST (RAWG API).
* Multimedia: audioplayers para la experiencia sonora persistente.
* Interfaz de Usuario: card_swiper para carruseles dinámicos y cupertino_icons.
* Utilidades: url_launcher para redirección a perfiles de GitHub.

## 💻 Instalación y Ejecución
El proyecto ya viene configurado con las claves necesarias. Para probarlo en tu entorno local:

1.  Clonar el repositorio:
        git clone [https://github.com/adamtaktak/the_grid.git](https://github.com/adamtaktak/the_grid.git)
    cd the_grid
    

2.  Instalar dependencias:
    Asegúrate de tener Flutter instalado y ejecuta:
        flutter pub get
    

3.  Ejecutar:
    Conecta tu dispositivo o emulador y corre:
        flutter run
    
Opción Alternativa:
   Cómo opción adicional es descargar el apk en Google Drive por medio de este link:
   https://drive.google.com/drive/folders/1XPBmg7z-tfbsdhCN1fRfSVTBVGsWN0CA

   
## 📂 Estructura del Proyecto
El código sigue una organización limpia y modular basada en capas:

```text
lib/
├── models/      # Modelos de datos para mapear la respuesta de la API (Game, Responses)
├── providers/   # Lógica de negocio y gestión de estado (GamesProvider, AudioProvider)
├── routes/      # Mapa de rutas de navegación de la app
├── screens/     # Pantallas principales (Home, Details, InfoScreen)
├── search/      # Lógica del delegado de búsqueda (SearchDelegate)
├── themes/      # Configuración de estilos visuales (AppTheme)
└── widgets/     # Componentes reutilizables de UI (Cards, Sliders, Buttons)
