/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import java.util.ArrayList;
import java.util.List;
import modelo.dao.IProductoDAO;
import modelo.dao.impl.ProductoDAOImpl;
import modelo.dto.ProductoDTO;
import modelo.entidad.Producto;
import modelo.entidad.Categoria;


public class ProductoServicio {

    IProductoDAO dao = new ProductoDAOImpl();
    public List<Categoria> listarCategorias() {
    return dao.listarCategorias();
    }

    // LISTAR
    public List<ProductoDTO> listar() {
        List<Producto> listaEntidad = dao.listar();
        List<ProductoDTO> listaDTO = new ArrayList<>();

        for (Producto p : listaEntidad) {
            ProductoDTO dto = new ProductoDTO();
            dto.setIdProducto(p.getIdProducto());
            dto.setNombre(p.getNombre());
            dto.setDescripcion(p.getDescripcion());
            dto.setPrecio(p.getPrecio());
            dto.setStock(p.getStock());
            dto.setNombreCategoria(p.getNombreCategoria());
            dto.setImagen(p.getImagen());
            listaDTO.add(dto);
        }
        return listaDTO;
    }

    // AGREGAR
    public boolean agregar(ProductoDTO dto) {
        Producto p = new Producto();
        p.setNombre(dto.getNombre());
        p.setDescripcion(dto.getDescripcion());
        p.setPrecio(dto.getPrecio());
        p.setStock(dto.getStock());
        p.setIdCategoria(dto.getIdCategoria());
        p.setImagen(dto.getImagen());
        return dao.agregar(p);
    }

    // BUSCAR POR ID
    public ProductoDTO buscarPorId(int id) {
        Producto p = dao.buscarPorId(id);
        ProductoDTO dto = new ProductoDTO();

        dto.setIdProducto(p.getIdProducto());
        dto.setNombre(p.getNombre());
        dto.setDescripcion(p.getDescripcion());
        dto.setPrecio(p.getPrecio());
        dto.setStock(p.getStock());
        dto.setIdCategoria(p.getIdCategoria());
        dto.setNombreCategoria(p.getNombreCategoria());
        dto.setImagen(p.getImagen());
        return dto;
    }

    // MODIFICAR
    public boolean modificar(ProductoDTO dto) {
        Producto p = new Producto();
        p.setIdProducto(dto.getIdProducto());
        p.setNombre(dto.getNombre());
        p.setDescripcion(dto.getDescripcion());
        p.setPrecio(dto.getPrecio());
        p.setStock(dto.getStock());
        p.setIdCategoria(dto.getIdCategoria());
        p.setImagen(dto.getImagen());
        return dao.modificar(p);
    }

    // ELIMINAR
    public boolean eliminar(int id) {
        return dao.eliminar(id);
    }

    // BUSCAR
    public List<ProductoDTO> buscar(String texto) {
        List<Producto> listaEntidad = dao.buscar(texto);
        List<ProductoDTO> listaDTO = new ArrayList<>();

        for (Producto p : listaEntidad) {
            ProductoDTO dto = new ProductoDTO();
            dto.setIdProducto(p.getIdProducto());
            dto.setNombre(p.getNombre());
            dto.setDescripcion(p.getDescripcion());
            dto.setPrecio(p.getPrecio());
            dto.setStock(p.getStock());
            dto.setIdCategoria(p.getIdCategoria());
            dto.setNombreCategoria(p.getNombreCategoria());
            dto.setImagen(p.getImagen());
            listaDTO.add(dto);
        }
        return listaDTO;
    }
}