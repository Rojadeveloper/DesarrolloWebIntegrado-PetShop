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
    
    // 📥 MUESTRA EL FORMULARIO (Evita acceder al JSP directamente)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Usamos la ruta absoluta desde la raíz del despliegue
        request.getRequestDispatcher("/vista/usuario/login.jsp").forward(request, response);
    }
    
    // 📤 PROCESA LOS DATOS DEL FORMULARIO
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        
        // Validación de campos vacíos
        if (correo == null || correo.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Campos obligatorios");
            request.getRequestDispatcher("/vista/usuario/login.jsp").forward(request, response);
            return;
        }

        // Llamada a tu capa de servicio
        Usuario user = servicio.login(correo, password);

        if (user != null) {
            HttpSession session = request.getSession();
            
            // Guardamos las llaves exactas que requiere la aplicación
            session.setAttribute("usuarioLogueado", user);
            session.setAttribute("nombreUsuario", user.getNombre()); 
            
            // 🛡️ CONTROL DE ROLES
            if ("ADMIN".equals(user.getRol())){
                // Si es ADMIN va directamente a su panel de gestión
                response.sendRedirect(request.getContextPath() + "/vista/admin/dashboard.jsp");
            } else if ("CLIENTE".equals(user.getRol())){
                // Si es CLIENTE va al InicioServlet para procesar la BD
                response.sendRedirect(request.getContextPath() + "/inicio");
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            // Error de autenticación: mandamos de vuelta al login con el mensaje
            request.setAttribute("error", "Datos incorrectos");
            request.getRequestDispatcher("/vista/usuario/login.jsp").forward(request, response);
        }
    }
}