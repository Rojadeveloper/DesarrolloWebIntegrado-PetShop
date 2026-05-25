/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import java.util.ArrayList;
public class PedidoServicio {
      private int numero;
    private ArrayList<Producto> productos;

    public Pedido(int numero, ArrayList<Producto> productos) {

        this.numero = numero;
        this.productos = productos;
    }

    public void mostrarPedido() {

        double total = 0;

        System.out.println("\n=== PEDIDO #" + numero + " ===");

        for (Producto p : productos) {

            System.out.println(p);
            total += p.getPrecio();
        }

        System.out.println("TOTAL PEDIDO: S/." + total);
    } 
}
