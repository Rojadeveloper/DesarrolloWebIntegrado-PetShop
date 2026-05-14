<%-- 
    Document   : index.jsp
    Created on : 24 abr 2026, 6:44:17
    Author     : User
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PetShop - Productos para Mascotas</title>
    <link rel="stylesheet" href="css/EstiloIndex.css">
</head>

<body>

<!-- HEADER -->
<header class="header">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloIndex.css">

    <h1>🐾 PetShop</h1>

    <div class="search-box">
        <form action="<%= request.getContextPath() %>/index.jsp" method="get">
            <input type="text" name="buscar" placeholder="Buscar productos..." />
            <button type="submit">🔍</button>
        </form>
    </div>

    <nav>
        <a href="<%= request.getContextPath() %>/index.jsp">Inicio</a>
        <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp">Iniciar Sesión</a>
        <a href="<%= request.getContextPath() %>/vista/usuario/registro.jsp">Registrarse</a>
    </nav>

</header>

<!-- BANNER -->
<section class="banner">
    <h2>Todo para el cuidado de tu mascota</h2>
    <p>Alimentos, juguetes, accesorios y más</p>
</section>

<!-- CATALOGO -->
<section class="productos">

    <h2>Productos destacados</h2>

    <div class="grid">

        <div class="card">
            <img src="imagen/ComidaPerro_1.png" alt="">
            <h3>Comida para Perro</h3>
            <p>Alimento balanceado premium </p>
            <p>Protege el pelaje de tu perro</p>
            <span>S/. 35.00</span>
            
            <div class="acciones">
                <button class="btn">Ver producto</button>
                <button class="btn comprar">Comprar</button>
            </div>
        </div>

        <div class="card">
            <img src="imagen/JugueteGato.jpg" alt="">
            <h3>Juguete para Gato</h3>
            <p>Divertido y resistente</p>
            <span>S/. 15.00</span>

            <div class="acciones">
                <button class="btn">Ver producto</button>
                <button class="btn comprar">Comprar</button>
            </div>    
        </div>

        <div class="card">
            <img src="imagen/CorreAjustable.webp" alt="">
            <h3>Collar Ajustable</h3>
            <p>Para perros medianos Talla (M)</p>
            <span>S/. 25.00</span>
            
            <div class="acciones">
                <button class="btn">Ver producto</button>
                <button class="btn comprar">Comprar</button>
            </div>            
        </div>
        
        <div class="card">
            <img src="imagen/GatoEsterilizado.webp" alt="">
            <h3>Comida para Gatos Esterilizados</h3>
            <p>Ideal para la digestion de tu gato esterilizado</p>
            <span>S/. 35.00</span>
            
            <div class="acciones">
                <button class="btn">Ver producto</button>
                <button class="btn comprar">Comprar</button>
            </div>      
        </div>
        
        <div class="card">
            <img src="imagen/CortaUñas.webp" alt="">
            <h3>Cortauñas Tijera</h3>
            <p>Para Gatos y Facil de Usar</p>
            <span>S/. 15.00</span>
            
            <div class="acciones">
                <button class="btn">Ver producto</button>
                <button class="btn comprar">Comprar</button>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <p>© 2026 Tienda Virtual - PetShop</p>
    <p>Contacto: +51 xxxxxxxx</p>
    <p>Atencion en Linea</p>
</footer>

</body>
</html>