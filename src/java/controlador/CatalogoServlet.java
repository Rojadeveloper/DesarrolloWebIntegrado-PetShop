package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import modelo.dao.IProductoDAO;
import modelo.dao.impl.ProductoDAOImpl;
import modelo.dao.ICategoriaDAO;
import modelo.dao.impl.CategoriaDAOImpl;

@WebServlet("/catalogo") // Esta será la ruta oficial para entrar a la tienda
public class CatalogoServlet extends HttpServlet {

    private final IProductoDAO prodDAO = new ProductoDAOImpl();
    private final ICategoriaDAO catDAO = new CategoriaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idCatSeleccionada = 0;
            String paramCat = request.getParameter("idCat");
            if (paramCat != null && !paramCat.trim().isEmpty()) {
                idCatSeleccionada = Integer.parseInt(paramCat);
            }
            
            // Inyección limpia de atributos en el Request Scope para JSTL
            request.setAttribute("idCatSeleccionada", idCatSeleccionada);
            request.setAttribute("listaCategorias", catDAO.listarCategorias());
            request.setAttribute("listaDestacados", prodDAO.listarProductosDestacados());
            request.setAttribute("listaProductos", prodDAO.listarProductosPorCategoria(idCatSeleccionada));
            
            // Reenvío seguro a la vista del catálogo
            request.getRequestDispatcher("/vista/cliente/catalogoProductos.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error en CatalogoServlet: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/inicio");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // El catálogo público solo lee datos, delegamos al GET
        doGet(request, response);
    }
}