<%-- 
    Document   : dashboard.jsp
    Created on : 20 may 2026, 18:01:22
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.dto.ProductoDTO"%>
<%@page import="servicio.ProductoServicio"%>
<%@page import="modelo.entidad.Categoria"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ProductoServicio servicio = new ProductoServicio();
    String buscar = request.getParameter("buscar");
    List<ProductoDTO> lista;
    List<Categoria> categorias = servicio.listarCategorias();

    if (buscar != null && !buscar.trim().isEmpty()) {
        lista = servicio.buscar(buscar);
    } else {
        lista = servicio.listar();
    }

    ProductoDTO productoEditar = (ProductoDTO) request.getAttribute("productoEditar");

    // 🌟 AGREGA ESTA LÍNEA PARA OBTENER EL NOMBRE DESDE LA SESIÓN
    String nombreAdmin = (session.getAttribute("nombreUsuario") != null) ? (String) session.getAttribute("nombreUsuario") : "ADMINISTRADOR";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - PetShop</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloDash.css">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
</head>
<body>

<nav class="navbar navbar-expand-lg custom-navbar shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center gap-2" href="#">
            <span>🐾 PetShop Admin</span>
        </a>
        
        <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-2">
                <li class="nav-item">
                    <a class="nav-link text-warning fw-bold" href="<%= request.getContextPath() %>/index.jsp">
                        🏠 Volver al Inicio (Tienda)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link opacity-75" href="#">📦 Mantenimiento Productos</a>
                </li>
            </ul>
            
<div class="d-flex align-items-center gap-3">
    <span class="small">Admin: <strong class="text-white"><%= nombreAdmin.toUpperCase() %></strong></span>
    
    <a href="<%= request.getContextPath() %>/logout" class="btn btn-sm btn-danger px-3 fw-bold" style="border-radius: 20px;">Cerrar Sesión</a>
</div>
        </div>
    </div>
</nav>

<div class="container mt-4 mb-5">

    <h2 class="text-center mb-4 titulo-dashboard">Sistema de Gestión de Productos</h2>

    <div class="card card-dash p-3 mb-4">
        <form method="GET" action="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
            <div class="row g-2">
                <div class="col-md-10">
                    <input type="text" name="buscar" class="form-control" style="border-radius: 8px;" placeholder="Buscar producto por nombre...">
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-buscar">Buscar</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card card-dash p-4 mb-4">
        <h4 class="mb-3 card-title-custom"><%= (productoEditar != null) ? "🛠️ Modificar Producto Seleccionado" : "➕ Registrar Nuevo Producto" %></h4>
        <form action="${pageContext.request.contextPath}/ProductoServlet"
            method="POST"
            enctype="multipart/form-data">

            <input type="hidden" name="idProducto" value="<%= (productoEditar != null) ? productoEditar.getIdProducto() : "" %>">

            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Nombre Comercial</label>
                <input type="text" name="nombre" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getNombre() : "" %>" required style="border-radius: 8px;">
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Descripción Detallada</label>
                <textarea name="descripcion" class="form-control" rows="3" required style="border-radius: 8px;"><%= (productoEditar != null) ? productoEditar.getDescripcion() : "" %></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold text-muted">Precio de Venta (S/)</label>
                    <input type="number" step="0.01" name="precio" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getPrecio() : "" %>" required style="border-radius: 8px;">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold text-muted">Unidades en Stock</label>
                    <input type="number" name="stock" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getStock() : "" %>" required style="border-radius: 8px;">
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Categoría</label>
                <select name="idCategoria" class="form-control" required style="border-radius: 8px;">
                    <option value="">-- Seleccione categoría --</option>
                    <% for (Categoria c : categorias) { %>
                        <option value="<%= c.getIdCategoria() %>"
                            <%= (productoEditar != null && productoEditar.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>>
                            <%= c.getNombre() %>
                        </option>
                    <% } %>
                </select>
            </div>
        
            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Imagen</label>

                <input type="file"
                       name="imagen"
                       class="form-control"
                       accept="image/*">
                <% if(productoEditar != null && productoEditar.getImagen()!=null){ %>
                    <div class="mt-2">
                        <img src="<%=request.getContextPath()%>/imagen/<%=productoEditar.getImagen()%>"
                             width="120"
                             class="img-thumbnail">
                    </div>
                <% } %>
            </div>

            <div class="d-flex gap-2 mt-2">
                <button type="submit" name="accion" value="agregar" class="btn btn-agregar-dash px-4" <%= (productoEditar != null) ? "disabled" : "" %>>
                    Agregar Producto
                </button>
                <button type="submit" name="accion" value="modificar" class="btn btn-warning px-4 fw-bold text-white" style="border-radius: 8px;" <%= (productoEditar == null) ? "disabled" : "" %>>
                    Guardar Cambios
                </button>
                <% if (productoEditar != null) { %>
                    <a href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp" class="btn btn-secondary px-4" style="border-radius: 8px;">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>

    <% String mensajeError = (String) request.getAttribute("mensajeError"); %>
    <% if (mensajeError != null) { %>
        <div class="alert alert-danger shadow-sm" style="border-radius: 10px;"><%= mensajeError %></div>
    <% } %>

    <% String mensaje = request.getParameter("mensaje"); %>
    <% if (mensaje != null) { %>
        <div class="alert alert-success shadow-sm" style="border-radius: 10px;">🎉 <%= mensaje %></div>
    <% } %>                 
                            
    <div class="card card-dash p-4">
        <h4 class="mb-3 card-title-custom">Inventario General</h4>
        <div class="table-responsive table-responsive-custom">
            <table class="table table-hover text-center align-middle m-0">
                <thead class="thead-custom">
                    <tr>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Categoría</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <% for (ProductoDTO p : lista) { %>
                    <tr>
                        <td class="fw-bold text-start text-dark"><%= p.getNombre() %></td>
                        <td class="text-start text-muted small"><%= p.getDescripcion() %></td>
                        <td class="text-success fw-bold" style="font-size: 16px;">S/ <%= p.getPrecio() %></td>
                        <td>
                            <span class="badge badge-stock <%= (p.getStock() > 5) ? "bg-success-subtle text-success" : "bg-danger-subtle text-danger" %>">
                                <%= p.getStock() %> unds
                            </span>
                        </td>
                        <td><%= p.getNombreCategoria() %></td>
                        <td>
                            <img src="<%=request.getContextPath()%>/imagen/<%=p.getImagen()%>"
                            width="80"
                            class="img-thumbnail">
                        </td>
                        <td>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-warning btn-sm fw-bold text-white" style="border-radius: 6px; width: 85px;">Modificar</a>
                                <a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>" class="btn btn-danger btn-sm fw-bold" style="border-radius: 6px; width: 85px;" onclick="return confirm('¿Desea eliminar este producto?')">Eliminar</a>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>