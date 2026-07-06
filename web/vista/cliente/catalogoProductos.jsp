<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.entidad.Producto" %> 
<%@ page import="modelo.entidad.Categoria" %> 
<%@ page import="modelo.entidad.Usuario" %>
<%@ page import="modelo.dao.IProductoDAO" %>
<%@ page import="modelo.dao.impl.ProductoDAOImpl" %>
<%@ page import="modelo.dao.ICategoriaDAO" %>
<%@ page import="modelo.dao.impl.CategoriaDAOImpl" %>
<%
    // 1. Instanciamos las capas de datos (DAOs)
    IProductoDAO prodDAO = new ProductoDAOImpl();
    ICategoriaDAO catDAO = new CategoriaDAOImpl();

    // 2. Capturamos el filtro de categoría por URL (0 por defecto = Mostrar Todo)
    int idCatSeleccionada = 0;
    String paramCat = request.getParameter("idCat");
    if (paramCat != null && !paramCat.trim().isEmpty()) {
        try {
            idCatSeleccionada = Integer.parseInt(paramCat);
        } catch(NumberFormatException e) {
            idCatSeleccionada = 0;
        }
    }

    // 3. Cargamos las listas desde el DAO
    List<Categoria> listaCategorias = catDAO.listarCategorias();
    List<Producto> listaDestacados = prodDAO.listarProductosDestacados();
    List<Producto> listaProductos = prodDAO.listarProductosPorCategoria(idCatSeleccionada);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo Oficial - PetShop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloCatalogo.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/index.jsp">
                🐾 PetShop
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse gap-2" id="menu">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/index.jsp">Inicio</a>
                    </li>
                </ul>

                <form class="d-flex me-3 search-box">
                    <input class="form-control me-2" type="search" placeholder="Buscar productos...">
                    <button class="btn btn-light" type="submit">🔍</button>
                </form>

                <% if (session.getAttribute("usuarioLogueado") == null) { %>
                    <a class="btn btn-outline-light me-2" href="<%= request.getContextPath() %>/vista/usuario/login.jsp">Login</a>
                    <a class="btn btn-warning" href="<%= request.getContextPath() %>/vista/usuario/registro.jsp">Registro</a>
                <% } else { 
                    Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");
                    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
                %>
                    <div class="nav-item dropdown me-2">
                        <a class="btn btn-outline-light dropdown-toggle active fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1"></i> Bienvenido, <%= nombreUsuario %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <% if (userLogueado != null && "ADMIN".equals(userLogueado.getRol())) { %>
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
                                <li>
                                    <a class="dropdown-item" href="<%= request.getContextPath() %>/vista/cliente/perfil.jsp">
                                        <i class="fa-solid fa-id-card me-2"></i> Mi Perfil
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
                <% } %>
                    
                <a class="btn btn-light position-relative me-2" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                    🛒 Carrito
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        
        <div class="seccion-destacados mb-5 shadow-sm">
            <div class="d-flex align-items-center mb-4">
                <div class="bg-danger text-white p-2 rounded-3 me-3 shadow-sm">
                    <i class="fa-solid fa-fire fa-lg"></i>
                </div>
                <div>
                    <h3 class="mb-0 fw-bold text-dark">¡Últimas Unidades!</h3>
                    <p class="text-muted small mb-0">Los productos más buscados que están por agotarse</p>
                </div>
            </div>
            
            <div class="row g-4">
                <% if(listaDestacados != null && !listaDestacados.isEmpty()) { 
                    for(Producto p : listaDestacados) { %>
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="card-producto-premium">
                            <div class="img-container">
                                <span class="badge bg-danger badge-stock">
                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> Solo <%= p.getStock() %>
                                </span>
                                <img src="<%= request.getContextPath() %>/img/<%= p.getImagen() %>" alt="<%= p.getNombre() %>" onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                            </div>
                            <div class="card-body-premium">
                                <h6 class="product-title text-truncate"><%= p.getNombre() %></h6>
                                <p class="product-desc text-muted small"><%= p.getDescripcion() %></p>
                                <div class="product-footer">
                                    <span class="product-price">S/. <%= String.format("%.2f", p.getPrecio()) %></span>
                                    <button class="btn-cart-round" title="Agregar al carrito" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                <%   } 
                   } else { %>
                    <div class="col-12">
                        <p class="text-muted italic ps-2">No se registran productos con stock crítico actualmente.</p>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-3">
                <div class="card border-0 shadow-sm p-4 panel-sticky-menu">
                    <h5 class="fw-bold text-dark mb-4">
                        <i class="fa-solid fa-paw text-warning me-2"></i>Categorías
                    </h5>
                    <div class="d-flex flex-column gap-1">
                        <a href="catalogo.jsp?idCat=0" class="btn btn-categoria d-flex align-items-center justify-content-between <%= (idCatSeleccionada == 0) ? "active" : "" %>">
                            <span><i class="fa-solid fa-border-all me-2"></i> Todo el catálogo</span>
                            <i class="fa-solid fa-chevron-right small opacity-50"></i>
                        </a>
                        
                        <% if(listaCategorias != null) {
                            for(Categoria c : listaCategorias) { %>
                            <a href="catalogo.jsp?idCat=<%= c.getIdCategoria() %>" 
                               class="btn btn-categoria d-flex align-items-center justify-content-between <%= (idCatSeleccionada == c.getIdCategoria()) ? "active" : "" %>">
                                <span><i class="fa-solid fa-tag me-2 small"></i> <%= c.getNombre() %></span>
                                <i class="fa-solid fa-chevron-right small opacity-50"></i>
                            </a>
                        <%   }
                           } %>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 px-2 gap-2">
                    <h4 class="fw-bold text-dark mb-0">
                        <i class="fa-solid fa-boxes-stacked text-secondary me-2"></i>
                        <%= (idCatSeleccionada == 0) ? "Nuestros Productos" : "Filtrado por Categoría" %>
                    </h4>
                    <span class="badge bg-dark px-3 py-2 rounded-pill fw-semibold"><%= listaProductos.size() %> artículos listados</span>
                </div>

                <div class="row g-4">
                    <% if(listaProductos != null && !listaProductos.isEmpty()) {
                        for(Producto p : listaProductos) { %>
                        <div class="col-6 col-md-4">
                            <div class="card-producto-premium">
                                <div class="img-container">
                                    <img src="<%= request.getContextPath() %>/img/<%= p.getImagen() %>" alt="<%= p.getNombre() %>" onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                                </div>
                                <div class="card-body-premium">
                                    <h6 class="product-title text-truncate"><%= p.getNombre() %></h6>
                                    <p class="product-desc text-muted small mb-3"><%= p.getDescripcion() %></p>
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="product-price">S/. <%= String.format("%.2f", p.getPrecio()) %></span>
                                        <span class="badge text-bg-light border px-2 py-1 font-monospace" style="font-size: 11px;">Stock: <%= p.getStock() %></span>
                                    </div>
                                    
                                    <button class="btn btn-warning w-100 fw-bold py-2 rounded-3 text-dark d-flex align-items-center justify-content-center gap-2"
                                            data-bs-toggle="offcanvas" 
                                            data-bs-target="#carritoSidebar"
                                            style="background-color: #ffc107; border: none; box-shadow: 0 4px 10px rgba(255,193,7,0.15);">
                                        <i class="fa-solid fa-basket-shopping"></i> Agregar al Carrito
                                    </button>
                                </div>
                            </div>
                        </div>
                    <%   }
                       } else { %>
                        <div class="col-12 text-center py-5">
                            <div class="text-muted mb-3">
                                <i class="fa-solid fa-face-frown fa-4x opacity-50"></i>
                            </div>
                            <h5 class="text-muted fw-bold">No hay stock disponible en este momento</h5>
                        </div>
                    <% } %>
                </div>
            </div>

        </div>
    </div>

    <div class="offcanvas offcanvas-end custom-cart-canvas" tabindex="-1" id="carritoSidebar">
        <div class="offcanvas-header border-bottom">
            <h5 class="offcanvas-title fw-bold text-dark">
                <i class="fa-solid fa-cart-shopping text-success me-2"></i>Tu Carrito
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body d-flex flex-column">
            <div class="cart-empty-state text-center my-auto p-4">
                <span class="fs-1 cart-empty-icon mb-3">🛒</span>
                <h6 class="fw-bold text-secondary">¡Tu carrito está vacío!</h6>
                <p class="text-muted small">Explora el catálogo y añade los mejores productos para tus mascotas.</p>
            </div>
            
            <div class="cart-footer p-3 border-top mt-auto bg-white">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="fw-bold text-secondary">Total estimado:</span>
                    <span class="fs-4 fw-extrabold text-success font-monospace">S/. 0.00</span>
                </div>
                <button class="btn btn-success w-100 fw-bold py-2.5 rounded-3 shadow-sm">
                    <i class="fa-solid fa-credit-card me-2"></i> Continuar Compra
                </button>
            </div>
        </div>
    </div>

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
                                        <li><a href="<%= request.getContextPath()%>/vista/cliente/catalogoProductos.jsp" class="footer-link">Productos para Perros</a></li>
                                        <li><a href="<%= request.getContextPath()%>/vista/cliente/catalogoProductos.jsp" class="footer-link">Productos para Gatos</a></li>
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
                
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>