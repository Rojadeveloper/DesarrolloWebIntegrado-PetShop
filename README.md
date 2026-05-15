# 🐾 PetShop - Plataforma de E-commerce y Venta de Productos para mascotas

[![Licencia: MIT](https://shields.io)](https://opensource.org)
[![Java: 17](https://shields.io)](https://oracle.com)
[![Jakarta EE: 10](https://shields.io)](https://jakarta.ee)

Este es un proyecto colaborativo de desarrollo web integrado para una plataforma E-commerce y venta de productos para mascotas. La aplicación implementa una arquitectura robusta basada en el patrón **MVC (Modelo-Vista-Controlador)**, utilizando tecnologías modernas de **Jakarta EE** con persistencia de datos en **MySQL**.

---

## 🛠️ Stack Tecnológico y Requisitos

Para garantizar la consistencia en el equipo, asegúrate de contar con el siguiente entorno local:

*   **IDE:** Apache NetBeans 21
*   **Lenguaje:** Java SE / JDK 17
*   **Tecnología Web:** Jakarta EE 10 (Servlets, JSP, JSTL)
*   **Servidor de Aplicaciones Actual:** Apache Tomcat 10.1.12 *(Contenedor de Servlets)*
*   **Base de Datos:** MySQL Server & phpMyAdmin
*   **Próxima Migración Planificada:** GlassFish 7.x *(Servidor de aplicaciones Full Profile)*

---

## 📁 Arquitectura del Proyecto

El código fuente sigue un patrón de diseño limpio y una separación estricta de responsabilidades:

*   `src/java/controlador/`: Servlets que interceptan y gestionan las peticiones HTTP (ej. `LoginServlet.java`).
*   `src/java/modelo/config/`: Clases de infraestructura técnica y conexiones (ej. `ConexionBD.java`).
*   `src/java/modelo/dao/`: Capa de Acceso a Datos (Data Access Object) para aislamiento de consultas SQL.
*   `src/java/modelo/entidad/`: Clases POJO que representan las entidades del negocio (ej. `Usuario.java`).
*   `src/java/servicio/`: Lógica de negocio intermedia que conecta los controladores con los DAOs.
*   `web/vista/`: Vistas de usuario estructuradas en subcarpetas para un crecimiento modular y escalable.

---

## 🚀 Guía de Instalación y Despliegue Local

### 1. Clonar el repositorio
```bash
[git clone https://github.com](https://github.com/Rojadeveloper/DesarrolloWebIntegrado-PetShop.git)
```

### 2. Configuración de la Base de Datos
1. Inicia tus servicios de MySQL y Apache desde tu panel de control local (ej. XAMPP).
2. Entra a **phpMyAdmin** (`http://localhost/phpmyadmin`) y crea una base de datos nueva.
3. Selecciona la base de datos, ve a la pestaña **Importar** y carga el archivo ubicado en:
   📁 `/db/tienda_mascotas.sql`
4. Revisa la clase `ConexionBD.java` y asegúrate de que las credenciales de conexión coincidan con tu entorno local (por defecto, usuario `root` sin contraseña).

### 3. Gestión Manual de Dependencias (Archivos JAR)
Debido a que el repositorio mantiene un historial limpio y libre de archivos binarios pesados, cada desarrollador debe enlazar el driver de la base de datos de manera local:

1. Ubica o descarga el archivo `mysql-connector-java-5.1.48.jar` (se incluye una copia de referencia en la carpeta física `/lib/` de este proyecto).
2. En NetBeans, haz clic derecho en el proyecto -> **Properties** -> **Libraries**.
3. En la pestaña **Compile**, presiona el botón **`+`** (**Add JAR/Folder**) y selecciona dicho archivo.

---

## 👥 Colaboradores y Trabajo en Equipo

Este repositorio es una prueba de desarrollo colaborativo y control de versiones efectivo. El equipo aplica flujos de trabajo profesionales mediante ramas y commits descriptivos para simular un entorno laboral real.

*   **Jesus Roja / RojaDeveloper** - Arquitectura base y Configuración inicial.
*   **Ramiro Rodriguez**
*   **Josue Espinoza**
*   **Ronaldo Nuñez**
*   **Stephano Chuchon**

---

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT**. Esto significa que es un software de código abierto y permite la libre modificación y distribución del código. Revisa el archivo [LICENSE](LICENSE) para más detalles.
