<%-- 
    Document   : index.jsp
    Created on : 24 abr 2026, 6:44:17
    Author     : User & Edit by: RonaldoYN
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="modelo.entidad.Usuario" %>
<%
    // 🛡️ Limpieza estricta de caché: Fuerza al navegador a pedir los datos limpios al servidor
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PetShop - Productos para Mascotas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/EstiloGlobal.css">
    <link rel="stylesheet" href="css/Responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/index.jsp">
            🐾 PetShop
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse gap-2" id="menu">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/index.jsp">
                        Inicio
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/vista/cliente/catalogoProductos.jsp"> Ver Productos </a>
                </li>
            </ul>

            <form class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Buscar productos...">
                <button class="btn btn-light" type="submit">🔍</button>
            </form>

            <% 
                // VERIFICACIÓN DE SESIÓN activa
                if (session.getAttribute("usuarioLogueado") == null) { 
            %>
                <a class="btn btn-outline-light me-2" href="<%= request.getContextPath() %>/vista/usuario/login.jsp">
                    Login
                </a>

                <a class="btn btn-warning" href="<%= request.getContextPath() %>/vista/usuario/registro.jsp">
                    Registro
                </a>
            <% 
                } else { 
                    // Capturamos el objeto completo para verificar el ROL en tiempo real
                    Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");
                    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
            %>
                <div class="nav-item dropdown me-2">
                    <a class="btn btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-user me-1"></i> Bienvenido, <%= nombreUsuario %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow">
                        
                        <%-- 🔑 CONDICIONAL INTELIGENTE SEGÚN EL ROL --%>
                        <% if (userLogueado != null && "ADMIN".equals(userLogueado.getRol())) { %>
                            <%-- Menú exclusivo para el Administrador --%>
                            <li>
                                <a class="dropdown-item fw-bold text-success" href="<%= request.getContextPath() %>/vista/admin/dashboard.jsp">
                                    <i class="fa-solid fa-gauge me-2"></i> Panel Dashboard
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/vista/cliente/perfil.jsp">
                                    <i class="fa-solid fa-user-gear me-2"></i> Mi Perfil (Admin)
                                </a>
                            </li>
                        <% } else { %>
                            <%-- Menú exclusivo para Clientes Compradores --%>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/vista/cliente/perfil.jsp">
                                    <i class="fa-solid fa-id-card me-2"></i> Mi Perfil
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/vista/cliente/carrito.jsp">
                                    <i class="fa-solid fa-bag-shopping me-2"></i> Ver Carrito
                                </a>
                            </li>
                        <% } %>
                        
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger fw-bold" href="<%= request.getContextPath() %>/logout">
                                <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </div>
            <% 
                } 
            %>
                
            <a class="btn btn-light position-relative me-2" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                🛒 Carrito
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    0
                </span>
            </a>
        </div>
    </div>
</nav>

<div id="petCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="8000">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#petCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#petCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#petCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>

    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=1200&auto=format&fit=crop" class="d-block w-100 carousel-img" alt="Perros felices">
            <div class="carousel-caption custom-caption">
                <span class="badge-premium">🐾 Especial Canino</span>
                <h2>¡Todo para tu Mejor Amigo!</h2>
                <p>Descubre alimentos premium, juguetes interactivos y accesorios con 20% de descuento directo.</p>
                <a href="#productos" class="btn-carousel">Ver Catálogo</a>
            </div>
        </div>

        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=1200&auto=format&fit=crop" class="d-block w-100 carousel-img" alt="Michis felices">
            <div class="carousel-caption custom-caption">
                <span class="badge-premium">🐱 Universo Felino</span>
                <h2>Confort para tus Michis</h2>
                <p>Rascadores modernos, arenas ecológicas y snacks deliciosos para mantenerlos saludables.</p>
                <a href="#productos" class="btn-carousel">Ver Productos</a>
            </div>
        </div>

        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?q=80&w=1200&auto=format&fit=crop" class="d-block w-100 carousel-img" alt="Cuidado animal">
            <div class="carousel-caption custom-caption">
                <span class="badge-premium">❤️ Cuidado Diario</span>
                <h2>Salud e Higiene Superior</h2>
                <p>Vitaminas, shampoos especializados y servicios de grooming con profesionales certificados.</p>
                <a href="#productos" class="btn-carousel">Saber Más</a>
            </div>
        </div>
    </div>
</div>

