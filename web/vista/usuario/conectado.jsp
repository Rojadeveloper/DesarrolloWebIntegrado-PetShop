<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Conectado</title>
</head>
<body>

<h1>✅ Usuario conectado correctamente</h1>

<%
modelo.entidad.Usuario usuario = 
    (modelo.entidad.Usuario) session.getAttribute("usuario");

if (usuario != null) {
%>
    <p>Bienvenido <%= usuario.getNombre() %></p>
<%
} else {
%>
    <p>No hay sesión activa</p>
<%
}
%>

</body>
</html>