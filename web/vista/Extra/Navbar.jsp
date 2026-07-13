<%-- 
    Document   : Navbar
    Created on : 10 jul. 2026, 6:54:06 p. m.
    Author     : RonaldoYNV & UI Refinement (Cyberpunk Dark Mode)
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloNavbar.css">

<nav class="navbar navbar-expand-lg style-navbar-custom py-3 shadow">
    <div class="container">
        <%-- LOGO --%>
        <a class="navbar-brand fw-bold text-white d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/inicio">
            🐾 <span style="color: #b55fe6;">PetShop</span>
        </a>

        <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>

        <div class="collapse navbar-collapse gap-2" id="menu">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                </li>
                
                <%-- VISTA EXCLUSIVA PARA ADMIN --%>
                <c:if test="${not empty sessionScope.usuarioLogueado && sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link active fw-bold" style="color: #b55fe6 !important;" href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
                            <i class="fa-solid fa-gauge me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/catalogo">
                            <i class="fa-solid fa-boxes-stacked me-1"></i> Ver Productos
                        </a>
                    </li>
                </c:if>
                
                <%-- VISTA PARA VISITANTES O CLIENTES --%>
                <c:if test="${empty sessionScope.usuarioLogueado || sessionScope.usuarioLogueado.rol ne 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
                    </li>
                </c:if>
            </ul>

            <%-- BUSCADOR CON ESTILO PREMIUM DARK --%>
            <form class="d-flex me-3 search-box" action="${pageContext.request.contextPath}/ProductoServlet" method="GET">
                <div class="input-group">
                    <input class="form-control bg-dark-input text-white border-secondary-custom" type="search" name="txtBuscar" placeholder="Buscar productos...">
                    <button class="btn btn-buscar-nav" type="submit">🔍</button>
                </div>
            </form>

            <c:choose>
                <%-- SI NO HAY SESIÓN ACTIVA --%>
                <c:when test="${empty sessionScope.usuarioLogueado}">
                    <a class="btn btn-outline-light me-2 border-secondary-custom text-white-50" href="${pageContext.request.contextPath}/login">Login</a>
                    <a class="btn btn-agregar-dash" href="${pageContext.request.contextPath}/vista/usuario/registro.jsp">Registro</a>
                </c:when>
                
                <%-- SI HAY SESIÓN ACTIVA (Admin o Cliente) --%>
                <c:otherwise>
                    <div class="nav-item dropdown me-2">
                        <a class="btn btn-perfil-nav dropdown-toggle text-white fw-bold d-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1" style="color: #b55fe6;"></i> Bienvenido, ${sessionScope.nombreUsuario}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-cyber-menu dropdown-menu-end shadow mt-2">
                            <c:choose>
                                <%-- DROPDOWN ROL ADMIN --%>
                                <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-user-gear me-2 text-muted"></i> Mi Perfil (Admin)
                                        </a>
                                    </li>
                                </c:when>
                                <%-- DROPDOWN ROL CLIENTE --%>
                                <c:otherwise>
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-id-card me-2 text-muted"></i> Mi Perfil
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            
                            <li><hr class="dropdown-divider border-secondary-custom"></li>
                            <%-- LOGOUT GLOBAL --%>
                            <li>
                                <a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
                
            <%-- CARRITO EXCLUSIVO PARA CLIENTES O VISITANTES --%>
            <c:if test="${empty sessionScope.usuarioLogueado || sessionScope.usuarioLogueado.rol ne 'ADMIN'}">
                <a class="btn btn-buscar-nav position-relative me-2 d-flex align-items-center gap-1 text-white" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                    🛒 Carrito
                    <span id="carrito-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger animate-pulse">0</span>
                </a>
            </c:if>
        </div>
    </div>
</nav>