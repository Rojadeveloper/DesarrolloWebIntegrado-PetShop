<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.entidad.Producto" %> <%-- 👈 Usamos tu entidad Producto real --%>
<%@ page import="modelo.entidad.Categoria" %> <%-- 👈 Usamos tu entidad Categoria real --%>
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

    // 3. Cargamos las listas desde los métodos que acabamos de corregir en el DAO
    List<Categoria> listaCategorias = catDAO.listarCategorias();
    List<Producto> listaDestacados = prodDAO.listarProductosDestacados();
    List<Producto> listaProductos = prodDAO.listarProductosPorCategoria(idCatSeleccionada);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo - PetShop Premium</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloGlobal.css">

    <style>
        /* --- ESTILOS EXCLUSIVOS PARA DISEÑO FLOTANTE --- */
        
        /* Botones de categorías laterales */
        .btn-categoria {
            text-align: left;
            border-radius: 12px;
            margin-bottom: 8px;
            padding: 12px 16px;
            border: 1px solid transparent;
            background-color: #f8f9fa;
            color: #495057;
            transition: all 0.25s ease;
            font-weight: 500;
        }
        .btn-categoria:hover {
            background-color: #e9ecef;
            transform: translateX(6px); /* Sutil desplazamiento a la derecha */
            color: #212529;
        }
        .btn-categoria.active {
            background-color: #198754; /* Cambia este color al tono principal de tu PetShop si deseas */
            color: white;
            border-color: #198754;
            box-shadow: 0 4px 12px rgba(25, 135, 84, 0.25);
        }
        
        /* Tarjetas flotantes estilo "GOD" */
        .card-producto {
            border-radius: 18px;
            overflow: hidden;
            border: none;
            box-shadow: 0 6px 18px rgba(0,0,0,0.04);
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.3s ease;
            background: white;
        }
        .card-producto:hover {
            transform: translateY(-10px); /* Efecto flotante real de elevación */
            box-shadow: 0 16px 32px rgba(0,0,0,0.12);
        }
        
        /* Contenedor de la foto del producto */
        .img-container {
            height: 210px;
            background-color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            padding: 15px;
            border-bottom: 1px solid #f1f3f5;
        }
        .img-container img {
            max-height: 90%;
            max-width: 90%;
            object-fit: contain;
            transition: transform 0.4s ease;
        }
        .card-producto:hover .img-container img {
            transform: scale(1.06); /* Zoom fluido de la foto */
        }
        
        /* Etiqueta flotante de Stock Crítico */
        .badge-stock {
            position: absolute;
            top: 14px;
            left: 14px;
            font-size: 0.75rem;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
            z-index: 2;
        }
        
        /* Panel superior de destacados */
        .seccion-destacados {
            background: linear-gradient(135deg, rgba(25, 135, 84, 0.06) 0%, rgba(255, 193, 7, 0.03) 100%);
            border-radius: 24px;
            padding: 30px;
            border: 1px dashed rgba(25, 135, 84, 0.15);
        }
    </style>
</head>
<body class="bg-light">

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
                        <div class="card card-producto h-100">
                            <div class="img-container">
                                <span class="badge bg-danger badge-stock">
                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> Solo Quedan <%= p.getStock() %>
                                </span>
                                <img src="<%= request.getContextPath() %>/img/<%= p.getImagen() %>" alt="<%= p.getNombre() %>" onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                            </div>
                            <div class="card-body d-flex flex-column p-3">
                                <h6 class="fw-bold text-dark mb-1 text-truncate"><%= p.getNombre() %></h6>
                                <p class="text-muted small text-truncate mb-3"><%= p.getDescripcion() %></p>
                                <div class="mt-auto d-flex justify-content-between align-items-center">
                                    <span class="fs-5 fw-bold text-success">S/. <%= String.format("%.2f", p.getPrecio()) %></span>
                                    <button class="btn btn-dark rounded-circle p-2 d-flex align-items-center justify-content-center" style="width: 38px; height: 38px;" title="Agregar al carrito">
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
                <div class="card border-0 shadow-sm p-4 sticky-top" style="top: 25px; border-radius: 20px;">
                    <h5 class="fw-bold text-dark mb-4">
                        <i class="fa-solid fa-paw text-warning me-2"></i>Categorías
                    </h5>
                    <div class="d-flex flex-column">
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
                <div class="d-flex justify-content-between align-items-center mb-4 px-2">
                    <h4 class="fw-bold text-dark mb-0">
                        <i class="fa-solid fa-boxes-stacked text-secondary me-2"></i>
                        <%= (idCatSeleccionada == 0) ? "Nuestros Productos" : "Filtrado por Categoría" %>
                    </h4>
                    <span class="badge bg-dark px-3 py-2 rounded-pill fw-semibold"><%= listaProductos.size() %> artículos listados</span>
                </div>

                <div class="row g-4">
                    <% if(listaProductos != null && !listaProductos.isEmpty()) {
                        for(Producto p : listaProductos) { %>
                        <div class="col-sm-6 col-md-4">
                            <div class="card card-producto h-100">
                                <div class="img-container">
                                    <img src="<%= request.getContextPath() %>/img/<%= p.getImagen() %>" alt="<%= p.getNombre() %>" onerror="this.src='https://placehold.co/250x250?text=PetShop+Product';">
                                </div>
                                <div class="card-body d-flex flex-column p-3">
                                    <h6 class="fw-bold text-dark mb-1"><%= p.getNombre() %></h6>
                                    <p class="text-muted small mb-3" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 38px; line-height: 19px;">
                                        <%= p.getDescripcion() %>
                                    </p>
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="fs-4 fw-extrabold text-dark font-monospace">S/. <%= String.format("%.2f", p.getPrecio()) %></span>
                                            <span class="badge bg-light text-muted border px-2 py-1">Stock: <%= p.getStock() %></span>
                                        </div>
                                        <button class="btn btn-warning w-100 fw-bold text-dark rounded-pill shadow-sm py-2 d-flex align-items-center justify-content-center">
                                            <i class="fa-solid fa-basket-shopping me-2"></i> Agregar al Carrito
                                        </button>
                                    </div>
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
                            <p class="text-muted small">Prueba seleccionando otra categoría en el menú lateral izquierdo.</p>
                        </div>
                    <% } %>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>