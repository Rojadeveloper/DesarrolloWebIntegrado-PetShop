<%-- 
    Document   : registro.jsp
    Created on : 24 abr 2026, 6:41:57
    Author     : User & Refactored by: RonaldoYN (Modern Style with JSTL)
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - PetShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloAcces.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Responsive.css">
</head>
<body>

<div class="login-box">
    <%-- Volver al inicio usando la ruta del Servlet o ruta raíz --%>
    <a href="${pageContext.request.contextPath}/inicio" class="close-btn" title="Volver al Inicio">×</a>

    <h2>Registro de Usuario</h2>

    <%-- Mensaje de Error con JSTL --%>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger py-2 text-center small" role="alert">
            ⚠️ <c:out value="${requestScope.error}" />
        </div>
    </c:if>

    <%-- Mensaje de Éxito con JSTL --%>
    <c:if test="${not empty requestScope.exito}">
        <div class="alert alert-success py-2 text-center small" role="alert">
            🐾 <c:out value="${requestScope.exito}" />
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/registro" method="POST" name="formRegistro">
        
        <input type="text" name="nombre" placeholder="Nombre" required>

        <input type="text" name="apellido" placeholder="Apellido" required>

        <input type="email" name="correo" placeholder="Correo electrónico" required>
        
        <input type="password" name="password" placeholder="Contraseña" required>

        <input type="tel" name="telefono" placeholder="Teléfono (Ej: 987654321)" pattern="[0-9]{7,15}" required>
        
        <input type="text" name="direccion" placeholder="Dirección de entrega">

        <input type="hidden" name="rol" value="CLIENTE">

        <button type="submit">Registrarse</button>
    </form>

    <div class="switch-link">
        ¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login">Inicia sesión</a>
    </div>
</div>

    <%-- Script de SweetAlert2 --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%-- Lógica para detectar el registro exitoso --%>
<c:if test="${param.registroExitoso eq 'true'}">
    <script>
        Swal.fire({
            title: '🐾 ¡Registro Exitoso!',
            text: 'Tu cuenta ha sido creada correctamente en PetShop. Ya puedes iniciar sesión.',
            icon: 'success',
            background: '#121214', // Color de fondo oscuro a juego con tu estilo
            color: '#ffffff',
            confirmButtonColor: '#b55fe6', // Color morado de tu marca
            confirmButtonText: 'Entendido',
            iconColor: '#b55fe6',
            showClass: {
                popup: 'animate__animated animate__fadeInUp'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutDown'
            }
        });
    </script>
</c:if>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>