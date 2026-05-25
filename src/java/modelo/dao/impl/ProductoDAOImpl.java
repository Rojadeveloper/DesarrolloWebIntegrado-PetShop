/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import modelo.config.ConexionBD;
import modelo.dao.IProductoDAO;
import modelo.dto.ProductoDTO;
import modelo.entidad.Producto;

public class ProductoDAOImpl implements IProductoDAO {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List<Producto> listar() {

        List<Producto> lista = new ArrayList<>();

        String sql = "SELECT * FROM producto";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Producto p = new Producto();

                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));

                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public boolean agregar(Producto p) {

        String sql = "INSERT INTO producto(nombre, descripcion, precio, stock) VALUES(?,?,?,?)";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStock());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Producto buscarPorId(int id) {

        Producto p = new Producto();

        String sql = "SELECT * FROM producto WHERE id_producto=?";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            rs = ps.executeQuery();

            while (rs.next()) {

                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }

    @Override
    public boolean modificar(Producto p) {

        String sql = "UPDATE producto SET nombre=?, descripcion=?, precio=?, stock=? WHERE id_producto=?";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setInt(5, p.getIdProducto());

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean eliminar(int id) {

        String sql = "DELETE FROM producto WHERE id_producto=?";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            ps.setInt(1, id);

            ps.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Producto> buscar(String texto) {

        List<Producto> lista = new ArrayList<>();

        String sql = "SELECT * FROM producto WHERE nombre LIKE ?";

        try {

            conn = ConexionBD.getInstancia().getConexion();

            ps = conn.prepareStatement(sql);

            ps.setString(1, "%" + texto + "%");

            rs = ps.executeQuery();

            while (rs.next()) {

                Producto p = new Producto();

                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));

                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}



