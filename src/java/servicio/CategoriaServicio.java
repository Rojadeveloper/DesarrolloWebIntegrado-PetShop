/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;
import java.util.ArrayList;
public class CategoriaServicio {
     private ArrayList<Producto> productos;

    public Catalogo() {

        productos = new ArrayList<>();

        productos.add(new Producto(1, "Croquetas", 80));
        productos.add(new Producto(2, "Vacuna", 50));
        productos.add(new Producto(3, "Shampoo", 35));
        productos.add(new Producto(4, "Juguete", 20));
    }

    public void mostrarCatalogo() {

        System.out.println("\n=== CATÁLOGO ===");

        for (Producto p : productos) {

            System.out.println(p);
        }
    }

    public Producto buscarProducto(int id) {

        for (Producto p : productos) {

            if (p.getId() == id) {
                return p;
            }
        }

        return null;
    }
}
