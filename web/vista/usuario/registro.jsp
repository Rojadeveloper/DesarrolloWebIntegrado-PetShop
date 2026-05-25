<%-- 
    Document   : registro
    Created on : 24 abr 2026, 6:41:57
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro - PetShop</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloRegistro.css">
</head>

<body>

<div class="login-box">

    <a href="<%= request.getContextPath() %>/index.jsp" class="close-btn">×</a>

    <h2>Registro de Usuario</h2>

    <form action="<%= request.getContextPath() %>/registro" method="post" name="formRegistro" onsubmit="return validarFormulario()">
        
        <input type="text" name="nombre" placeholder="Nombre" required>

        <input type="text" name="apellido" placeholder="Apellido" required>

        <input type="email" name="correo" placeholder="Correo electrónico" required>
        
        <input type="password" name="password" placeholder="Contraseña" required>

        <input type="tel" name="telefono" placeholder="Ingrese un número válido" pattern="[0-9]{7,15}" required>
        
        <input type="text" name="direccion" placeholder="Dirección">

        <button type="submit">Registrarse</button>
    </form>

</div>

</body>
</html>