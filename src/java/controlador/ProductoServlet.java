/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import modelo.dto.ProductoDTO;
import servicio.ProductoServicio;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.File;

@MultipartConfig
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    ProductoServicio servicio = new ProductoServicio();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null) {

            // ELIMINAR
            if (accion.equals("eliminar")) {

                int id = Integer.parseInt(request.getParameter("id"));

                servicio.eliminar(id);

                response.sendRedirect("vista/admin/dashboard.jsp?mensaje=Producto eliminado exitosamente.");
            }

            // EDITAR
            else if (accion.equals("editar")) {

                int id = Integer.parseInt(request.getParameter("id"));

                ProductoDTO p = servicio.buscarPorId(id);

                request.setAttribute("productoEditar", p);

                request.getRequestDispatcher("vista/admin/dashboard.jsp")
                        .forward(request, response);
            }
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");

    ProductoDTO p = new ProductoDTO();

    p.setNombre(request.getParameter("nombre"));
    p.setDescripcion(request.getParameter("descripcion"));
    p.setPrecio(Double.parseDouble(request.getParameter("precio")));
    p.setStock(Integer.parseInt(request.getParameter("stock")));
    p.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
    
    Part archivo = request.getPart("imagen");
    String nombreImagen = archivo.getSubmittedFileName();
    String ruta = getServletContext().getRealPath("/imagen");
    File carpeta = new File(ruta);
    if(!carpeta.exists()){
        carpeta.mkdirs();
    }
    if(nombreImagen != null && !nombreImagen.isEmpty()){

        archivo.write(ruta + File.separator + nombreImagen);

        p.setImagen(nombreImagen);

    }
    String mensaje = "";

    // AGREGAR
    if (accion.equals("agregar")) {

        servicio.agregar(p);

        mensaje = "Producto agregado exitosamente.";
    }

    // MODIFICAR
    else if (accion.equals("modificar")) {

        String idTexto = request.getParameter("idProducto");

        // VALIDAR SI SE SELECCIONÓ UN PRODUCTO
        if (idTexto == null || idTexto.trim().isEmpty()) {

            request.setAttribute("mensajeError",
                    "Debe seleccionar un producto de la tabla para modificar.");

            request.getRequestDispatcher("vista/admin/dashboard.jsp")
                    .forward(request, response);

            return;
        }

        p.setIdProducto(Integer.parseInt(idTexto));
        p.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
        if(nombreImagen == null || nombreImagen.isEmpty()){
            ProductoDTO productoActual = servicio.buscarPorId(p.getIdProducto());
            p.setImagen(productoActual.getImagen());
            }else{
                p.setImagen(nombreImagen);
        }

        servicio.modificar(p);

        mensaje = "Producto modificado exitosamente.";
    }

    response.sendRedirect("vista/admin/dashboard.jsp?mensaje=" + mensaje);
}
}





