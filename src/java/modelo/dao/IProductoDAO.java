package modelo.dao;

import java.util.List;
import modelo.dto.ProductoDTO; // Se queda por si tu estructura requiere el import
import modelo.entidad.Producto;  // 👈 Volvemos a importar la Entidad real
import modelo.entidad.Categoria;


public interface IProductoDAO {

    List<Producto> listar();
    
    List<Categoria> listarCategorias();

    boolean agregar(Producto p);

    Producto buscarPorId(int id);

    boolean modificar(Producto p);

    boolean eliminar(int id);

    List<Producto> buscar(String texto);
    
    // Nuevos métodos requeridos para la vista top del catálogo usando la Entidad pura
    List<Producto> listarProductosDestacados();
    List<Producto> listarProductosPorCategoria(int idCategoria);
    
    // Método para listar exactamente 8 productos fijos de la tienda
    List<Producto> listarOchoProductosFijos();
}