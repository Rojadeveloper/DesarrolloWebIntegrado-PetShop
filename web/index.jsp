<%-- 
    Document   : index.jsp
    Created on : 24 abr 2026, 6:44:17
    Author     : User & Edit by: RonaldoYN
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="modelo.entidad.Usuario" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
        <%-- ✅ LOGO: Apunta al controlador /inicio para no perder los productos --%>
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/inicio">
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
                    <%-- ✅ INICIO: Pasa obligatoriamente por el servlet /inicio --%>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/inicio">
                        Inicio
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vista/cliente/catalogoProductos.jsp"> Ver Productos </a>
                </li>
            </ul>

            <form class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Buscar productos...">
                <button class="btn btn-light" type="submit">🔍</button>
            </form>

            <%-- 🔑 CONTROL DE SESIÓN CON JSTL --%>
            <c:choose>
                <%-- CASO A: SI NO HAY USUARIO LOGUEADO --%>
                <c:when test="${empty sessionScope.usuarioLogueado}">
                    <a class="btn btn-outline-light me-2" href="${pageContext.request.contextPath}/vista/usuario/login.jsp">
                        Login
                    </a>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/vista/usuario/registro.jsp">
                        Registro
                    </a>
                </c:when>
                
                <%-- CASO B: SI EL USUARIO YA INICIÓ SESIÓN --%>
                <c:otherwise>
                    <div class="nav-item dropdown me-2">
                        <a class="btn btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1"></i> Bienvenido, ${sessionScope.nombreUsuario}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            
                            <c:choose>
                                <%-- Menú exclusivo para el Administrador --%>
                                <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                                    <li>
                                        <a class="dropdown-item fw-bold text-success" href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
                                            <i class="fa-solid fa-gauge me-2"></i> Panel Dashboard
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-user-gear me-2"></i> Mi Perfil (Admin)
                                        </a>
                                    </li>
                                </c:when>
                                
                                <%-- Menú exclusivo para Clientes Compradores --%>
                                <c:otherwise>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-id-card me-2"></i> Mi Perfil
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/carrito.jsp">
                                            <i class="fa-solid fa-bag-shopping me-2"></i> Ver Carrito
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <%-- ✅ LOGOUT: Apunta a tu servlet de cierre de sesión --%>
                                <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
                
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
    <h2 class="text-center fw-bold my-4 text-dark">Productos Destacados</h2>

    <div class="container py-2">
        <div class="row g-4 justify-content-center">
            
            <%-- JSTL puro evaluando la lista inyectada por el Servlet --%>
            <c:choose>
                <c:when test="${not empty productosBD}">
                    <c:forEach var="prod" items="${productosBD}">
                        <div class="col-lg-3 col-md-4 col-sm-6 d-flex align-items-stretch">
                            
                            <%-- Tarjeta con alto unificado (h-100) --%>
                            <div class="product-card card shadow-sm border-0 w-100 d-flex flex-column justify-content-between p-3 bg-white rounded-3" 
                                 data-id="${prod.idProducto}" 
                                 data-nombre="${prod.nombre}" 
                                 data-precio="${prod.precio}" 
                                 data-imagen="${pageContext.request.contextPath}/imagen/${prod.imagen}">
                                
                                <%-- Contenedor de la Imagen: Ajusta tamaños sin deformar --%>
                                <div class="product-img-container d-flex align-items-center justify-content-center overflow-hidden mb-3" 
                                     style="height: 180px; background-color: #f8f9fa; border-radius: 8px; padding: 10px;">
                                    <img src="${pageContext.request.contextPath}/imagen/${prod.imagen}" 
                                         style="max-width: 100%; max-height: 100%; object-fit: contain;" 
                                         alt="${prod.nombre}"
                                         onerror="this.src='https://placehold.co/250x250?text=PetShop';">
                                </div>
                                
                                <%-- Información del Producto --%>
                                <div class="card-info flex-grow-1 d-flex flex-column justify-content-between">
                                    <div>
                                        <h6 class="fw-bold text-dark text-truncate mb-1" style="font-size: 15px;">${prod.nombre}</h6>
                                        <p class="text-muted small mb-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 34px; line-height: 17px;">
                                            ${not empty prod.descripcion ? prod.descripcion : "Sin descripción."}
                                        </p>
                                    </div>
                                    
                                    <div class="d-flex justify-content-between align-items-center my-2">
                                        <span class="fw-bold text-success fs-5">S/. ${prod.precio}</span>
                                        <span class="badge bg-light text-secondary border font-monospace" style="font-size: 11px;">Stock: ${prod.stock}</span>
                                    </div>

                                    <%-- Botonera adaptativa --%>
                                    <div class="acciones d-grid gap-2 mt-2">
                                        <a href="${pageContext.request.contextPath}/especsProduc?id=${prod.idProducto}" 
                                           class="btn btn-outline-dark btn-sm rounded-2 py-2 fw-semibold">
                                            <i class="fa-solid fa-magnifying-glass me-1"></i> Ver detalles
                                        </a>
        
                                        <c:choose>
                                            <c:when test="${empty sessionScope.usuarioLogueado}">
                                                <a href="${pageContext.request.contextPath}/vista/usuario/login.jsp" 
                                                   class="btn btn-warning btn-sm fw-bold rounded-2 py-2 text-dark" style="background-color: #ffc107; border:none;">
                                                    <i class="fa-solid fa-basket-shopping me-1"></i> Comprar
                                                </a>
                                            </c:when>
    
                                            <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                                                <a href="${pageContext.request.contextPath}/vista/cliente/carrito.jsp" 
                                                   class="btn btn-secondary btn-sm fw-bold rounded-2 py-2">
                                                    <i class="fa-solid fa-user-gear me-1"></i> Agregar (Admin)
                                                </a>
                                            </c:when>
    
                                            <c:otherwise>
                                                <button type="button" class="btn btn-success btn-sm fw-bold rounded-2 py-2 btn-agregar-carrito">
                                                    <i class="fa-solid fa-cart-plus me-1"></i> Agregar al carro
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fa-solid fa-store-slash text-muted display-3 mb-2"></i>
                        <p class="text-muted fs-5">No se pudieron cargar los productos desde el controlador.</p>
                    </div>
                </c:otherwise>
            </c:choose>
            
        </div>
    </div>
