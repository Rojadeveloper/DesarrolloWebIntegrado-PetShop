<%-- 
    Document   : Navbar
    Created on : 10 jul. 2026, 6:54:06 p. m.
    Author     : RonaldoYNV
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vista/cliente/catalogoProductos.jsp">Ver Productos</a>
                </li>
            </ul>

            <form class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Buscar productos...">
                <button class="btn btn-light" type="submit">🔍</button>
            </form>

            <%-- CONTROL DE SESIÓN CON JSTL --%>
            <c:choose>
                <c:when test="${empty sessionScope.usuarioLogueado}">
                    <a class="btn btn-outline-light me-2" href="${pageContext.request.contextPath}/vista/usuario/login.jsp">Login</a>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/vista/usuario/registro.jsp">Registro</a>
                </c:when>
                <c:otherwise>
                    <div class="nav-item dropdown me-2">
                        <a class="btn btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1"></i> Bienvenido, ${sessionScope.nombreUsuario}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <c:choose>
                                <c:when test="${sessionScope.usuarioLogueado.rol eq 'ADMIN'}">
                                    <li>
                                        <a class="dropdown-item fw-bold text-success" href="${pageContext.request.contextPath}/vista/admin/dashboard.jsp">
                                            <i class="fa-solid fa-gauge me-2"></i> Panel Dashboard
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-user-gear me-2"></i> Mi Perfil (Admin)
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/perfil.jsp">
                                            <i class="fa-solid fa-id-card me-2"></i> Mi Perfil
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/vista/cliente/carrito.jsp">
                                            <i class="fa-solid fa-bag-shopping me-2"></i> Ver Carrito
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
                
            <a class="btn btn-light position-relative me-2" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                🛒 Carrito
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger JSON-contador">0</span>
            </a>
        </div>
    </div>
</nav>
