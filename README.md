# 🐾 PetShop - Venta de Productos para mascotas

📌 Licencia: MIT  
☕ Java: 21  
🌐 Jakarta EE: 10  
🗄️ Base de Datos: MySQL  
🚀 Servidor de Aplicaciones: GlassFish 7


---

## 📖 Descripción del proyecto

Este es un proyecto colaborativo de desarrollo web para un sistema de gestión y venta de productos para mascotas.

La aplicación implementa una arquitectura robusta basada en el patrón **MVC (Modelo-Vista-Controlador)**, utilizando tecnologías modernas de **Jakarta EE**, con persistencia de datos en **MySQL**.

---

## 🛠️ Stack Tecnológico y Requisitos

Para garantizar la consistencia en el equipo, asegúrate de contar con el siguiente entorno local:

- IDE: Apache NetBeans 19
- Lenguaje: Java JDK 21
- Tecnología Web: Jakarta EE 10 (Servlets, JSP, JSTL)
- Servidor de Aplicaciones: GlassFish 7 (Jakarta EE compatible)
- Base de Datos: MySQL Server & phpMyAdmin

---

## 📁 Arquitectura del Proyecto

El código fuente sigue una arquitectura en capas con separación de responsabilidades:

```text
src/java/
│
├── controlador/        → Servlets (Controladores MVC)
├── servicio/           → Lógica de negocio
├── modelo/
│   ├── config/         → Configuración (ej. ConexionBD)
│   ├── entidad/        → Clases del dominio (BD)
│   ├── dto/            → Objetos de transferencia de datos
│   ├── dao/            → Interfaces DAO
│   ├── dao/impl/       → Implementaciones JDBC
│   ├── factory/        → Fábrica de DAOs
│
├── util/               → Clases utilitarias
```


## 🔐 Roles del sistema
- ADMIN: acceso completo al sistema (CRUD de productos y gestión)
- CLIENTE: acceso a catálogo, carrito y compras

## 🧩 Funcionalidades
*  Autenticación con control y sesiones
*  Gestión de roles (ADMIN / CLIENTE)
*  Registro de usuarios
*  Arquitectura en capas basada en MVC con patrones DAO, Service, DTO, Factory y Util para una mejor separación de responsabilidades
---

## 🚀 Guía de Instalación y Despliegue Local

### 1. Clonar el repositorio
```bash
git clone https://github.com/Rojadeveloper/DesarrolloWebIntegrado-PetShop.git
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

### 4.⚠️ IMPORTANTE: 
El proyecto debe ejecutarse con GlassFish 7 configurado en NetBeans. No usar Tomcat.
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
