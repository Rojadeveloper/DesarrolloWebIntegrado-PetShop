package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.dao.IUsuarioDAO;
import modelo.dao.impl.UsuarioDAOImpl;
import modelo.entidad.Usuario;

/**
 * Controlador para la gestión de usuarios (Perfil, Registro, etc.)
 * @author User
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    /**
     * Maneja las peticiones HTTP GET (No las usamos para actualizar por seguridad)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si alguien intenta entrar por URL al Servlet, lo pateamos al index
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    /**
     * Maneja las peticiones HTTP POST (Aquí procesamos el formulario de perfil)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Capturamos la acción enviada desde el input hidden del formulario
        String accion = request.getParameter("accion");

        if ("actualizarPerfil".equals(accion)) {
            try {
                // 1. Recoger los parámetros enviados desde perfil.jsp
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String password = request.getParameter("password");
                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");

                // 2. Recuperar la sesión actual para no perder datos clave (como el correo o el rol)
                HttpSession session = request.getSession();
                Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioLogueado");

                // 3. Crear el objeto Usuario con los nuevos cambios para mandar a la BD
                Usuario userModificado = new Usuario();
                userModificado.setId(idUsuario);
                userModificado.setNombre(nombre);
                userModificado.setApellido(apellido);
                userModificado.setPassword(password);
                userModificado.setTelefono(telefono);
                userModificado.setDireccion(direccion);
                
                // Mantenemos los datos fijos que no se editan en este formulario
                if (usuarioSesion != null) {
                    userModificado.setCorreo(usuarioSesion.getCorreo());
                    userModificado.setRol(usuarioSesion.getRol());
                }

                // 4. Invocar al método del DAO para impactar en MySQL
                IUsuarioDAO uDAO = new UsuarioDAOImpl();
                boolean exito = uDAO.actualizarUsuario(userModificado);

                if (exito) {
                    // 🔥 PASO CLAVE: Sobrescribimos la sesión para que toda la interfaz se actualice al instante
                    session.setAttribute("usuarioLogueado", userModificado);
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "error");
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("status", "error");
            }

            // Redireccionamos de vuelta a perfil.jsp arrastrando la alerta de éxito o error
            request.getRequestDispatcher("/vista/cliente/perfil.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador de Usuarios - PetShop";
    }
}