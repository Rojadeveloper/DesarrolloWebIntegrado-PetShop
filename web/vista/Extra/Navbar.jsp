<%-- 
    Document   : Navbar
    Created on : 10 jul. 2026, 6:54:06 p. m.
    Author     : RonaldoYNV
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <%-- LOGO --%>
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/inicio">
            🐾 PetShop
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse gap-2" id="menu">
    <ul class="navbar-nav me-auto">
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/inicio">Inicio</a>
        </li>
        
        <c:if test="${not empty sessionScope.usuarioLogueado && sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
                    <i class="fa-solid fa-gauge me-1"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/vista/cliente/catalogoProductos.jsp">
                    <i class="fa-solid fa-boxes-stacked me-1"></i> Ver Productos
                </a>
            </li>
        </c:if>
        
        <c:if test="${empty sessionScope.usuarioLogueado || sessionScope.usuarioLogueado.rol ne 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/vista/cliente/catalogoProductos.jsp">Catálogo</a>
            </li>
        </c:if>
    </ul>

    <form class="d-flex me-3 search-box" action="${pageContext.request.contextPath}/ProductoServlet" method="GET">
        <input class="form-control me-2" type="search" name="txtBuscar" placeholder="Buscar productos...">
        <button class="btn btn-light" type="submit">🔍</button>
    </form>

    <c:choose>
        <%-- SI NO HAY SESIÓN --%>
        <c:when test="${empty sessionScope.usuarioLogueado}">
            <a class="btn btn-outline-light me-2" href="${pageContext.request.contextPath}/vista/usuario/login.jsp">Login</a>
            <a class="btn btn-warning" href="${pageContext.request.contextPath}/vista/usuario/registro.jsp">Registro</a>
        </c:when>
        
        <%-- SI HAY SESIÓN ACTIVA (Admin o Cliente) --%>
        <c:otherwise>
            <div class="nav-item dropdown me-2">
                <a class="btn btn-outline-light dropdown-toggle active fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fa-solid fa-user me-1"></i> Bienvenido, ${sessionScope.nombreUsuario}
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <c:choose>
                        <%-- OPCIONES EXCLUSIVAS DEL DROPDOWN PARA ADMIN --%>
                        <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                    <i class="fa-solid fa-user-gear me-2"></i> Mi Perfil (Admin)
                                </a>
                            </li>
                        </c:when>
                        <%-- OPCIONES DEL DROPDOWN PARA CLIENTE --%>
                        <c:otherwise>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                    <i class="fa-solid fa-id-card me-2"></i> Mi Perfil
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    
                    <li><hr class="dropdown-divider"></li>
                    <%-- BOTÓN GLOBAL DE CERRAR SESIÓN --%>
                    <li>
                        <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                            <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </c:otherwise>
    </c:choose>
        
    <c:if test="${empty sessionScope.usuarioLogueado || sessionScope.usuarioLogueado.rol ne 'ADMIN'}">
        <a class="btn btn-light position-relative me-2" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
            🛒 Carrito
            <span id="carrito-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
        </a>
    </c:if>
</div>
    </div>
</nav>
