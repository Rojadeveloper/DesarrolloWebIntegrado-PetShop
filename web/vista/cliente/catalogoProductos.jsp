<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.entidad.Producto" %> 
<%@ page import="modelo.entidad.Categoria" %> 
<%@ page import="modelo.entidad.Usuario" %>
<%@ page import="modelo.dao.IProductoDAO" %>
<%@ page import="modelo.dao.impl.ProductoDAOImpl" %>
<%@ page import="modelo.dao.ICategoriaDAO" %>
<%@ page import="modelo.dao.impl.CategoriaDAOImpl" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // 🛡️ Inicialización de capas de datos a nivel de servidor (Request Scope para JSTL)
    try {
        IProductoDAO prodDAO = new ProductoDAOImpl();
        ICategoriaDAO catDAO = new CategoriaDAOImpl();

        int idCatSeleccionada = 0;
        String paramCat = request.getParameter("idCat");
        if (paramCat != null && !paramCat.trim().isEmpty()) {
            idCatSeleccionada = Integer.parseInt(paramCat);
        }
        
        // Guardamos todo de forma explícita para que JSTL Expressions pueda leerlo sin problemas
        request.setAttribute("idCatSeleccionada", idCatSeleccionada);
        request.setAttribute("listaCategorias", catDAO.listarCategorias());
        request.setAttribute("listaDestacados", prodDAO.listarProductosDestacados());
        request.setAttribute("listaProductos", prodDAO.listarProductosPorCategoria(idCatSeleccionada));
    } catch(Exception e) {
        System.out.println("Error procesando datos en el Catálogo: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo Oficial - PetShop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloCatalogo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Responsive.css">
</head>

<body class="body-cyberpunk">

<jsp:include page="/vista/Extra/Navbar.jsp" />
<jsp:include page="/vista/Extra/carrito-sidebar.jsp" />

<div id="heroPetCarousel" class="carousel slide carousel-fade my-4" data-bs-ride="carousel" data-bs-interval="8000">
    
    <div class="carousel-inner container-hero-slider">
        
        <div class="carousel-item active">
            <div class="row align-items-center h-100 px-4 px-md-5">
                <div class="col-lg-6 order-2 order-lg-1 txt-hero-side">
                    <span class="badge badge-subtitulo mb-2">Nutrición Felina Especializada</span>
                    <h1 class="display-5 fw-black text-dark-custom mb-2">Alimentos Premium <br>para tu <span class="text-gradient-purple">Gato</span></h1>
                    <p class="text-muted-custom mb-3 fs-6">Dale a tu felino la vitalidad que necesita con croquetas y recetas húmedas balanceadas de alta gama.</p>
                    <a href="#productos-seccion" class="btn btn-hero-orange btn-sm-custom">Ver Nutrición Felina</a>
                </div>
                <div class="col-lg-5 order-1 order-lg-2 position-relative d-flex justify-content-center align-items-center img-hero-side">
                    <div class="blob-decorativo"></div>
                    <img src="${pageContext.request.contextPath}/imagen/mascota1.png" class="img-fluid img-mascota-hero" alt="Alimento para Gato">
                </div>
            </div>
        </div>

        <div class="carousel-item">
            <div class="row align-items-center h-100 px-4 px-md-5">
                <div class="col-lg-6 order-2 order-lg-1 txt-hero-side">
                    <span class="badge badge-subtitulo mb-2">Energía y Desarrollo Canino</span>
                    <h1 class="display-5 fw-black text-dark-custom mb-2">Máxima Nutrición <br>para tu <span class="text-gradient-purple">Perro</span></h1>
                    <p class="text-muted-custom mb-3 fs-6">Fórmulas científicamente desarrolladas para proteger sus articulaciones, pelaje y sistema inmune.</p>
                    <a href="#productos-seccion" class="btn btn-hero-orange btn-sm-custom">Ver Alimentos de Perro</a>
                </div>
                <div class="col-lg-5 order-1 order-lg-2 position-relative d-flex justify-content-center align-items-center img-hero-side">
                    <div class="blob-decorativo blob-crema-oscuro"></div>
                    <img src="${pageContext.request.contextPath}/imagen/mascota2.png" class="img-fluid img-mascota-hero" alt="Alimento para Perro">
                </div>
            </div>
        </div>

        <div class="carousel-item">
            <div class="row align-items-center h-100 px-4 px-md-5">
                <div class="col-lg-6 order-2 order-lg-1 txt-hero-side">
                    <span class="badge badge-subtitulo mb-2">Entretenimiento e Instinto Felino</span>
                    <h1 class="display-5 fw-black text-dark-custom mb-2">Juguetes Activos <br>para tu <span class="text-gradient-purple">Gato</span></h1>
                    <p class="text-muted-custom mb-3 fs-6">Rascadores, ratones interactivos y circuitos diseñados para estimular el juego en casa.</p>
                    <a href="#productos-seccion" class="btn btn-hero-orange btn-sm-custom">Ver Juguetes de Gato</a>
                </div>
                <div class="col-lg-5 order-1 order-lg-2 position-relative d-flex justify-content-center align-items-center img-hero-side">
                    <div class="blob-decorativo"></div>
                    <img src="${pageContext.request.contextPath}/imagen/mascota3.png" class="img-fluid img-mascota-hero" alt="Juguetes para Gato">
                </div>
            </div>
        </div>

        <div class="carousel-item">
            <div class="row align-items-center h-100 px-4 px-md-5">
                <div class="col-lg-6 order-2 order-lg-1 txt-hero-side">
                    <span class="badge badge-subtitulo mb-2">Diversión y Resistencia Canina</span>
                    <h1 class="display-5 fw-black text-dark-custom mb-2">Juguetes de Acción <br>para tu <span class="text-gradient-purple">Perro</span></h1>
                    <p class="text-muted-custom mb-3 fs-6">Mordedores ultra resistentes, pelotas con rebote y cuerdas ideales para reducir la ansiedad.</p>
                    <a href="#productos-seccion" class="btn btn-hero-orange btn-sm-custom">Ver Juguetes de Perro</a>
                </div>
                <div class="col-lg-5 order-1 order-lg-2 position-relative d-flex justify-content-center align-items-center img-hero-side">
                    <div class="blob-decorativo blob-crema-oscuro"></div>
                    <img src="${pageContext.request.contextPath}/imagen/mascota4.png" class="img-fluid img-mascota-hero" alt="Juguetes para Perro">
                </div>
            </div>
        </div>

        <div class="hero-lateral-thumbnails d-none d-xl-flex">
            <div class="thumb-btn active" data-bs-target="#heroPetCarousel" data-bs-slide-to="0">
                <div class="thumb-circle">
                    <img src="${pageContext.request.contextPath}/imagen/mascota1_mini.png" alt="Mini Gato Alimento">
                </div>
            </div>
            <div class="thumb-btn" data-bs-target="#heroPetCarousel" data-bs-slide-to="1">
                <div class="thumb-circle">
                    <img src="${pageContext.request.contextPath}/imagen/mascota2_mini.png" alt="Mini Perro Alimento">
                </div>
            </div>
            <div class="thumb-btn" data-bs-target="#heroPetCarousel" data-bs-slide-to="2">
                <div class="thumb-circle">
                    <img src="${pageContext.request.contextPath}/imagen/mascota3_mini.png" alt="Mini Gato Juguetes">
                </div>
            </div>
            <div class="thumb-btn" data-bs-target="#heroPetCarousel" data-bs-slide-to="3">
                <div class="thumb-circle">
                    <img src="${pageContext.request.contextPath}/imagen/mascota4_mini.png" alt="Mini Perro Juguetes">
                </div>
            </div>
        </div>

    </div>
</div>

    <div class="container my-5">
        
        <div class="seccion-destacados mb-5 shadow-sm p-4 rounded-3">
            <div class="d-flex align-items-center mb-4">
                <div class="bg-danger text-white p-2 rounded-3 me-3 shadow-sm">
                    <i class="fa-solid fa-fire fa-lg"></i>
                </div>
                <div>
                    <h3 class="mb-0 fw-bold text-white">¡Últimas Unidades!</h3>
                    <p class="text-muted small mb-0">Los productos más buscados que están por agotarse</p>
                </div>
            </div>
            
            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty requestScope.listaDestacados}">
                        <c:forEach var="pDest" items="${requestScope.listaDestacados}">
                            <div class="col-6 col-md-4 col-lg-3 d-flex">
                                <div class="card-producto-premium product-card card w-100 border-0 shadow-sm rounded-3 p-2 h-100 d-flex flex-column justify-content-between"
                                     data-id="${pDest.idProducto}" 
                                     data-nombre="${pDest.nombre}" 
                                     data-precio="${pDest.precio}" 
                                     data-imagen="${pageContext.request.contextPath}/imagen/${pDest.imagen}">
                                     
                                    <div class="img-container position-relative overflow-hidden" style="height: 160px; background-color: #f8f9fa; border-radius: 8px;">
                                        <span class="badge bg-danger position-absolute top-2 start-2 shadow-sm z-3">
                                            <i class="fa-solid fa-triangle-exclamation me-1"></i> Solo ${pDest.stock}
                                        </span>
                                        <img src="${pageContext.request.contextPath}/imagen/${pDest.imagen}" 
                                             class="w-100 h-100 p-2" style="object-fit: contain;" alt="${pDest.nombre}" 
                                             onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                                    </div>
                                    
                                    <div class="card-body-premium flex-grow-1 d-flex flex-column justify-content-between pt-2">
                                        <div>
                                            <h6 class="product-title fw-bold text-dark text-truncate mb-1">${pDest.nombre}</h6>
                                            <p class="product-desc text-muted small text-truncate-2" style="height: 36px; overflow: hidden;">${pDest.descripcion}</p>
                                        </div>
                                        <div class="product-footer d-flex justify-content-between align-items-center mt-2">
                                            <span class="product-price fw-bold text-success fs-5">S/. ${pDest.precio}</span>
                                            
                                            <c:choose>
                                                <c:when test="${empty sessionScope.usuarioLogueado}">
                                                    <a href="${pageContext.request.contextPath}/vista/usuario/login.jsp" class="btn btn-sm btn-warning rounded-circle"><i class="fa-solid fa-cart-plus"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="btn-cart-round btn-agregar-carrito btn border-0 p-0 text-white d-flex align-items-center justify-content-center" style="width: 35px; height: 35px; background-color: #198754; border-radius: 50%;">
                                                        <i class="fa-solid fa-cart-plus"></i>
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
                        <div class="col-12">
                            <p class="text-muted fst-italic ps-2">No se registran productos con stock crítico actualmente.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-3">
                <div class="card border-0 shadow-sm p-4 panel-sticky-menu card-cyberpunk rounded-3">
                    <h5 class="fw-bold text-dark mb-4">
                        <i class="fa-solid fa-paw text-warning me-2"></i>Categorías
                    </h5>
                    <div class="d-flex flex-column gap-1">
                        <%-- Botón Mostrar Todo --%>
                        <a href="catalogoProductos.jsp?idCat=0" class="btn btn-categoria d-flex align-items-center justify-content-between ${requestScope.idCatSeleccionada == 0 ? 'active btn-primary' : 'btn-light'}">
                            <span><i class="fa-solid fa-border-all me-2"></i> Todo el catálogo</span>
                            <i class="fa-solid fa-chevron-right small opacity-50"></i>
                        </a>
                        
                        <%-- Lista Dinámica de Categorías --%>
                        <c:forEach var="c" items="${requestScope.listaCategorias}">
                            <a href="catalogoProductos.jsp?idCat=${c.idCategoria}" 
                               class="btn btn-categoria d-flex align-items-center justify-content-between ${requestScope.idCatSeleccionada == c.idCategoria ? 'active btn-primary' : 'btn-light'}">
                                <span><i class="fa-solid fa-tag me-2 small"></i> ${c.nombre}</span>
                                <i class="fa-solid fa-chevron-right small opacity-50"></i>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 px-2 gap-2">
<h4 class="fw-bold text-dark mb-0">
    <i class="fa-solid fa-boxes-stacked text-secondary me-2"></i>
    ${requestScope.idCatSeleccionada == 0 ? 'Nuestros Productos' : 'Filtrado por Categoría'}
</h4>
                    <span class="badge bg-dark px-3 py-2 rounded-pill fw-semibold">${not empty requestScope.listaProductos ? requestScope.listaProductos.size() : 0} artículos listados</span>
                </div>

                <div class="row g-4">
                    <c:choose>
                        <c:when test="${not empty requestScope.listaProductos}">
                            <c:forEach var="p" items="${requestScope.listaProductos}">
                                <div class="col-6 col-md-4 d-flex">
                                    <div class="card-producto-premium product-card card border-0 shadow-sm rounded-3 p-3 w-100 h-100 d-flex flex-column justify-content-between"
                                         data-id="${p.idProducto}" 
                                         data-nombre="${p.nombre}" 
                                         data-precio="${p.precio}" 
                                         data-imagen="${pageContext.request.contextPath}/imagen/${p.imagen}">
                                         
                                        <div class="img-container d-flex align-items-center justify-content-center overflow-hidden mb-2" style="height: 180px; background-color: #f8f9fa; border-radius: 8px;">
                                            <img src="${pageContext.request.contextPath}/imagen/${p.imagen}" class="img-fluid h-100" style="object-fit: contain;" alt="${p.nombre}"
                                                 onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                                        </div>
                                        
                                        <div class="card-body-premium flex-grow-1 d-flex flex-column justify-content-between">
                                            <div>
                                                <h6 class="product-title fw-bold text-dark text-truncate mb-1">${p.getNombre()}</h6>
                                                <p class="product-desc text-muted small text-truncate-2" style="height: 36px; overflow: hidden;">${p.descripcion}</p>
                                                
                                                <div class="d-flex justify-content-between align-items-center mb-3 mt-2">
                                                    <span class="product-price fw-bold text-success fs-5">S/. ${p.precio}</span>
                                                    <span class="badge bg-light text-dark border px-2 py-1 font-monospace" style="font-size: 11px;">Stock: ${p.stock}</span>
                                                </div>
                                            </div>
                                            
                                            <c:choose>
                                                <c:when test="${empty sessionScope.usuarioLogueado}">
                                                    <a href="${pageContext.request.contextPath}/vista/usuario/login.jsp" 
                                                       class="btn btn-warning w-100 fw-bold py-2 rounded-3 text-dark d-flex align-items-center justify-content-center gap-2"
                                                       style="background-color: #ffc107; border: none;">
                                                        <i class="fa-solid fa-basket-shopping"></i> Comprar
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="btn btn-success w-100 fw-bold py-2 rounded-3 d-flex align-items-center justify-content-center gap-2 btn-agregar-carrito border-0">
                                                        <i class="fa-solid fa-cart-plus"></i> Agregar al Carrito
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center py-5">
                                <div class="text-muted mb-3">
                                    <i class="fa-solid fa-face-frown fa-4x opacity-50"></i>
                                </div>
                                <h5 class="text-muted fw-bold">No hay stock disponible en este momento</h5>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
     
    <jsp:include page="/vista/Extra/Footer.jsp" />
    <script src="${pageContext.request.contextPath}/Js/carrito-global.js"></script>
    

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>