<section id="productos" class="productos">
    <h2>Productos destacados</h2>

    <div class="container py-4">
        <div class="row g-4 justify-content-center">
            
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="product-card">
                    <div class="product-img-container">
                        <img src="imagen/ComidaPerro_1.png" class="img-fluid" alt="Comida Perro">
                    </div>
                    <h3>Comida para Perro</h3>
                    <p>Alimento balanceado premium. Protege el pelaje de tu perro.</p>
                    <span>S/. 35.00</span>
                    <div class="acciones">
                        <button class="custom-btn ver-producto-btn">Ver producto</button>
                        <% if (session.getAttribute("usuarioLogueado") == null) { %>
                            <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/CarritoServlet?accion=agregar&id=1" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="product-card">
                    <div class="product-img-container">
                        <img src="imagen/JugueteGato.jpg" class="img-fluid" alt="Juguete Gato">
                    </div>
                    <h3>Juguete para Gato</h3>
                    <p>Divertido y resistente para el entertainment de tu michi.</p>
                    <span>S/. 15.00</span>
                    <div class="acciones">
                        <button class="custom-btn ver-producto-btn">Ver producto</button>
                        <% if (session.getAttribute("usuarioLogueado") == null) { %>
                            <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/CarritoServlet?accion=agregar&id=2" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } %>
                    </div>    
                </div>
            </div>    
            
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="product-card">
                    <div class="product-img-container">
                        <img src="imagen/CorreAjustable.webp" class="img-fluid" alt="Collar">
                    </div>
                    <h3>Collar Ajustable</h3>
                    <p>Para perros medianos Talla (M). Material ergonómico.</p>
                    <span>S/. 25.00</span>
                    <div class="acciones">
                        <button class="custom-btn ver-producto-btn">Ver producto</button>
                        <% if (session.getAttribute("usuarioLogueado") == null) { %>
                            <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/CarritoServlet?accion=agregar&id=3" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } %>
                    </div>            
                </div>
            </div>
            
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="product-card">
                    <div class="product-img-container">
                        <img src="imagen/GatoEsterilizado.webp" class="img-fluid" alt="Comida Gato">
                    </div>
                    <h3>Comida-Gatos Esterilizados</h3>
                    <p>Ideal para la digestión y control de peso de tu gato.</p>
                    <span>S/. 35.00</span>
                    <div class="acciones">
                        <button class="custom-btn ver-producto-btn">Ver producto</button>
                        <% if (session.getAttribute("usuarioLogueado") == null) { %>
                            <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/CarritoServlet?accion=agregar&id=4" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } %>
                    </div>      
                </div>
            </div>
            
            <div class="col-lg-3 col-md-4 col-sm-6">
                <div class="product-card">
                    <div class="product-img-container">
                        <img src="imagen/CortaUnas.webp" class="img-fluid" alt="Cortauñas">
                    </div>
                    <h3>Cortauñas Tijera</h3>
                    <p>Para gatos y animales pequeños - Fácil de usar.</p>
                    <span>S/. 15.00</span>
                    <div class="acciones">
                        <button class="custom-btn ver-producto-btn">Ver producto</button>
                        <% if (session.getAttribute("usuarioLogueado") == null) { %>
                            <a href="<%= request.getContextPath() %>/vista/usuario/login.jsp" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/CarritoServlet?accion=agregar&id=5" class="custom-btn comprar text-decoration-none text-center d-flex align-items-center justify-content-center">Comprar</a>
                        <% } %>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</section>

<footer class="footer">
    <p>© 2026 Tienda Virtual - PetShop</p>
    <p>Contacto: +51 xxxxxxxx</p>
    <p>Atención en Línea</p>
</footer>

<div class="offcanvas offcanvas-end custom-cart-canvas" tabindex="-1" id="carritoSidebar" aria-labelledby="carritoSidebarLabel">
    
    <div class="offcanvas-header border-bottom py-3">
        <h5 class="offcanvas-title fw-bold text-dark" id="carritoSidebarLabel">
            🛒 Mi Carrito <span class="badge bg-secondary ms-1 fs-6 rounded-pill">0</span>
        </h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    
    <div class="offcanvas-body d-flex flex-column justify-content-between">
        
        <div class="cart-empty-state my-auto text-center">
            <div class="cart-empty-icon mb-4">
                <span class="display-1 text-muted opacity-50">🛒</span>
            </div>
            <h5 class="fw-bold text-secondary">Tu carrito aún está vacío</h5>
            <p class="text-muted small px-4">Explora nuestra tienda y agrega los mejores productos para tus mascotas.</p>
            <button class="btn custom-btn comprar mt-2 w-auto px-4" data-bs-dismiss="offcanvas">
                Comenzar a comprar
            </button>
        </div>

        <div class="cart-footer border-top pt-3 mt-auto">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <span class="fw-bold text-secondary">Total estimado:</span>
                <span class="fw-bold text-dark fs-4">S/. 0.00</span>
            </div>
            <button class="btn custom-btn comprar w-100 py-3 fs-6" disabled>
                Ir a pagar compra
            </button>
        </div>

    </div>
</div>
                    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>