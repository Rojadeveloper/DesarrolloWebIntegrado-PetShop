<%-- 
    Document   : dashboard.jsp
    Created on : 20 may 2026, 18:01:22
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.dto.ProductoDTO"%>
<%@page import="servicio.ProductoServicio"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ProductoServicio servicio = new ProductoServicio();

    String buscar = request.getParameter("buscar");

    List<ProductoDTO> lista;

    if (buscar != null && !buscar.trim().isEmpty()) {
        lista = servicio.buscar(buscar);
    } else {
        lista = servicio.listar();
    }

    ProductoDTO productoEditar = (ProductoDTO) request.getAttribute("productoEditar");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Gestión de Productos</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>

        body{
            background-color: #f4f6f9;
        }

        .contenedor{
            margin-top: 30px;
        }

        .card{
            border-radius: 12px;
        }

        .btn-accion{
            width: 90px;
        }

    </style>

</head>

<body>

<div class="container contenedor">

    <h2 class="text-center mb-4">Sistema de Productos</h2>

    <!-- BUSCADOR -->
    <div class="card p-3 mb-4 shadow-sm">

        <form method="GET"
              action="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">

            <div class="row">

                <div class="col-md-10">

                    <input type="text"
                           name="buscar"
                           class="form-control"
                           placeholder="Buscar producto por nombre...">

                </div>

                <div class="col-md-2 d-grid">

                    <button type="submit"
                            class="btn btn-primary">
                        Buscar
                    </button>

                </div>

            </div>

        </form>

    </div>

    <!-- FORMULARIO -->
    <div class="card p-4 mb-4 shadow-sm">

        <h4 class="mb-3">Agregar / Modificar Producto</h4>

        <form action="${pageContext.request.contextPath}/ProductoServlet" method="POST">

            <input type="hidden"
                   name="idProducto"
                   value="<%= (productoEditar != null) ? productoEditar.getIdProducto() : "" %>">

            <div class="mb-3">

                <label class="form-label">Nombre</label>

                <input type="text"
                       name="nombre"
                       class="form-control"
                       value="<%= (productoEditar != null) ? productoEditar.getNombre() : "" %>"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">Descripción</label>

                <textarea name="descripcion"
                          class="form-control"
                          rows="3"
                          required><%= (productoEditar != null) ? productoEditar.getDescripcion() : "" %></textarea>

            </div>

            <div class="row">

                <div class="col-md-6 mb-3">

                    <label class="form-label">Precio</label>

                    <input type="number"
                           step="0.01"
                           name="precio"
                           class="form-control"
                           value="<%= (productoEditar != null) ? productoEditar.getPrecio() : "" %>"
                           required>

                </div>

                <div class="col-md-6 mb-3">

                    <label class="form-label">Stock</label>

                    <input type="number"
                           name="stock"
                           class="form-control"
                           value="<%= (productoEditar != null) ? productoEditar.getStock() : "" %>"
                           required>

                </div>

            </div>

            <div class="d-flex gap-2">

                <button type="submit"
                        name="accion"
                        value="agregar"
                        class="btn btn-success">
                    Agregar
                </button>

                <button type="submit"
                        name="accion"
                        value="modificar"
                        class="btn btn-warning">
                    Modificar
                </button>

            </div>

        </form>

    </div>

        <%
    String mensajeError = (String) request.getAttribute("mensajeError");
%>

<% if (mensajeError != null) { %>

    <div class="alert alert-danger">
        <%= mensajeError %>
    </div>

<% } %>

<!-- MENSAJE EXITOSO -->
<%
    String mensaje = request.getParameter("mensaje");
%>

<% if (mensaje != null) { %>

    <div class="alert alert-success">
        <%= mensaje %>
    </div>

<% } %>                 
                           
                           
    <!-- TABLA -->
    <div class="card p-4 shadow-sm">

        <h4 class="mb-3">Lista de Productos</h4>

        <table class="table table-bordered table-hover text-center align-middle">

            <thead class="table-dark">

                <tr>

                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Acciones</th>

                </tr>

            </thead>

            <tbody>

            <%
                for (ProductoDTO p : lista) {
            %>

                <tr>

                    <td><%= p.getNombre() %></td>

                    <td><%= p.getDescripcion() %></td>

                    <td>S/ <%= p.getPrecio() %></td>

                    <td><%= p.getStock() %></td>

                    <td>

                        <a href="${pageContext.request.contextPath}/ProductoServlet?accion=editar&id=<%= p.getIdProducto() %>"
   class="btn btn-warning btn-sm btn-accion">
    Modificar
</a>

<a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>"
   class="btn btn-danger btn-sm btn-accion"
   onclick="return confirm('¿Desea eliminar este producto?')">
    Eliminar
</a>

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>




