<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.entidad.Usuario" %>
<%
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
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstiloPerfil.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/index.jsp">
                🐾 PetShop
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse gap-2" id="menu">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/index.jsp">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/vista/cliente/catalogoProductos.jsp"> Ver Productos </a>
                    </li>
                </ul>

                <div class="nav-item dropdown me-2">
                    <a class="btn btn-outline-light dropdown-toggle active fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-user me-1"></i> Bienvenido, <%= session.getAttribute("nombreUsuario") %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow">
                        <% if ("ADMIN".equals(userLogueado.getRol())) { %>
                            <li>
                                <a class="dropdown-item fw-bold text-success" href="<%= request.getContextPath() %>/vista/admin/dashboard.jsp">
                                    <i class="fa-solid fa-gauge me-2"></i> Panel Dashboard
                                </a>
                            </li>
                        <% } %>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger fw-bold" href="<%= request.getContextPath() %>/logout">
                                <i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </div>
                    
                <a class="btn btn-light position-relative me-2" href="#" data-bs-toggle="offcanvas" data-bs-target="#carritoSidebar">
                    🛒 Carrito
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="overlay-bg py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    
                    <% if(request.getAttribute("status") != null && request.getAttribute("status").equals("success")) { %>
                        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-3" role="alert" style="border-radius: 12px;">
                            <i class="fa-solid fa-circle-check me-2"></i> ¡Tus datos se actualizaron correctamente!
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    <% if(request.getAttribute("status") != null && request.getAttribute("status").equals("error")) { %>
                        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-3" role="alert" style="border-radius: 12px;">
                            <i class="fa-solid fa-circle-xmark me-2"></i> Error al procesar la actualización en el servidor.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <div class="card card-perfil border-0 shadow-sm">
                        <div class="header-perfil text-center py-4 text-white">
                            <i class="fa-solid fa-paw fa-4x mb-2 text-warning"></i>
                            <h3 class="mb-0 fw-bold">Mi Perfil PetShop</h3>
                            <span class="badge bg-warning text-dark mt-2 text-uppercase px-3 fw-bold"><%= userLogueado.getRol() %></span>
                        </div>
                        
                        <div class="card-body p-4 bg-white">
                            <form id="formPerfil" action="<%= request.getContextPath() %>/UsuarioServlet" method="POST">
                                
                                <input type="hidden" name="accion" value="actualizarPerfil">
                                <input type="hidden" name="idUsuario" value="<%= userLogueado.getId() %>">

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Nombre</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" class="form-control" name="nombre" value="<%= userLogueado.getNombre() %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Apellido</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" class="form-control" name="apellido" value="<%= (userLogueado.getApellido() != null) ? userLogueado.getApellido() : "" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold text-secondary small">Correo Electrónico (Cuenta)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light text-muted"><i class="fa-solid fa-envelope"></i></span>
                                            <input type="email" class="form-control bg-light text-muted" value="<%= userLogueado.getCorreo() %>" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Contraseña</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-lock"></i></span>
                                            <input type="password" class="form-control" id="txtPassword" name="password" value="<%= (userLogueado.getPassword() != null) ? userLogueado.getPassword() : "" %>" required>
                                            <button class="btn btn-outline-secondary border-start-0" type="button" id="btnTogglePassword">
                                                <i class="fa-solid fa-eye" id="eyeIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-secondary small">Teléfono Móvil</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-phone"></i></span>
                                            <input type="text" class="form-control" name="telefono" value="<%= (userLogueado.getTelefono() != null) ? userLogueado.getTelefono() : "" %>">
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold text-secondary small">Dirección de Envío / Residencia</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white text-muted"><i class="fa-solid fa-map-location-dot"></i></span>
                                            <input type="text" class="form-control" name="direccion" value="<%= (userLogueado.getDireccion() != null) ? userLogueado.getDireccion() : "" %>">
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 d-flex gap-2">
                                    <button type="button" class="btn btn-warning w-100 fw-bold text-dark shadow-sm" data-bs-toggle="modal" data-bs-target="#confirmModal">
                                        <i class="fa-solid fa-floppy-disk me-1"></i> Guardar Cambios
                                    </button>
                                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-secondary w-50 shadow-sm">Volver</a>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

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

    <script>
        const btnTogglePassword = document.getElementById('btnTogglePassword');
        const txtPassword = document.getElementById('txtPassword');
        const eyeIcon = document.getElementById('eyeIcon');

        btnTogglePassword.addEventListener('click', function () {
            const type = txtPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            txtPassword.setAttribute('type', type);
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });

        document.getElementById('btnConfirmarSubmit').addEventListener('click', function() {
            document.getElementById('formPerfil').submit();
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>