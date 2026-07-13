package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.File;

import modelo.dto.ProductoDTO;
import servicio.ProductoServicio;

@MultipartConfig
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    private final ProductoServicio servicio = new ProductoServicio();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {
            // ELIMINAR
            if (accion.equals("eliminar")) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    servicio.eliminar(id);
                    // Redirige al Servlet Dashboard con parámetro de éxito
                    response.sendRedirect(request.getContextPath() + "/dashboard?mensaje=Producto eliminado exitosamente.");
                } catch (Exception e) {
                    response.sendRedirect(request.getContextPath() + "/dashboard?mensajeError=No se pudo eliminar el producto.");
                }
            }
            // EDITAR
            else if (accion.equals("editar")) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductoDTO p = servicio.buscarPorId(id);

                    request.setAttribute("productoEditar", p);
                    
                    // Al editar, necesitamos volver a inyectar la lista de categorías e inventario 
                    // para que el formulario no aparezca vacío. Delegamos al DashboardServlet pasándole el request actual.
                    request.setAttribute("listaProductos", servicio.listar());
                    request.setAttribute("listaCategorias", servicio.listarCategorias());

                    request.getRequestDispatcher("/vista/admin/dashboard.jsp").forward(request, response);
                } catch (Exception e) {
                    response.sendRedirect(request.getContextPath() + "/dashboard?mensajeError=Error al cargar el producto para edicion.");
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        ProductoDTO p = new ProductoDTO();

        try {
            p.setNombre(request.getParameter("nombre"));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setPrecio(Double.parseDouble(request.getParameter("precio")));
            p.setStock(Integer.parseInt(request.getParameter("stock")));
            p.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));

            Part archivo = request.getPart("imagen");
            String nombreImagen = archivo.getSubmittedFileName();
            String ruta = getServletContext().getRealPath("/imagen");
            File carpeta = new File(ruta);
            if (!carpeta.exists()) {
                carpeta.mkdirs();
            }

            if (nombreImagen != null && !nombreImagen.isEmpty()) {
                archivo.write(ruta + File.separator + nombreImagen);
                p.setImagen(nombreImagen);
            }

            String mensaje = "";

            // AGREGAR
            if ("agregar".equals(accion)) {
                servicio.agregar(p);
                mensaje = "Producto agregado exitosamente.";
            }
            // MODIFICAR
            else if ("modificar".equals(accion)) {
                String idTexto = request.getParameter("idProducto");

                if (idTexto == null || idTexto.trim().isEmpty()) {
                    request.setAttribute("mensajeError", "Debe seleccionar un producto de la tabla para modificar.");
                    // Si falla, recargamos el dashboard con los datos necesarios
                    request.setAttribute("listaProductos", servicio.listar());
                    request.setAttribute("listaCategorias", servicio.listarCategorias());
                    request.getRequestDispatcher("/vista/admin/dashboard.jsp").forward(request, response);
                    return;
                }

                p.setIdProducto(Integer.parseInt(idTexto));

                if (nombreImagen == null || nombreImagen.isEmpty()) {
                    ProductoDTO productoActual = servicio.buscarPorId(p.getIdProducto());
                    p.setImagen(productoActual.getImagen());
                } else {
                    p.setImagen(nombreImagen);
                }

                servicio.modificar(p);
                mensaje = "Producto modificado exitosamente.";
            }

            // Redirección limpia al Servlet del Dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard?mensaje=" + mensaje);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/dashboard?mensajeError=Error en el procesamiento del producto: " + e.getMessage());
        }
    }
}