<%-- 
    Document   : Footer
    Created on : 10 jul. 2026, 7:03:20 p. m.
    Author     : RonaldoYNV
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<footer class="footer py-5">
    <div class="container">
        <div class="row g-4">
            
            <div class="col-lg-3 col-md-6 footer-col">
                <h5 class="fw-bold mb-3">Visítanos</h5>
                <ul class="list-unstyled d-flex flex-column gap-2">
                    <li><i class="fa-solid fa-location-dot me-2"></i> Av. Arequipa 265, Lima, Perú</li>
                    <li><i class="fa-solid fa-clock me-2"></i> Lun. a Sáb. de 9:00am a 8:00pm</li>
                    <li><i class="fa-solid fa-phone me-2"></i> +51 970606134 / (01) 396-6832</li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6 footer-col text-center d-flex align-items-center justify-content-center">
                <p class="fst-italic footer-quote px-2">
                    “Descubre una nueva forma de engreír a tu mejor amigo”
                </p>
            </div>

            <div class="col-lg-3 col-md-6 footer-col ps-lg-4">
                <h5 class="fw-bold mb-3">Te ayudamos</h5>
                <ul class="list-unstyled d-flex flex-column gap-2">
                    <li><a href="${pageContext.request.contextPath}/vista/Extra/Nosotros.jsp" class="footer-link">Sobre Nosotros</a></li>
                    <li><a href="${pageContext.request.contextPath}/vista/Extra/Nosotros.jsp" class="footer-link">Términos y Condiciones</a></li>
                </ul>
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/vista/Extra/Nosotros.jsp" class="d-inline-block border rounded p-2 bg-white text-dark text-decoration-none shadow-sm font-monospace" style="font-size: 11px;">
                        📖 <strong>Libro de Reclamaciones</strong>
                    </a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 footer-col">
                <h5 class="fw-bold mb-3">Ruta PetShop</h5>
                <ul class="list-unstyled d-flex flex-column gap-2 mb-4">
                    <li><a href="${pageContext.request.contextPath}/catalogo" class="footer-link">Productos para Perros</a></li>
                    <li><a href="${pageContext.request.contextPath}/catalogo" class="footer-link">Productos para Gatos</a></li>
                    <li><a href="#" class="footer-link">Contáctate con un asesor</a></li>
                </ul>
                
                <h5 class="fw-bold mb-3 fs-6">Síguenos en:</h5>
                <div class="d-flex gap-2 footer-socials">
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-tiktok"></i></a>
                    <a href="#" class="btn btn-sm btn-outline-light rounded-circle"><i class="fa-brands fa-whatsapp"></i></a>
                </div>
            </div>

        </div>

        <hr class="mt-5 mb-4 border-secondary opacity-20">
        <div class="row">
            <div class="col text-center text-muted small">
                <p class="mb-0">&copy; 2026 PetShop es una marca registrada de Tienda Virtual Mascotas S.A.C.</p>
            </div>
        </div>
    </div>
</footer>