</section>
            
<footer class="footer py-5">
    <div class="container">
        <div class="row g-4">
            
            <div class="col-lg-3 col-md-6 footer-col">
                <h5 class="fw-bold mb-3">Visítanos</h5>
                <ul class="list-unstyled d-flex flex-column gap-2">
                    <li><i class="fa-solid fa-location-dot me-2"></i> Av. Las Flores 123, Miraflores, Lima, Perú</li>
                    <li><i class="fa-solid fa-clock me-2"></i> Lun. a Sáb. de 9:00am a 8:00pm</li>
                    <li><i class="fa-solid fa-phone me-2"></i> +51 970606134 / (01) 396-6832</li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6 footer-col text-center d-flex align-items-center justify-content-center">
                <p class="fst-italic footer-quote px-2">
                    “Descubre una nueva forma de engreír a tu mejor amigo”
                </p>
            </div>

            <div class="col-lg-3 col-md-6 footer-col ps-lg-4">
                <h5 class="fw-bold mb-3">Te ayudamos</h5>
                <ul class="list-unstyled d-flex flex-column gap-2">
                    <li><a href="#" class="footer-link">Sobre Nosotros</a></li>
                    <li><a href="#" class="footer-link">Términos y Condiciones</a></li>
                </ul>
                <div class="mt-3">
                    <a href="#" class="d-inline-block border rounded p-2 bg-white text-dark text-decoration-none shadow-sm font-monospace" style="font-size: 11px;">
                        📖 <strong>Libro de Reclamaciones</strong>
                    </a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 footer-col">
                <h5 class="fw-bold mb-3">Ruta PetShop</h5>
                <ul class="list-unstyled d-flex flex-column gap-2 mb-4">
                    <li><a href="<%= request.getContextPath() %>/vista/cliente/catalogoProductos.jsp" class="footer-link">Productos para Perros</a></li>
                    <li><a href="<%= request.getContextPath() %>/vista/cliente/catalogoProductos.jsp" class="footer-link">Productos para Gatos</a></li>
                    <li><a href="#" class="footer-link">Contáctate con un asesor</a></li>
                </ul>
                
                <h5 class="fw-bold mb-3 fs-6">Síguenos en:</h5>
                <div class="d-flex gap-2 footer-socials">
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-tiktok"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-whatsapp"></i></a>
                </div>
            </div>

        </div>

        <hr class="mt-5 mb-4 border-secondary opacity-20">
        <div class="row">
            <div class="col text-center text-muted small">
                <p class="mb-0">&copy; 2026 PetShop es una marca registrada de Tienda Virtual Mascotas S.A.C.</p>
            </div>
        </div>
    </div>
</footer>

<div class="offcanvas offcanvas-end custom-cart-canvas" tabindex="-1" id="carritoSidebar" aria-labelledby="carritoSidebarLabel">
    
    <div class="offcanvas-header border-bottom py-3">
        <h5 class="offcanvas-title fw-bold text-dark" id="carritoSidebarLabel">
            🛒 Mi Carrito <span class="badge bg-secondary ms-1 fs-6 rounded-pill JSON-contador">0</span>
        </h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    
    <div class="offcanvas-body d-flex flex-column justify-content-between">
        
        <div id="carritoContenidoDinamico" class="overflow-y-auto pe-1" style="max-height: 55vh;"></div>
        
        <div id="estadoVacioOriginal" class="cart-empty-state my-auto text-center">
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
                <span class="fw-bold text-dark fs-4" id="cart-monto-total">S/. 0.00</span>
            </div>
            <button class="btn custom-btn comprar w-100 py-3 fs-6" id="btnProcesarPago" disabled>
                Ir a pagar compra
            </button>
        </div>

    </div>
</div>
     
<template id="molde-item-carrito">
    <div class="cart-item d-flex align-items-center justify-content-between p-2 mb-2 bg-white rounded border shadow-sm">
        <div class="d-flex align-items-center gap-2">
            <img class="img-item-cart" style="width: 50px; height: 50px; object-fit: contain;" src="" alt="">
            <div>
                <h6 class="mb-0 fw-bold text-dark text-truncate nombre-item-cart" style="max-width: 130px;"></h6>
                <small class="text-muted info-precio-cart"></small>
            </div>
        </div>
        <div class="d-flex align-items-center gap-1">
            <span class="fw-bold text-success subtotal-item-cart"></span>
            <button type="button" class="btn btn-sm text-danger btn-eliminar-item">
                <i class="fa-solid fa-trash"></i>
            </button>
        </div>
    </div>
</template>
                    
<%-- Corregido el path del script JS para evitar bloqueos de ejecución --%>
<script src="<%= request.getContextPath() %>/Js/carrito-global.js"></script>

<script>
    var btnPago = document.getElementById("btnProcesarPago");
    if (btnPago) {
        btnPago.addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/vista/cliente/carrito.jsp";
        });
    }
</script>
     
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>