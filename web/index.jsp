<%-- 
    Document   : index.jsp
    Created on : 24 abr 2026, 6:44:17
    Author     : User & Edit by: RonaldoYN
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="modelo.entidad.Usuario" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // Limpieza estricta de caché a nivel de servidor
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", 0); 
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

    <%-- Inclusión de Componentes Comunes --%>
    <jsp:include page="vista/Extra/Navbar.jsp" />
    <jsp:include page="vista/Extra/carrito-sidebar.jsp" />

    <%-- Carrusel Informativo --%>
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
   
    <%-- sCatálogo Dinámico de Productos --%>
    <section id="productos" class="productos">
        <h2 class="text-center fw-bold my-4 text-dark">Productos Destacados</h2>

        <div class="container py-2">
            <div class="row g-4 justify-content-center">
                <c:choose>
                    <c:when test="${not empty productosBD}">
                        <c:forEach var="prod" items="${productosBD}">
                            <div class="col-lg-3 col-md-4 col-sm-6 d-flex align-items-stretch">
                                
                                <div class="product-card card shadow-sm border-0 w-100 d-flex flex-column justify-content-between p-3 bg-white rounded-3" 
                                     data-id="${prod.idProducto}" 
                                     data-nombre="${prod.nombre}" 
                                     data-precio="${prod.precio}" 
                                     data-imagen="${pageContext.request.contextPath}/imagen/${prod.imagen}">
                                    
                                    <div class="product-img-container d-flex align-items-center justify-content-center overflow-hidden mb-3" 
                                         style="height: 180px; background-color: #f8f9fa; border-radius: 8px; padding: 10px;">
                                        <img src="${pageContext.request.contextPath}/imagen/${prod.imagen}" 
                                             style="max-width: 100%; max-height: 100%; object-fit: contain;" 
                                             alt="${prod.nombre}"
                                             onerror="this.src='https://placehold.co/250x250?text=PetShop';">
                                    </div>
                                    
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
                                            <%-- Botonera adaptativa dentro de index.jsp --%>
                                            <div class="acciones d-grid gap-2 mt-2">
                                                <a href="${pageContext.request.contextPath}/especsProduc?id=${prod.idProducto}" 
                                                   class="btn btn-outline-dark btn-sm rounded-2 py-2 fw-semibold">
                                                    <i class="fa-solid fa-magnifying-glass me-1"></i> Ver detalles
                                                </a>

                                                <c:choose>
                                                    <%-- Si no hay sesión, lo mandamos a loguearse --%>
                                                    <c:when test="${empty sessionScope.usuarioLogueado}">
                                                        <a href="${pageContext.request.contextPath}/vista/usuario/login.jsp" 
                                                           class="btn btn-warning btn-sm fw-bold rounded-2 py-2 text-dark" style="background-color: #ffc107; border:none;">
                                                            <i class="fa-solid fa-basket-shopping me-1"></i> Comprar
                                                        </a>
                                                    </c:when>

                                                    <%-- Si está logueado (ya sea CLIENTE o ADMIN), ambos usan la misma funcionalidad del carrito --%>
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
          
    <%-- Inclusión de Pie de Página --%>
    <jsp:include page="vista/Extra/Footer.jsp" />
    
    <%-- ⚡ Scripts de Funcionalidad Global --%>
    <script src="${pageContext.request.contextPath}/Js/carrito-global.js"></script>    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>