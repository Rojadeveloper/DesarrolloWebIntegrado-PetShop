<%-- 
    Document   : dashboard.jsp
    Created on : 20 may 2026, 18:01:22
    Author     : User & Refactored by: RonaldoYN
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.dto.ProductoDTO"%>
<%@page import="servicio.ProductoServicio"%>
<%@page import="modelo.entidad.Categoria"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // 🛡️ LÓGICA DE NEGOCIO PROCESADA EN EL SERVIDOR Y PREPARADA PARA JSTL
    try {
        ProductoServicio servicio = new ProductoServicio();
        String buscar = request.getParameter("buscar");
        List<ProductoDTO> lista;
        
        if (buscar != null && !buscar.trim().isEmpty()) {
            lista = servicio.buscar(buscar);
        } else {
            lista = servicio.listar();
        }

        // Seteamos las variables dentro del Request Scope para habilitar la lectura con JSTL/EL
        request.setAttribute("listaProductos", lista);
        request.setAttribute("listaCategorias", servicio.listarCategorias());
        
        // El producto en edición y el nombre de sesión ya vienen inyectados o gestionados
    } catch(Exception e) {
        System.out.println("Error al inicializar contextos en Dashboard: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - PetShop</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloDash.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Responsive.css">
</head>
<body>

<%-- INCLUSIÓN DE COMPONENTES MODULARES DESDE LA RAÍZ --%>
<jsp:include page="/vista/Extra/Navbar.jsp" />
<jsp:include page="/vista/Extra/carrito-sidebar.jsp" />

<div class="container-fluid px-4 mt-4 mb-5"> <%-- Usamos container-fluid para aprovechar más la pantalla --%>

    <h2 class="text-center mb-4 titulo-dashboard">Sistema de Gestión de Productos</h2>

    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-success-custom shadow d-flex align-middle gap-2 mb-4 animate-pulse">
            <span>✨</span> 
            <div><strong>Operación Exitosa:</strong> <c:out value="${param.mensaje}" /></div>
        </div>
    </c:if>

    <c:if test="${not empty requestScope.mensajeError}">
        <div class="alert alert-danger-custom shadow d-flex align-middle gap-2 mb-4">
            <span>⚠️</span> 
            <div><strong>Error de Sistema:</strong> ${requestScope.mensajeError}</div>
        </div>
    </c:if>

    <div class="row g-4">
        
        <div class="col-xl-4 col-lg-5">
            <div class="card card-dash p-4 sticky-top" style="top: 90px; z-index: 10;"> <%-- sticky-top para que no se mueva al hacer scroll --%>
                <h4 class="mb-3 card-title-custom">
                    <c:choose>
                        <c:when test="${not empty requestScope.productoEditar}">🛠️ Modificar Producto</c:when>
                        <c:otherwise>➕ Registrar Producto</c:otherwise>
                    </c:choose>
                </h4>
                
                <form action="${pageContext.request.contextPath}/ProductoServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="idProducto" value="${requestScope.productoEditar.idProducto}">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Nombre Comercial</label>
                        <input type="text" name="nombre" class="form-control" value="${requestScope.productoEditar.nombre}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Descripción Detallada</label>
                        <textarea name="descripcion" class="form-control" rows="3" required>${requestScope.productoEditar.descripcion}</textarea>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3">
                            <label class="form-label fw-bold">Precio (S/)</label>
                            <input type="number" step="0.01" name="precio" class="form-control" value="${requestScope.productoEditar.precio}" required>
                        </div>
                        <div class="col-6 mb-3">
                            <label class="form-label fw-bold">Stock</label>
                            <input type="number" name="stock" class="form-control" value="${requestScope.productoEditar.stock}" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Categoría</label>
                        <select name="idCategoria" class="form-control" required>
                            <option value="">-- Seleccione --</option>
                            <c:forEach var="c" items="${requestScope.listaCategorias}">
                                <option value="${c.idCategoria}" ${requestScope.productoEditar.idCategoria == c.idCategoria ? 'selected' : ''}>
                                    ${c.nombre}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                
                    <div class="mb-3">
                        <label class="form-label fw-bold">Imagen del Producto</label>
                        <input type="file" name="imagen" class="form-control" accept="image/*">
                        <c:if test="${not empty requestScope.productoEditar and not empty requestScope.productoEditar.imagen}">
                            <div class="mt-2 text-center">
                                <img src="${pageContext.request.contextPath}/imagen/${requestScope.productoEditar.imagen}" class="img-preview-dash" alt="Vista previa" style="max-height: 100px; border-radius: 8px;">
                            </div>
                        </c:if>
                    </div>

                    <div class="d-flex gap-2 mt-3">
                        <button type="submit" name="accion" value="agregar" class="btn btn-agregar-dash w-100" ${not empty requestScope.productoEditar ? 'disabled' : ''}>
                            Agregar
                        </button>
                        <button type="submit" name="accion" value="modificar" class="btn btn-modificar-dash w-100" ${empty requestScope.productoEditar ? 'disabled' : ''}>
                            Guardar
                        </button>
                    </div>
                    <c:if test="${not empty requestScope.productoEditar}">
                        <div class="mt-2">
                            <a href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp" class="btn btn-cancelar-dash w-100">Cancelar Edición</a>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>

        <div class="col-xl-8 col-lg-7">
            
            <div class="card card-dash p-3 mb-4">
                <form method="GET" action="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
                    <div class="row g-2">
                        <div class="col-md-9">
                            <input type="text" name="buscar" value="${param.buscar}" class="form-control" placeholder="Buscar producto por nombre...">
                        </div>
                        <div class="col-md-3 d-grid">
                            <button type="submit" class="btn btn-buscar">Buscar Producto</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="card card-dash p-4">
                <h4 class="mb-3 card-title-custom">Inventario General</h4>
                
                <%-- Contenedor con scroll interno para la tabla --%>
                <div class="table-responsive table-responsive-custom-scroll" style="max-height: 550px; overflow-y: auto;">
                    <table class="table table-hover text-center align-middle m-0">
                        <thead class="thead-custom" style="position: sticky; top: 0; z-index: 5;">
                            <tr>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría</th>
                                <th>Imagen</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${requestScope.listaProductos}" varStatus="status">
                                <tr>
                                    <td class="text-start">
                                        <c:if test="${status.first && empty param.buscar && empty requestScope.productoEditar}">
                                            <span class="badge bg-purple-neon animate-pulse me-1">NUEVO</span>
                                        </c:if>
                                        <span class="td-nombre">${p.nombre}</span>
                                    </td>
                                    <td class="td-precio">S/ ${p.precio}</td>
                                    <td>
                                        <span class="badge badge-stock ${p.stock > 5 ? 'stock-ok' : 'stock-low'}">
                                            ${p.stock} unds
                                        </span>
                                    </td>
                                    <td class="td-categoria">${p.nombreCategoria}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/imagen/${p.imagen}" class="img-tabla-dash" alt="Producto">
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=${p.idProducto}" class="btn btn-tabla-editar btn-sm">Editar</a>
                                            <button type="button" 
                                                    class="btn btn-tabla-eliminar btn-sm" 
                                                    onclick="abrirModalEliminar('${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=${p.idProducto}')">
                                                Eliminar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
                <div class="modal fade" id="modalConfirmarEliminar" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-cyber p-3">
<div class="modal-body text-center">
    <h4 class="text-white mb-3 fw-bold">🚨 ¿Confirmar Eliminación?</h4>
    
    <p class="text-white-50 small">Esta acción quitará de forma permanente el producto de tu inventario general.</p>
    
    <div class="d-flex justify-content-center gap-3 mt-4">
        <button type="button" class="btn btn-cancelar-dash px-4" data-bs-dismiss="modal">Cancelar</button>
        <a id="btnConfirmarEliminarUrl" href="#" class="btn btn-tabla-eliminar px-4 d-flex align-items-center justify-content-center">Eliminar</a>
    </div>
</div>
    </div>
  </div>
</div>

<script>
  function abrirModalEliminar(url) {
      document.getElementById('btnConfirmarEliminarUrl').setAttribute('href', url);
      var myModal = new bootstrap.Modal(document.getElementById('modalConfirmarEliminar'));
      myModal.show();
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>