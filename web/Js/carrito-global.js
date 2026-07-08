/* 
Java Scripts for View = Index.jsp
 */

/* ==========================================================================
   🛒 CONTROLADOR GLOBAL DEL CARRITO DE COMPRAS - PETSHOP
   ========================================================================== */

var carrito = [];
try {
    carrito = JSON.parse(localStorage.getItem('petshop_cart')) || [];
} catch (e) {
    carrito = [];
}

document.addEventListener("DOMContentLoaded", function() {
    actualizarInterfazCarrito();

    // Inicializamos el control del Offcanvas usando la librería nativa de Bootstrap
    var miOffcanvasElemento = document.getElementById('carritoSidebar');
    var bsOffcanvas = miOffcanvasElemento ? new bootstrap.Offcanvas(miOffcanvasElemento) : null;

    document.body.addEventListener("click", function(e) {
        var botonAgregar = e.target.closest(".btn-agregar-carrito");
        var botonEliminar = e.target.closest(".btn-eliminar-item");

        if (botonAgregar) {
            var card = botonAgregar.closest(".product-card");
            if (card) {
                var producto = {
                    id: card.dataset.id,
                    nombre: card.dataset.nombre,
                    precio: parseFloat(card.dataset.precio) || 0,
                    imagen: card.dataset.imagen,
                    cantidad: 1
                };
                agregarAlCarrito(producto);
                
                if (bsOffcanvas) {
                    bsOffcanvas.show();
                }
            }
        }
        
        if (botonEliminar) {
            var idProd = botonEliminar.getAttribute("data-id");
            eliminarDelCarrito(idProd);
        }
    });
});

function agregarAlCarrito(producto) {
    var itemExistente = carrito.find(item => item.id === producto.id);
    
    if (itemExistente) {
        itemExistente.cantidad++;
    } else {
        carrito.push(producto);
    }
    salvarCarrito();
}

function eliminarDelCarrito(id) {
    carrito = carrito.filter(item => item.id !== id);
    salvarCarrito();
}

function salvarCarrito() {
    localStorage.setItem('petshop_cart', JSON.stringify(carrito));
    actualizarInterfazCarrito();
}

function actualizarInterfazCarrito() {
    var contenedorLista = document.getElementById("carritoContenidoDinamico");
    var vistaVacia = document.getElementById("estadoVacioOriginal");
    var txtTotal = document.getElementById("cart-monto-total");
    var btnPago = document.getElementById("btnProcesarPago");
    var molde = document.getElementById("molde-item-carrito");
    
    if (!contenedorLista || !vistaVacia || !txtTotal || !btnPago || !molde) return;

    var totalItems = 0;
    var montoTotal = 0;
    
    carrito.forEach(function(item) {
        totalItems += item.cantidad;
        montoTotal += (item.precio * item.cantidad);
    });
    
    var badges = document.querySelectorAll(".position-absolute.top-0.badge, .JSON-contador");
    badges.forEach(function(b) {
        b.innerText = totalItems;
    });

    contenedorLista.innerHTML = "";

    if (carrito.length === 0) {
        vistaVacia.style.display = "block";
        txtTotal.innerText = "S/. 0.00";
        btnPago.disabled = true;
        return;
    }

    vistaVacia.style.display = "none";
    txtTotal.innerText = "S/. " + montoTotal.toFixed(2);
    btnPago.disabled = false;

    carrito.forEach(function(item) {
        var clon = molde.content.cloneNode(true);
        
        clon.querySelector(".img-item-cart").src = item.imagen;
        clon.querySelector(".img-item-cart").alt = item.nombre;
        clon.querySelector(".nombre-item-cart").innerText = item.nombre;
        clon.querySelector(".info-precio-cart").innerText = "S/. " + item.precio.toFixed(2) + " x " + item.cantidad;
        clon.querySelector(".subtotal-item-cart").innerText = "S/. " + (item.precio * item.cantidad).toFixed(2);
        clon.querySelector(".btn-eliminar-item").setAttribute("data-id", item.id);
        
        contenedorLista.appendChild(clon);
    });
}


