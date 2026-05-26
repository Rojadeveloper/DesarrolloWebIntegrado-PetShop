package modelo.entidad;

/**
 * Entidad que representa la tabla Categoria de la BD
 * @author User
 */
public class Categoria {
    
    private int idCategoria;
    private String nombre;
    private int estado;

    // Constructor Vacío
    public Categoria() {
    }

    // Constructor Con Parámetros
    public Categoria(int idCategoria, String nombre, int estado) {
        this.idCategoria = idCategoria;
        this.nombre = nombre;
        this.estado = estado;
    }

    // Métodos Getters y Setters
    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
}