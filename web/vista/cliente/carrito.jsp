<%-- 
    Document   : carrito
    Created on : 25 may. 2026, 2:21:39 p. m.
    Author     : Usuario by RNV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito - PetShop</title>
        
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/EstyleCarrito.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Responsive.css">
    </head>
    <body>
        <div class="container my-5">
            <h2 class="fw-bold mb-4">🛒 Resumen de tu Carrito</h2>

            <div class="row g-4">
                <div class="col-lg-8">

                    <div class="card shadow-sm border-0 mb-4 rounded-3">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3 text-secondary">Productos seleccionados</h5>
                            <div id="tablaCarritoGrande"></div>
                        </div>
                    </div>

<div class="card shadow-sm border-0 rounded-3 mb-4">
    <div class="card-body p-4">
        <h5 class="fw-bold mb-3 text-secondary">📍 Datos de Entrega</h5>
        
        <div class="mb-4">
            <div class="form-check form-check-inline me-4">
                <input class="form-check-input" type="radio" name="tipoDireccion" id="radDireccionRegistro" value="registro" checked>
                <label class="form-check-label fw-bold text-dark" for="radDireccionRegistro">
                    Enviar a mi dirección de registro
                </label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="tipoDireccion" id="radDireccionNueva" value="nueva">
                <label class="form-check-label fw-bold text-dark" for="radDireccionNueva">
                    Enviar a una dirección diferente
                </label>
            </div>
        </div>

        <form id="formDireccionEnvio">
            <div id="bloqueDireccionRegistro" class="p-3 bg-light rounded-3 border mb-3">
                <p class="mb-1 text-muted small fw-bold">Dirección guardada en tu cuenta:</p>
                <h6 class="fw-bold text-dark mb-0" id="lblDireccionRegistro">
                    ${not empty sessionScope.usuarioLogueado and not empty sessionScope.usuarioLogueado.direccion ? sessionScope.usuarioLogueado.direccion : "No tienes una dirección registrada en tu perfil."}
                </h6>
            </div>

            <div id="bloqueDireccionNueva" class="d-none animate-fade-in">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold">Departamento / Provincia</label>
                        <input type="text" class="form-control py-2 input-nueva-dir" id="txtProvincia" placeholder="Ej: Lima, Callao">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold">Distrito</label>
                        <input type="text" class="form-control py-2 input-nueva-dir" id="txtDistrito" placeholder="Ej: Los Olivos, San Borja">
                    </div>
                    <div class="col-12">
                        <label class="form-label text-muted small fw-bold">Dirección Exacta de Destino</label>
                        <input type="text" class="form-control py-2 input-nueva-dir" id="txtDireccion" placeholder="Av. Las Flores 123 - Dpto 402">
                    </div>
                    <div class="col-12">
                        <label class="form-label text-muted small fw-bold">Referencia (Opcional)</label>
                        <input type="text" class="form-control py-2" id="txtReferencia" placeholder="Frente al parque o color de fachada">
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

                </div>

                <div class="col-lg-4">
                    <div class="card shadow-sm border-0 rounded-3 position-sticky" style="top: 20px;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4 text-secondary">Resumen de Compra</h5>

                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Subtotal productos</span>
                                <span class="fw-bold text-dark" id="resumenSubtotal">S/. 0.00</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Costo de envío</span>
                                <span class="text-success fw-bold">Gratis</span>
                            </div>

                            <hr class="my-3">

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="fw-bold text-secondary fs-5">Total General:</span>
                                <span class="fw-bold text-dark fs-3" id="resumenTotal">S/. 0.00</span>
                            </div>

                            <button type="button" class="btn btn-primary w-100 py-3 fs-5 border-0 rounded-3 shadow-sm" id="btnFinalizarCompra">
                                Proceder al pago <i class="fa-solid fa-credit-card ms-2"></i>
                            </button>

                            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-link w-100 text-center mt-3 text-decoration-none text-muted small">
                                <i class="fa-solid fa-arrow-left me-1"></i> Seguir comprando
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="<%= request.getContextPath() %>/Js/carrito-detalle.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>                                
    </body>
</html>