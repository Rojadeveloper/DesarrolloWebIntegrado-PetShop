/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import java.util.ArrayList;
import modelo.entidad.Producto; // Importamos la entidad real

public class PedidoServicio {
    private int numero;
    private ArrayList<Producto> productos;

    // CORREGIDO: Mismo nombre de la clase
    public PedidoServicio(int numero, ArrayList<Producto> productos) {
        this.numero = numero;
        this.productos = productos;
    }

    public void mostrarPedido() {
        double total = 0;
        System.out.println("\n=== PEDIDO #" + numero + " ===");

        for (Producto p : productos) {
            System.out.println(p.getIdProducto() + " - " + p.getNombre() + " - S/." + p.getPrecio());
            total += p.getPrecio();
        }

        System.out.println("TOTAL PEDIDO: S/." + total);
    } 
}