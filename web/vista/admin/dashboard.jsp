<%-- 
    Document   : dashboard.jsp
    Created on : 20 may 2026, 18:01:22
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.dto.ProductoDTO"%>
<%@page import="servicio.ProductoServicio"%>
<%@page import="modelo.entidad.Categoria"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    String nombreAdmin = (session.getAttribute("nombreUsuario") != null) ? (String) session.getAttribute("nombreUsuario") : "ADMINISTRADOR";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - PetShop</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloDash.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
</head>
<body>

<jsp:include page="/vista/Extra/Navbar.jsp" />
<jsp:include page="/vista/Extra/carrito-sidebar.jsp" />

<div class="container mt-4 mb-5">

    <h2 class="text-center mb-4 titulo-dashboard">Sistema de Gestión de Productos</h2>

    <div class="card card-dash p-3 mb-4">
        <form method="GET" action="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
            <div class="row g-2">
                <div class="col-md-10">
                    <input type="text" name="buscar" class="form-control" placeholder="Buscar producto por nombre...">
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-buscar">Buscar</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card card-dash p-4 mb-4">
        <h4 class="mb-3 card-title-custom"><%= (productoEditar != null) ? "🛠️ Modificar Producto Seleccionado" : "➕ Registrar Nuevo Producto" %></h4>
        
        <form action="${pageContext.request.contextPath}/ProductoServlet" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="idProducto" value="<%= (productoEditar != null) ? productoEditar.getIdProducto() : "" %>">

            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Nombre Comercial</label>
                <input type="text" name="nombre" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getNombre() : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Descripción Detallada</label>
                <textarea name="descripcion" class="form-control" rows="3" required><%= (productoEditar != null) ? productoEditar.getDescripcion() : "" %></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold text-muted">Precio de Venta (S/)</label>
                    <input type="number" step="0.01" name="precio" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getPrecio() : "" %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold text-muted">Unidades en Stock</label>
                    <input type="number" name="stock" class="form-control" value="<%= (productoEditar != null) ? productoEditar.getStock() : "" %>" required>
                </div>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Categoría</label>
                <select name="idCategoria" class="form-control" required>
                    <option value="">-- Seleccione categoría --</option>
                    <% for (Categoria c : categorias) { %>
                        <option value="<%= c.getIdCategoria() %>" <%= (productoEditar != null && productoEditar.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>>
                            <%= c.getNombre() %>
                        </option>
                    <% } %>
                </select>
            </div>
        
            <div class="mb-3">
                <label class="form-label fw-bold text-muted">Imagen</label>
                <input type="file" name="imagen" class="form-control" accept="image/*">
                <% if(productoEditar != null && productoEditar.getImagen()!=null){ %>
                    <div class="mt-2">
                        <img src="<%=request.getContextPath()%>/imagen/<%=productoEditar.getImagen()%>" class="img-preview-dash" alt="Vista previa">
                    </div>
                <% } %>
            </div>

            <div class="d-flex gap-2 mt-2">
                <button type="submit" name="accion" value="agregar" class="btn btn-agregar-dash px-4" <%= (productoEditar != null) ? "disabled" : "" %>>
                    Agregar Producto
                </button>
                <button type="submit" name="accion" value="modificar" class="btn btn-modificar-dash px-4" <%= (productoEditar == null) ? "disabled" : "" %>>
                    Guardar Cambios
                </button>
                <% if (productoEditar != null) { %>
                    <a href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp" class="btn btn-cancelar-dash px-4">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>

    <% String mensajeError = (String) request.getAttribute("mensajeError"); %>
    <% if (mensajeError != null) { %>
        <div class="alert alert-danger-custom shadow-sm"><%= mensajeError %></div>
    <% } %>

    <% String mensaje = request.getParameter("mensaje"); %>
    <% if (mensaje != null) { %>
        <div class="alert alert-success-custom shadow-sm">🎉 <%= mensaje %></div>
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
                        <td class="td-nombre text-start"><%= p.getNombre() %></td>
                        <td class="td-descripcion text-start"><%= p.getDescripcion() %></td>
                        <td class="td-precio">S/ <%= p.getPrecio() %></td>
                        <td>
                            <span class="badge badge-stock <%= (p.getStock() > 5) ? "stock-ok" : "stock-low" %>">
                                <%= p.getStock() %> unds
                            </span>
                        </td>
                        <td class="td-categoria"><%= p.getNombreCategoria() %></td>
                        <td>
                            <img src="<%=request.getContextPath()%>/imagen/<%=p.getImagen()%>" class="img-tabla-dash" alt="Producto">
                        </td>
                        <td>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-tabla-editar">Modificar</a>
                                <a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>" class="btn btn-tabla-eliminar" onclick="return confirm('¿Desea eliminar este producto?')">Eliminar</a>
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