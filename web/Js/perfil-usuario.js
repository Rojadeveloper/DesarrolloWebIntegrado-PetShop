/* 
Java Scripts for View = perfil.jsp
 */

/* ==========================================================================
   👤 CONTROLADOR DE INTERFAZ DE PERFIL DE USUARIO - PETSHOP
   ========================================================================== */

document.addEventListener("DOMContentLoaded", function () {
    
    // 👁️ LÓGICA PARA MOSTRAR / OCULTAR CONTRASEÑA
    const btnTogglePassword = document.getElementById('btnTogglePassword');
    const txtPassword = document.getElementById('txtPassword');
    const eyeIcon = document.getElementById('eyeIcon');

    if (btnTogglePassword && txtPassword && eyeIcon) {
        btnTogglePassword.addEventListener('click', function () {
            // Intercambia el tipo de input entre password y text
            const type = txtPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            txtPassword.setAttribute('type', type);
            
            // Intercambia las clases del icono de FontAwesome
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });
    }

    // 🛡️ CONFIRMACIÓN Y ENVÍO DEL FORMULARIO DESDE EL MODAL
    const btnConfirmarSubmit = document.getElementById('btnConfirmarSubmit');
    const formPerfil = document.getElementById('formPerfil');

    if (btnConfirmarSubmit && formPerfil) {
        btnConfirmarSubmit.addEventListener('click', function () {
            formPerfil.submit();
        });
    }
});