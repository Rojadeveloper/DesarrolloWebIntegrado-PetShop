package controlador;

import modelo.entidad.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import servicio.UsuarioServicio;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UsuarioServicio servicio = new UsuarioServicio();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        
        if (correo == null || correo.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Campos obligatorios");
            request.getRequestDispatcher("vista/usuario/login.jsp").forward(request, response);
            return;
        }

        Usuario user = servicio.login(correo, password);

        if (user != null) {
            HttpSession session = request.getSession();
            
            // Guardamos las llaves exactas tal cual lo necesita tu index.jsp
            session.setAttribute("usuarioLogueado", user);
            session.setAttribute("nombreUsuario", user.getNombre()); 
            
            // 🛡️ MANTENEMOS VALIDACIÓN DE ROLES INTACTA 🛡️
            if ("ADMIN".equals(user.getRol())){
                // Si es ADMIN va directamente a su panel de gestión
                response.sendRedirect(request.getContextPath() + "/vista/admin/dashboard.jsp");
            } else if ("CLIENTE".equals(user.getRol())){
                // ✅ CORRECCIÓN CLAVE: Si es CLIENTE, en vez de index.jsp, lo manda al /inicio 
                // para que el InicioServlet cargue los productos de la BD antes de pintar la web
                response.sendRedirect(request.getContextPath() + "/inicio");
            } else {
                response.sendRedirect(request.getContextPath() + "/vista/usuario/login.jsp");
            }
        } else {
            request.setAttribute("error", "Datos incorrectos");
            request.getRequestDispatcher("vista/usuario/login.jsp").forward(request, response);
        }
    }
}