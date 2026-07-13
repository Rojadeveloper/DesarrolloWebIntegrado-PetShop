package controlador;

import servicio.UsuarioServicio;
import modelo.dto.RegistroDTO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private UsuarioServicio usuarioServicio;

    @Override
    public void init() {
        usuarioServicio = new UsuarioServicio();
    }

    // 📥 MUESTRA LA VISTA DE REGISTRO
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Reenvío al archivo JSP físico de manera interna
        request.getRequestDispatcher("/vista/usuario/registro.jsp").forward(request, response);
    }

    // 📤 PROCESA LA CREACIÓN DE LA CUENTA
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RegistroDTO dto = new RegistroDTO();
        dto.setNombre(request.getParameter("nombre"));
        dto.setApellido(request.getParameter("apellido"));
        dto.setCorreo(request.getParameter("correo"));
        dto.setPassword(request.getParameter("password"));
        dto.setTelefono(request.getParameter("telefono"));
        dto.setDireccion(request.getParameter("direccion"));

        boolean registrado = usuarioServicio.registrarUsuario(dto);

        if (registrado) {
            // Redirige al LOGIN mandando el parámetro "registroExitoso=true"
            response.sendRedirect(request.getContextPath() + "/login?registroExitoso=true");
        } else {
            request.setAttribute("error", "El correo ingresado ya se encuentra registrado.");
            request.getRequestDispatcher("/vista/usuario/registro.jsp").forward(request, response);
        }
    }
}