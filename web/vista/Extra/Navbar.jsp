<%-- 
    Document   : Navbar
    Created on : 10 jul. 2026, 6:54:06 p. m.
    Author     : RonaldoYNV & UI Refinement (Cyberpunk Dark Mode)
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloNavbar.css">

<%-- 
  Detectamos dinámicamente si la URI de la página actual contiene "perfil.jsp"
  para ocultar los elementos correspondientes.
--%>
<c:set var="esPaginaPerfil" value="${fn:containsIgnoreCase(pageContext.request.requestURI, 'perfil.jsp')}" scope="request" />

<nav class="navbar navbar-expand-lg style-navbar-custom py-3 shadow">
    <div class="container">
        <%-- LOGO --%>
        <a class="navbar-brand fw-bold text-white d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/inicio">
            🐾 <span style="color: #b55fe6; font-size: 1.4rem;">PetShop</span>
        </a>

        <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>

        <div class="collapse navbar-collapse gap-2" id="menu">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                </li>
                
                <%-- VISTA EXCLUSIVA PARA ADMIN --%>
                <c:if test="${not empty sessionScope.usuarioLogueado && sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom fw-bold" style="color: #b55fe6 !important;" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa-solid fa-gauge me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/catalogo">
                            <i class="fa-solid fa-boxes-stacked me-1"></i> Ver Productos
                        </a>
                    </li>
                </c:if>
                
                <%-- VISTA PARA VISITANTES O CLIENTES --%>
                <c:if test="${empty sessionScope.usuarioLogueado || sessionScope.usuarioLogueado.rol ne 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
                    </li>
                </c:if>
            </ul>

            <%-- 🔍 EL BUSCADOR SOLO SE MUESTRA SI NO ESTAMOS EN PERFIL --%>
            <c:if test="${!esPaginaPerfil}">
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/ProductoServlet" method="GET">
                    <div class="search-box-custom">
                        <input class="input-buscar" type="search" name="txtBuscar" placeholder="Buscar productos..." required>
                        <button class="btn-buscar-lupa" type="submit">🔍</button>
                    </div>
                </form>
            </c:if>

            <c:choose>
                <%-- SI NO HAY SESIÓN ACTIVA --%>
                <c:when test="${empty sessionScope.usuarioLogueado}">
                    <a class="btn btn-login-custom me-2" href="${pageContext.request.contextPath}/login">Login</a>
                    <a class="btn btn-registro-custom" href="${pageContext.request.contextPath}/registro">Registro</a>
                </c:when>
                
                <%-- SI HAY SESIÓN ACTIVA (Admin o Cliente) --%>
                <c:otherwise>
                    <div class="nav-item dropdown me-2">
                        <a class="btn btn-perfil-nav dropdown-toggle text-white fw-bold d-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1" style="color: #b55fe6;"></i> Bienvenido, ${sessionScope.nombreUsuario}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-cyber-menu dropdown-menu-end shadow mt-2">
                            <c:choose>
                                <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-user-gear me-2 text-muted"></i> Mi Perfil (Admin)
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-id-card me-2 text-muted"></i> Mi Perfil
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            
                            <li><hr class="dropdown-divider border-secondary-custom"></li>
                            <li>
                                <a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
                
            <%-- 🛒 EL CARRITO SE MUESTRA A TODOS (ADMIN Y CLIENTES) PERO SE OCULTA EN LA VISTA DE PERFIL --%>
            <c:if test="${!esPaginaPerfil}">
                <a class="btn btn-carrito-custom position-relative me-2 d-flex align-items-center gap-1" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                    🛒 Carrito
                    <span id="carrito-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill badge-custom">0</span>
                </a>
            </c:if>
        </div>
    </div>
</nav>