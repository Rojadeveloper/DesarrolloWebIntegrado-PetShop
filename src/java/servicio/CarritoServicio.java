/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;
import java.util.ArrayList;
public class CarritoServicio {
       private ArrayList<Producto> productos;

    public Carrito() {

        productos = new ArrayList<>();
    }

    public void agregarProducto(Producto producto) {

        productos.add(producto);
    }

    public ArrayList<Producto> getProductos() {

        return productos;
}
