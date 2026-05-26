package modelo.dao;

import java.util.List;
import modelo.entidad.Categoria;

public interface ICategoriaDAO {
    // Método para extraer las categorías activas de la BD
    List<Categoria> listarCategorias();
}