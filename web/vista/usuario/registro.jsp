<%-- 
    Document   : registro.jsp
    Created on : 24 abr 2026, 6:41:57
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - PetShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloAcces.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
</head>

<body>

<div class="login-box">
    <a href="<%= request.getContextPath() %>/index.jsp" class="close-btn" title="Volver al Inicio">×</a>

    <h2>Registro de Usuario</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger py-2 text-center small" role="alert">
            ⚠️ <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <% if (request.getAttribute("exito") != null) { %>
        <div class="alert alert-success py-2 text-center small" role="alert">
            🐾 <%= request.getAttribute("exito") %>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/registro" method="POST" name="formRegistro">
        
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
        ¿Ya tienes cuenta? <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp">Inicia sesión</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>