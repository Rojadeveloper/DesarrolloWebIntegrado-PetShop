<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.entidad.Usuario" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    // 🛡️ Filtro de seguridad obligatorio antes de renderizar la vista
    Usuario userLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (userLogueado == null) {
        response.sendRedirect(request.getContextPath() + "/vista/usuario/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - PetShop</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EstiloPerfil.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Responsive.css">
</head>
<body class="bg-light">

    <jsp:include page="../Extra/Navbar.jsp" />
    <jsp:include page="../Extra/carrito-sidebar.jsp" />

    <div class="overlay-bg py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    
                    <%-- 🔔 Alertas de estado procesadas de manera limpia con JSTL --%>
                    <c:if test="${requestScope.status eq 'success'}">
                        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-3" role="alert" style="border-radius: 12px;">
                            <i class="fa-solid fa-circle-check me-2"></i> ¡Tus datos se actualizaron correctamente!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${requestScope.status eq 'error'}">
                        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-3" role="alert" style="border-radius: 12px;">
                            <i class="fa-solid fa-circle-xmark me-2"></i> Error al procesar la actualización en el servidor.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <%-- 🪪 Tarjeta de Datos de Perfil --%>
                    <div class="card card-perfil border-0 shadow-sm">
                        <div class="header-perfil text-center py-4 text-white bg-dark" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                            <i class="fa-solid fa-paw fa-4x mb-2 text-warning"></i>
                            <h3 class="mb-0 fw-bold">Mi Perfil PetShop</h3>
                            <span class="badge bg-warning text-dark mt-2 text-uppercase px-3 fw-bold">${sessionScope.usuarioLogueado.rol}</span>
                        </div>
                        
                        <div class="card-body p-4 bg-white">
                            <form id="formPerfil" action="${pageContext.request.contextPath}/UsuarioServlet" method="POST">
                                
                                <input type="hidden" name="accion" value="actualizarPerfil">
                                <input type="hidden" name="idUsuario" value="${sessionScope.usuarioLogueado.id}">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Nombre</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" class="form-control" name="nombre" value="${sessionScope.usuarioLogueado.nombre}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Apellido</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" class="form-control" name="apellido" value="${not empty sessionScope.usuarioLogueado.apellido ? sessionScope.usuarioLogueado.apellido : ''}" required>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold text-secondary small">Correo Electrónico (Cuenta)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light text-muted"><i class="fa-solid fa-envelope"></i></span>
                                            <input type="email" class="form-control bg-light text-muted" value="${sessionScope.usuarioLogueado.correo}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Contraseña</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-lock"></i></span>
                                            <input type="password" class="form-control" id="txtPassword" name="password" value="${not empty sessionScope.usuarioLogueado.password ? sessionScope.usuarioLogueado.password : ''}" required>
                                            <button class="btn btn-outline-secondary border-start-0" type="button" id="btnTogglePassword">
                                                <i class="fa-solid fa-eye" id="eyeIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Teléfono Móvil</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-phone"></i></span>
                                            <input type="text" class="form-control" name="telefono" value="${not empty sessionScope.usuarioLogueado.telefono ? sessionScope.usuarioLogueado.telefono : ''}">
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold text-secondary small">Dirección de Envío / Residencia</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-map-location-dot"></i></span>
                                            <input type="text" class="form-control" name="direccion" value="${not empty sessionScope.usuarioLogueado.direccion ? sessionScope.usuarioLogueado.direccion : ''}">
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 d-flex gap-2">
                                    <button type="button" class="btn btn-warning w-100 fw-bold text-dark shadow-sm" data-bs-toggle="modal" data-bs-target="#confirmModal">
                                        <i class="fa-solid fa-floppy-disk me-1"></i> Guardar Cambios
                                    </button>
                                    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-outline-secondary w-50 shadow-sm">Volver</a>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <%-- 🪟 MODAL DE CONFIRMACIÓN DE CAMBIOS --%>
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 15px;">
          <div class="modal-header border-0 bg-dark text-white" style="border-top-left-radius: 14px; border-top-right-radius: 14px;">
            <h5 class="modal-title fw-bold"><i class="fa-solid fa-triangle-exclamation text-warning me-2"></i> Confirmar Cambios</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body text-center py-4">
            <i class="fa-solid fa-user-pen fa-3x text-secondary mb-3"></i>
            <p class="fs-5 mb-1 fw-bold text-dark">¿Estás seguro de modificar tu perfil?</p>
            <p class="text-muted small">Los datos anteriores serán reemplazados de forma permanente.</p>
          </div>
          <div class="modal-footer border-0 d-flex gap-2 justify-content-center pb-4">
            <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-warning fw-bold text-dark px-4" id="btnConfirmarSubmit">Sí, actualizar</button>
          </div>
        </div>
      </div>
    </div>
    
    <%-- ⚡ SCRIPTS GLOBALES --%>
    <script src="${pageContext.request.contextPath}/Js/carrito-global.js"></script>
    <script src="${pageContext.request.contextPath}/Js/perfil-usuario.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>