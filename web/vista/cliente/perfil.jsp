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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/estiloglobal.css">

    <style>
        body {
            /* Fondo premium con patrón sutil de huellas/mascotas en alta calidad */
            background-image: url('https://img.freepik.com/vector-gratis/patron-elementos-mascotas-dibujados-mano_23-2148956971.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        /* Capa superpuesta para oscurecer u opacar levemente el fondo si es muy brillante */
        .overlay-bg {
            background-color: rgba(248, 249, 250, 0.85);
            width: 100%;
            min-height: 100vh;
            padding: 3rem 0;
        }
        .card-perfil {
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header-perfil {
            background: linear-gradient(135deg, #212529 0%, #2c3034 100%);
            color: white;
            position: relative;
        }
        .header-perfil::before {
            content: "\f1b0";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            right: 20px;
            bottom: 10px;
            font-size: 5rem;
            color: rgba(255, 255, 255, 0.04);
            pointer-events: none;
        }
        .input-group-text { border-right: none; }
        .form-control { border-left: none; }
        .form-control:focus { box-shadow: none; border-color: #dee2e6; }
    </style>
</head>
<body>

<div class="overlay-bg">
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
                
                <div class="card card-perfil border-0">
                    <div class="header-perfil text-center py-4">
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

<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 15px;">
      <div class="modal-header border-0 bg-dark text-white" style="border-top-left-radius: 14px; border-top-right-radius: 14px;">
        <h5 class="modal-title fw-bold" id="confirmModalLabel"><i class="fa-solid fa-triangle-exclamation text-warning me-2"></i> Confirmar Cambios</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
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
    // 1. Mostrar / Ocultar Contraseña
    const btnTogglePassword = document.getElementById('btnTogglePassword');
    const txtPassword = document.getElementById('txtPassword');
    const eyeIcon = document.getElementById('eyeIcon');

    btnTogglePassword.addEventListener('click', function () {
        const type = txtPassword.getAttribute('type') === 'password' ? 'text' : 'password';
        txtPassword.setAttribute('type', type);
        eyeIcon.classList.toggle('fa-eye');
        eyeIcon.classList.toggle('fa-eye-slash');
    });

    // 2. Ejecutar envío del formulario al confirmar dentro del recuadro emergente
    document.getElementById('btnConfirmarSubmit').addEventListener('click', function() {
        document.getElementById('formPerfil').submit();
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>