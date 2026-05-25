/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.util.List;
import modelo.entidad.Producto;

public interface IProductoDAO {

    List<Producto> listar();

    boolean agregar(Producto p);

    Producto buscarPorId(int id);

    boolean modificar(Producto p);

    boolean eliminar(int id);

    List<Producto> buscar(String texto);
}

