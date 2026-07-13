package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import modelo.dto.ProductoDTO;
import servicio.ProductoServicio;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ProductoServicio servicio = new ProductoServicio();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String buscar = request.getParameter("buscar");
            List<ProductoDTO> lista;

            if (buscar != null && !buscar.trim().isEmpty()) {
                lista = servicio.buscar(buscar);
            } else {
                lista = servicio.listar();
            }

            // Inyección limpia de atributos en el Request Scope para JSTL
            request.setAttribute("listaProductos", lista);
            request.setAttribute("listaCategorias", servicio.listarCategorias());

            // Reenvío seguro a la vista del Dashboard
            request.getRequestDispatcher("/vista/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Error en DashboardServlet: " + e.getMessage());
            request.setAttribute("mensajeError", "Error al cargar los datos del inventario: " + e.getMessage());
            request.getRequestDispatcher("/vista/admin/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}