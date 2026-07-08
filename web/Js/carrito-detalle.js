/* 
 Java Script Sobre los Detalles/Productos del Carro = carrito.jsp
 */

/* ==========================================================================
   🛒 DETALLE Y PROCESAMIENTO DE COMPRA - PETSHOP
   ========================================================================== */

let carrito = [];
try {
    carrito = JSON.parse(localStorage.getItem('petshop_cart')) || [];
} catch (e) {
    carrito = [];
}

document.addEventListener("DOMContentLoaded", function() {
    // 1. Renderizar inicialmente los elementos del carrito
    renderizarCarritoGrande();

    // 2. Control dinámico de los bloques de dirección (Guardada vs Nueva)
    const radRegistro = document.getElementById("radDireccionRegistro");
    const radNueva = document.getElementById("radDireccionNueva");
    const blqRegistro = document.getElementById("bloqueDireccionRegistro");
    const blqNueva = document.getElementById("bloqueDireccionNueva");
    const inputsNueva = document.querySelectorAll(".input-nueva-dir");

    function alternarDirecciones() {
        if (!radRegistro || !radNueva) return;
        
        if (radRegistro.checked) {
            blqRegistro.classList.remove("d-none");
            blqNueva.classList.add("d-none");
            // Quitamos 'required' para evitar problemas de validación oculta
            inputsNueva.forEach(input => input.removeAttribute("required"));
        } else {
            blqRegistro.classList.add("d-none");
            blqNueva.classList.remove("d-none");
            // Activamos campos obligatorios solo si usa dirección nueva
            inputsNueva.forEach(input => {
                if (!input.id.includes("txtReferencia")) {
                    input.setAttribute("required", "true");
                }
            });
        }
    }

    if (radRegistro && radNueva) {
        radRegistro.addEventListener("change", alternarDirecciones);
        radNueva.addEventListener("change", alternarDirecciones);
    }

    // 3. Delegación de eventos para el contenedor de la tabla
    const tablaCarrito = document.getElementById("tablaCarritoGrande");
    if (tablaCarrito) {
        tablaCarrito.addEventListener("click", function(e) {
            const btnMas = e.target.closest(".btn-cantidad-mas");
            const btnMenos = e.target.closest(".btn-cantidad-menos");
            const btnEliminar = e.target.closest(".btn-eliminar-grande");

            if (btnMas) cambiarCantidad(btnMas.getAttribute("data-id"), 1);
            if (btnMenos) cambiarCantidad(btnMenos.getAttribute("data-id"), -1);
            if (btnEliminar) eliminarProductoGrande(btnEliminar.getAttribute("data-id"));
        });
    }

    // 4. Acción Finalizar Compra y Procesar Pago
    const btnFinalizar = document.getElementById("btnFinalizarCompra");
    if (btnFinalizar) {
        btnFinalizar.addEventListener("click", function(e) {
            const form = document.getElementById("formDireccionEnvio");
            
            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            let datosFinalesEnvio = {};
            if (radRegistro.checked) {
                datosFinalesEnvio = {
                    tipo: "registro",
                    direccion: document.getElementById("lblDireccionRegistro").innerText.trim()
                };
            } else {
                datosFinalesEnvio = {
                    tipo: "nueva",
                    provincia: document.getElementById("txtProvincia").value,
                    distrito: document.getElementById("txtDistrito").value,
                    direccion: document.getElementById("txtDireccion").value,
                    referencia: document.getElementById("txtReferencia").value
                };
            }

            console.log("Datos de la Orden listos para enviar al Servlet:", {
                productos: carrito,
                envio: datosFinalesEnvio
            });
            
            // SEGURIDAD: Intentamos leer de múltiples formas y si falla, usamos la ruta raíz por defecto
            const redirectUrl = this.getAttribute("data-redirect") || this.dataset.redirect || "../../index.jsp";
            
            // Pop-up estético con SweetAlert2
            Swal.fire({
                title: '¡Gracias por su Compra en Tienda PetShop! 🐾',
                text: 'Tu pedido está siendo procesado.',
                icon: 'success',
                confirmButtonColor: '#8b5cf6', 
                confirmButtonText: 'Aceptar',
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = redirectUrl;
                }
            });
        });
    }
});

// 5. Funciones de Renderizado y Operaciones del Core
function renderizarCarritoGrande() {
    const contenedor = document.getElementById("tablaCarritoGrande");
    const txtSubtotal = document.getElementById("resumenSubtotal");
    const txtTotal = document.getElementById("resumenTotal");
    const btnPago = document.getElementById("btnFinalizarCompra");

    if (!contenedor) return;

    if (carrito.length === 0) {
        contenedor.innerHTML = `
            <div class="text-center py-5">
                <span class="display-3 opacity-20">🛒</span>
                <h5 class="text-muted mt-3">No tienes productos en tu carrito de compras</h5>
            </div>`;
        if (txtSubtotal) txtSubtotal.innerText = "S/. 0.00";
        if (txtTotal) txtTotal.innerText = "S/. 0.00";
        if (btnPago) btnPago.disabled = true;
        return;
    }

    if (btnPago) btnPago.disabled = false;
    let htmlContent = "";
    let montoTotal = 0;

    carrito.forEach(function(item) {
        const subtotalItem = item.precio * item.cantidad;
        montoTotal += subtotalItem;

        htmlContent += `
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between p-3 mb-3 bg-light rounded-3 border">
                <div class="d-flex align-items-center gap-3" style="width: 50%;">
                    <div class="img-contenedor-carrito border">
                        <img src="${item.imagen}" alt="${item.nombre}">
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">${item.nombre}</h6>
                        <small class="text-muted">Precio unitario: S/. ${item.precio.toFixed(2)}</small>
                    </div>
                </div>
                
                <div class="d-flex align-items-center my-3 my-md-0 gap-2">
                    <button class="btn btn-sm btn-outline-secondary rounded-circle btn-cantidad-menos" data-id="${item.id}" ${item.cantidad === 1 ? 'disabled' : ''}>-</button>
                    <span class="fw-bold px-2">${item.cantidad}</span>
                    <button class="btn btn-sm btn-outline-secondary rounded-circle btn-cantidad-mas" data-id="${item.id}">+</button>
                </div>

                <div class="d-flex align-items-center gap-4">
                    <span class="fw-bold text-success fs-5">S/. ${subtotalItem.toFixed(2)}</span>
                    <button class="btn btn-link text-danger p-0 btn-eliminar-grande" data-id="${item.id}" title="Eliminar del carrito">
                        <i class="fa-solid fa-trash-can fs-5"></i>
                    </button>
                </div>
            </div>`;
    });

    contenedor.innerHTML = htmlContent;
    if (txtSubtotal) txtSubtotal.innerText = "S/. " + montoTotal.toFixed(2);
    if (txtTotal) txtTotal.innerText = "S/. " + montoTotal.toFixed(2);
}

function cambiarCantidad(id, cambio) {
    const item = carrito.find(p => p.id === id);
    if (item) {
        item.cantidad += cambio;
        if (item.cantidad < 1) item.cantidad = 1;
        salvarCarrito();
    }
}

function eliminarProductoGrande(id) {
    carrito = carrito.filter(p => p.id !== id);
    salvarCarrito();
}

// Guarda en LocalStorage y re-renderiza la interfaz
function salvarCarrito() {
    localStorage.setItem('petshop_cart', JSON.stringify(carrito));
    renderizarCarritoGrande();
    
    // Si tienes un componente global de contador en el Navbar, puedes disparar un evento customizado aquí:
    document.dispatchEvent(new CustomEvent('carritoActualizado'));
}
