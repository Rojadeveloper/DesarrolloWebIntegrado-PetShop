<%-- 
    Document   : login
    Created on : 24 abr 2026, 6:40:26
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PetShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloAcces.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
</head>

<body>

<div class="login-box">
    <a href="<%= request.getContextPath() %>/inicio" class="close-btn" title="Volver al Inicio">×</a>
    
    <h2>Iniciar Sesión</h2>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger text-center py-2" style="font-size: 14px; border-radius: 10px;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="email" name="correo" placeholder="Correo electrónico" required>
        <input type="password" name="password" placeholder="Contraseña" required>

        <button type="submit">Ingresar</button>
    </form>  
    
    <div class="switch-link">
        ¿Nuevo por aquí? <a href="<%= request.getContextPath() %>/vista/usuario/registro.jsp">Regístrate aquí</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>