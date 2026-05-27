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
            
            <%
                // Cargamos de forma nativa los productos fijos de la base de datos
                modelo.dao.IProductoDAO prodDAO = new modelo.dao.impl.ProductoDAOImpl();
                java.util.List<modelo.entidad.Producto> listaProductos = prodDAO.listarOchoProductosFijos();
                
                // Los guardamos en el request para que JSTL pueda leerlos mediante Expression Language (${})
                request.setAttribute("productosBD", listaProductos);
            %>
            
            <%-- Evaluamos con JSTL si la lista obtenida de la base de datos no está vacía --%>
            <c:choose>
                <c:when test="${not empty productosBD}">
                    <%-- Iteramos dinámicamente los productos traídos de la base de datos --%>
                    <c:forEach var="prod" items="${productosBD}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card" 
                                 data-id="${prod.idProducto}" 
                                 data-nombre="${prod.nombre}" 
                                 data-precio="${prod.precio}" 
                                 data-imagen="${prod.imagen}">
                                
                                <div class="product-img-container">
                                    <img src="${prod.imagen}" class="img-fluid" alt="${prod.nombre}">
                                </div>
                                <h3>${prod.nombre}</h3>
                                <p>${not empty prod.descripcion ? prod.descripcion : ""}</p>
                                <span>S/. ${prod.precio}</span>

<div class="acciones">
    <%-- 🔍 VER PRODUCTO: Envía el ID por la URL --%>
    <a href="${pageContext.request.contextPath}/especsProduc?id=${prod.idProducto}" 
       class="custom-btn ver-producto-btn text-decoration-none text-center d-inline-flex align-items-center justify-content-center">
        Ver producto
    </a>
    
    <c:choose>
        <%-- CASO 1: SI NO ESTÁ LOGUEADO --%>
        <c:when test="${sessionScope.usuarioLogueado == null}">
            <a href="${pageContext.request.contextPath}/vista/usuario/login.jsp" 
               class="custom-btn comprar text-decoration-none text-center d-inline-flex align-items-center justify-content-center">
                Comprar
            </a>
        </c:when>

        <%-- CASO 2: SI ES UN ADMIN --%>
        <c:when test="${sessionScope.usuarioLogueado.rol == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/vista/cliente/carrito.jsp" 
               class="custom-btn comprar text-decoration-none text-center d-inline-flex align-items-center justify-content-center">
                Agregar (Admin)
            </a>
        </c:when>

        <%-- CASO 3: SI ES UN CLIENTE LOGUEADO --%>
        <c:otherwise>
            <button type="button" class="custom-btn comprar btn-agregar-carrito">
                Agregar al carro
            </button>
        </c:otherwise>
    </c:choose>
</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <p class="text-muted">No hay productos disponibles en este momento.</p>
                    </div>
                </c:otherwise>
            </c:choose>
            
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

<script>
var carrito = [];
try {
    carrito = JSON.parse(localStorage.getItem('petshop_cart')) || [];
} catch(e) {
    carrito = [];
}

document.addEventListener("DOMContentLoaded", function() {
    actualizarInterfazCarrito();

    // 🔄 Inicializamos el control del Offcanvas usando la librería nativa de Bootstrap
    var miOffcanvasElemento = document.getElementById('carritoSidebar');
    var bsOffcanvas = miOffcanvasElemento ? new bootstrap.Offcanvas(miOffcanvasElemento) : null;

    document.body.addEventListener("click", function(e) {
        var botonAgregar = e.target.closest(".btn-agregar-carrito");
        var botonEliminar = e.target.closest(".btn-eliminar-item");

        if (botonAgregar) {
            var card = botonAgregar.closest(".product-card");
            if (card) {
                var producto = {
                    id: card.dataset.id,
                    nombre: card.dataset.nombre,
                    precio: parseFloat(card.dataset.precio) || 0,
                    imagen: card.dataset.imagen,
                    cantidad: 1
                };
                agregarAlCarrito(producto);
                
                // 🚀 ¡AQUÍ ESTÁ LA MAGIA! Si el Offcanvas existe, ordénale que se abra en pantalla
                if (bsOffcanvas) {
                    bsOffcanvas.show();
                }
            }
        }
        
        if (botonEliminar) {
            var idProd = botonEliminar.getAttribute("data-id");
            eliminarDelCarrito(idProd);
        }
    });

    var btnPago = document.getElementById("btnProcesarPago");
    if (btnPago) {
        btnPago.addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/vista/cliente/carrito.jsp";
        });
    }
});

function agregarAlCarrito(producto) {
    var itemExistente = null;
    for (var i = 0; i < carrito.length; i++) {
        if (carrito[i].id === producto.id) {
            itemExistente = carrito[i];
            break;
        }
    }
    
    if (itemExistente) {
        itemExistente.cantidad++;
    } else {
        carrito.push(producto);
    }
    salvarCarrito();
}

function eliminarDelCarrito(id) {
    carrito = carrito.filter(function(item) {
        return item.id !== id;
    });
    salvarCarrito();
}

function salvarCarrito() {
    localStorage.setItem('petshop_cart', JSON.stringify(carrito));
    actualizarInterfazCarrito();
}

function actualizarInterfazCarrito() {
    var contenedorLista = document.getElementById("carritoContenidoDinamico");
    var vistaVacia = document.getElementById("estadoVacioOriginal");
    var txtTotal = document.getElementById("cart-monto-total");
    var btnPago = document.getElementById("btnProcesarPago");
    var molde = document.getElementById("molde-item-carrito");
    
    if (!contenedorLista || !vistaVacia || !txtTotal || !btnPago || !molde) return;

    var totalItems = 0;
    var montoTotal = 0;
    for (var i = 0; i < carrito.length; i++) {
        totalItems += carrito[i].cantidad;
        montoTotal += (carrito[i].precio * carrito[i].cantidad);
    }
    
    var badges = document.querySelectorAll(".position-absolute.top-0.badge, .JSON-contador");
    badges.forEach(function(b) {
        b.innerText = totalItems;
    });

    contenedorLista.innerHTML = "";

    if (carrito.length === 0) {
        vistaVacia.style.display = "block";
        txtTotal.innerText = "S/. 0.00";
        btnPago.disabled = true;
        return;
    }

    vistaVacia.style.display = "none";
    txtTotal.innerText = "S/. " + montoTotal.toFixed(2);
    btnPago.disabled = false;

    carrito.forEach(function(item) {
        var clon = molde.content.cloneNode(true);
        
        clon.querySelector(".img-item-cart").src = item.imagen;
        clon.querySelector(".img-item-cart").alt = item.nombre;
        clon.querySelector(".nombre-item-cart").innerText = item.nombre;
        clon.querySelector(".info-precio-cart").innerText = "S/. " + item.precio.toFixed(2) + " x " + item.cantidad;
        clon.querySelector(".subtotal-item-cart").innerText = "S/. " + (item.precio * item.cantidad).toFixed(2);
        clon.querySelector(".btn-eliminar-item").setAttribute("data-id", item.id);
        
        contenedorLista.appendChild(clon);
    });
}
</script>        
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>