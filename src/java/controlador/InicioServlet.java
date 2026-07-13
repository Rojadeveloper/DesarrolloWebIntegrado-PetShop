package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.dao.IProductoDAO;
import modelo.dao.impl.ProductoDAOImpl;
import modelo.entidad.Producto;

@WebServlet(name = "InicioServlet", urlPatterns = {"/inicio"})
public class InicioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Buscamos los productos en la BD desde el Servlet
            IProductoDAO prodDAO = new ProductoDAOImpl();
            List<Producto> listaProductos = prodDAO.listarOchoProductosFijos();
            
            // Los subimos al request scope para que JSTL los lea de inmediato
            request.setAttribute("productosBD", listaProductos);
            
        } catch (Exception e) {
            System.out.println("Error en InicioServlet: " + e.getMessage());
        }
        
        // Enviamos el flujo al index.jsp cargando la lista lista
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
