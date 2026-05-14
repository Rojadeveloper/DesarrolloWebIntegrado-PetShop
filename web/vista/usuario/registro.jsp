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

    <form name="formRegistro" onsubmit="return validarFormulario()">
        <input type="text" name="nombre" placeholder="Nombre completo" required>

        <input type="text" name="usuario" placeholder="Usuario" required>

        <input type="password" name="password" placeholder="Contraseña" required>

        <input type="email" name="email" placeholder="Correo electrónico" required>

        <input type="tel" name="telefono" placeholder="Ingrese un número válido" pattern="[0-9]{7,15}" required>

        <!-- Rol fijo: cliente -->
        <input type="hidden" name="rol" value="cliente">

        <button type="submit">Registrarse</button>
    </form>

    <%
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String rol = request.getParameter("rol");

        if (usuario != null && password != null && email != null) {

            // SIMULACIÓN (sin BD todavía)
            out.println("<p style='color:green;'>Usuario registrado correctamente</p>");

            // aquí luego conectarás a MySQL
        }
    %>
</div>

</body>
</html>