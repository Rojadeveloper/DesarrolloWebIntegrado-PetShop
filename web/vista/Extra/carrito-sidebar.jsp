<%-- 
    Document   : carrito-sidebar
    Created on : 10 jul. 2026, 6:58:54 p. m.
    Author     : RonaldoYNV
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<div class="offcanvas offcanvas-end custom-cart-canvas" tabindex="-1" id="carritoSidebar" aria-labelledby="carritoSidebarLabel">
    
    <div class="offcanvas-header border-bottom py-3">
        <h5 class="offcanvas-title fw-bold text-dark" id="carritoSidebarLabel">
            🛒 Mi Carrito <span class="badge bg-secondary ms-1 fs-6 rounded-pill JSON-contador">0</span>
        </h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    
    <div class="offcanvas-body d-flex flex-column justify-content-between">
        
        <div id="carritoContenidoDinamico" class="overflow-y-auto pe-1" style="max-height: 55vh;"></div>
        
        <div id="estadoVacioOriginal" class="cart-empty-state my-auto text-center">
            <div class="cart-empty-icon mb-4">
                <span class="display-1 text-muted opacity-50">🛒</span>
            </div>
            <h5 class="fw-bold text-secondary">Tu carrito aún está vacío</h5>
            <p class="text-muted small px-4">Explora nuestra tienda y agrega los mejores productos para tus mascotas.</p>
            <button class="btn custom-btn comprar mt-2 w-auto px-4" data-bs-dismiss="offcanvas">
                Comenzar a comprar
            </button>
        </div>

        <div class="cart-footer border-top pt-3 mt-auto">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <span class="fw-bold text-secondary">Total estimado:</span>
                <span class="fw-bold text-dark fs-4" id="cart-monto-total">S/. 0.00</span>
            </div>
            <button class="btn custom-btn comprar w-100 py-3 fs-6" id="btnProcesarPago" disabled>
                Ir a pagar compra
            </button>
        </div>

    </div>
</div>
     
<template id="molde-item-carrito">
    <div class="cart-item d-flex align-items-center justify-content-between p-2 mb-2 bg-white rounded border shadow-sm">
        <div class="d-flex align-items-center gap-2">
            <img class="img-item-cart" style="width: 50px; height: 50px; object-fit: contain;" src="" alt="">
            <div>
                <h6 class="mb-0 fw-bold text-dark text-truncate nombre-item-cart" style="max-width: 130px;"></h6>
                <small class="text-muted info-precio-cart"></small>
            </div>
        </div>
        <div class="d-flex align-items-center gap-1">
            <span class="fw-bold text-success subtotal-item-cart"></span>
            <button type="button" class="btn btn-sm text-danger btn-eliminar-item">
                <i class="fa-solid fa-trash"></i>
            </button>
        </div>
    </div>
</template>
