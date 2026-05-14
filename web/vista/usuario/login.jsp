<%-- 
    Document   : login
    Created on : 24 abr 2026, 6:40:26
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - PetShop</title>
    <!-- Conexión al CSS externo -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloLogin.css">
</head>

<body>

<div class="login-box">
    <h2>Iniciar Sesión</h2>
    <a href="<%= request.getContextPath() %>/index.jsp" class="close-btn">×</a>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="text" name="correo" placeholder="Correo" required>
        <input type="password" name="password" placeholder="Contraseña" required>

        <button type="submit">Ingresar</button>
    </form>    
</div>
</body>
</html>