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
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3 text-secondary">📍 Datos de Entrega</h5>
                            <form id="formDireccionEnvio">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">Departamento / Provincia</label>
                                        <input type="text" class="form-control py-2" id="txtProvincia" placeholder="Ej: Lima, Callao" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">Distrito</label>
                                        <input type="text" class="form-control py-2" id="txtDistrito" placeholder="Ej: Los Olivos, San Borja" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">Dirección Exacta</label>
                                        <input type="text" class="form-control py-2" id="txtDireccion" placeholder="Av. Las Flores 123 - Dpto 402" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">Referencia (Opcional)</label>
                                        <input type="text" class="form-control py-2" id="txtReferencia" placeholder="Frente al parque o color de fachada">
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
        
        <script>
        var carrito = [];
        try {
            carrito = JSON.parse(localStorage.getItem('petshop_cart')) || [];
        } catch(e) {
            carrito = [];
        }

        document.addEventListener("DOMContentLoaded", function() {
            renderizarCarritoGrande();

            document.getElementById("tablaCarritoGrande").addEventListener("click", function(e) {
                var btnMas = e.target.closest(".btn-cantidad-mas");
                var btnMenos = e.target.closest(".btn-cantidad-menos");
                var btnEliminar = e.target.closest(".btn-eliminar-grande");

                if (btnMas) {
                    cambiarCantidad(btnMas.getAttribute("data-id"), 1);
                }
                if (btnMenos) {
                    cambiarCantidad(btnMenos.getAttribute("data-id"), -1);
                }
                if (btnEliminar) {
                    eliminarProductoGrande(btnEliminar.getAttribute("data-id"));
                }
            });

            document.getElementById("btnFinalizarCompra").addEventListener("click", function() {
                var form = document.getElementById("formDireccionEnvio");
                
                if (!form.checkValidity()) {
                    form.reportValidity();
                    return;
                }

                var datosEnvio = {
                    provincia: document.getElementById("txtProvincia").value,
                    distrito: document.getElementById("txtDistrito").value,
                    direccion: document.getElementById("txtDireccion").value,
                    referencia: document.getElementById("txtReferencia").value
                };

                console.log("Enviar al Servlet:", carrito, datosEnvio);
                alert("¡Todo listo! Conexión simulada con éxito.");
            });
        });

        function renderizarCarritoGrande() {
            var contenedor = document.getElementById("tablaCarritoGrande");
            var txtSubtotal = document.getElementById("resumenSubtotal");
            var txtTotal = document.getElementById("resumenTotal");
            var btnPago = document.getElementById("btnFinalizarCompra");

            if (carrito.length === 0) {
                contenedor.innerHTML = `
                    <div class="text-center py-5">
                        <span class="display-3 opacity-20">🛒</span>
                        <h5 class="text-muted mt-3">No tienes productos en tu carrito de compras</h5>
                    </div>`;
                txtSubtotal.innerText = "S/. 0.00";
                txtTotal.innerText = "S/. 0.00";
                btnPago.disabled = true;
                return;
            }

            btnPago.disabled = false;
            var htmlContent = "";
            var montoTotal = 0;

            carrito.forEach(function(item) {
                var subtotalItem = item.precio * item.cantidad;
                montoTotal += subtotalItem;

                // 🌟 NOTA: Ahora lleva la barra invertida \ antes de cada $ para que JSP no rompa la carga
                htmlContent += `
                    <div class="d-flex flex-column flex-md-row align-items-center justify-content-between p-3 mb-3 bg-light rounded-3 border">
                        <div class="d-flex align-items-center gap-3" style="width: 40%;">
                            <img src="\${item.imagen}" style="width: 70px; height: 70px; object-fit: contain;" alt="\${item.nombre}">
                            <div>
                                <h6 class="fw-bold text-dark mb-1">\${item.nombre}</h6>
                                <small class="text-muted">Precio unitario: S/. \${item.precio.toFixed(2)}</small>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center my-3 my-md-0 gap-2">
                            <button class="btn btn-sm btn-outline-secondary rounded-circle btn-cantidad-menos" data-id="\${item.id}" \${item.cantidad === 1 ? 'disabled' : ''}>-</button>
                            <span class="fw-bold px-2">\${item.cantidad}</span>
                            <button class="btn btn-sm btn-outline-secondary rounded-circle btn-cantidad-mas" data-id="\${item.id}">+</button>
                        </div>

                        <div class="d-flex align-items-center gap-4">
                            <span class="fw-bold text-success fs-5">S/. \${subtotalItem.toFixed(2)}</span>
                            <button class="btn btn-link text-danger p-0 btn-eliminar-grande" data-id="\${item.id}" title="Eliminar del carrito">
                                <i class="fa-solid fa-trash-can fs-5"></i>
                            </button>
                        </div>
                    </div>`;
            });

            contenedor.innerHTML = htmlContent;
            txtSubtotal.innerText = "S/. " + montoTotal.toFixed(2);
            txtTotal.innerText = "S/. " + montoTotal.toFixed(2);
        }

        function cambiarCantidad(id, cambio) {
            var item = carrito.find(function(p) { return p.id === id; });
            if (item) {
                item.cantidad += cambio;
                if (item.cantidad < 1) item.cantidad = 1;
                salvarCarrito();
            }
        }

        function eliminarProductoGrande(id) {
            carrito = carrito.filter(function (p) {
                return p.id !== id;
            });
            salvarCarrito();
        }

        function salvarCarrito() {
            localStorage.setItem('petshop_cart', JSON.stringify(carrito));
            renderizarCarritoGrande();
        }
        </script>
                                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>                                
    </body>
</html>