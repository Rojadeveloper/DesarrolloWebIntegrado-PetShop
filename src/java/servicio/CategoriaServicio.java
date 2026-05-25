/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import java.util.ArrayList;
import modelo.entidad.Producto; // Importamos la entidad real

public class CategoriaServicio {
    private ArrayList<Producto> productos;

    // CORREGIDO: Mismo nombre de la clase
    public CategoriaServicio() {
        productos = new ArrayList<>();

        // CORREGIDO: Inicialización usando los setters reales de tu clase Producto
        Producto p1 = new Producto(); p1.setIdProducto(1); p1.setNombre("Croquetas"); p1.setPrecio(80.0);
        Producto p2 = new Producto(); p2.setIdProducto(2); p2.setNombre("Vacuna"); p2.setPrecio(50.0);
        Producto p3 = new Producto(); p3.setIdProducto(3); p3.setNombre("Shampoo"); p3.setPrecio(35.0);
        Producto p4 = new Producto(); p4.setIdProducto(4); p4.setNombre("Juguete"); p4.setPrecio(20.0);

        productos.add(p1);
        productos.add(p2);
        productos.add(p3);
        productos.add(p4);
    }

    public void mostrarCatalogo() {
        System.out.println("\n=== CATÁLOGO ===");
        for (Producto p : productos) {
            // Imprime usando los getters si tu clase Producto no tiene toString
            System.out.println(p.getIdProducto() + " - " + p.getNombre() + " - S/." + p.getPrecio());
        }
    }

    public Producto buscarProducto(int id) {
        for (Producto p : productos) {
            if (p.getIdProducto() == id) {
                return p;
            }
        }
        return null;
    }
}