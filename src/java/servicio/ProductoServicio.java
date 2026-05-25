/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import java.util.List;

import modelo.dao.IProductoDAO;
import modelo.dao.impl.ProductoDAOImpl;
import modelo.dto.ProductoDTO;

public class ProductoServicio {

    IProductoDAO dao = new ProductoDAOImpl();

    public List<ProductoDTO> listar() {
        return dao.listar();
    }

    public boolean agregar(ProductoDTO p) {
        return dao.agregar(p);
    }

    public ProductoDTO buscarPorId(int id) {
        return dao.buscarPorId(id);
    }

    public boolean modificar(ProductoDTO p) {
        return dao.modificar(p);
    }

    public boolean eliminar(int id) {
        return dao.eliminar(id);
    }

    public List<ProductoDTO> buscar(String texto) {
        return dao.buscar(texto);

public class ProductoServicio {
    
    private int id;
    private String nombre;
    private double precio;

    public Producto(int id, String nombre, double precio) {

        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public double getPrecio() {
        return precio;
    }

    @Override
    public String toString() {

        return id + " - " + nombre + " - S/." + precio;

    }
}


