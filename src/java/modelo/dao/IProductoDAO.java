/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.util.List;

import modelo.dto.ProductoDTO;

public interface IProductoDAO {

    List<ProductoDTO> listar();

    boolean agregar(ProductoDTO p);

    ProductoDTO buscarPorId(int id);

    boolean modificar(ProductoDTO p);

    boolean eliminar(int id);

    List<ProductoDTO> buscar(String texto);
}

