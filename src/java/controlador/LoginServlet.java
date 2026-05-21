/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
            session.setAttribute("usuario", user);
            //VALIDAR ROL
            if ("ADMIN".equals(user.getRol())){
                response.sendRedirect("vista/admin/dashboard.jsp");
            } else if ("CLIENTE".equals(user.getRol())){
                response.sendRedirect("vista/cliente/home.jsp");
            } else {
                response.sendRedirect("vista/usuario/login.jsp");
            }
        } else {
            
            request.setAttribute("error", "Datos incorrectos");
            request.getRequestDispatcher("vista/usuario/login.jsp").forward(request, response);
        }
    }
}

