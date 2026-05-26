package modelo.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.config.ConexionBD;
import modelo.dao.IProductoDAO;
import modelo.dto.ProductoDTO; // Se queda aquí por si tu estructura lo requiere en otro lado
import modelo.entidad.Producto;  // 👈 Tu DAO trabaja con la Entidad real

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
                p.setImagen(rs.getString("imagen"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    @Override
    public boolean agregar(Producto p) {
        String sql = "INSERT INTO producto(nombre, descripcion, precio, stock, imagen, id_categoria) VALUES(?,?,?,?,?,?)";
        try {
            conn = ConexionBD.getInstancia().getConexion();
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagen());
            ps.setInt(6, p.getIdCategoria());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public Producto buscarPorId(int id) {
        Producto p = null;
        String sql = "SELECT * FROM producto WHERE id_producto=?";
        try {
            conn = ConexionBD.getInstancia().getConexion();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                p.setImagen(rs.getString("imagen"));
                p.setIdCategoria(rs.getInt("id_categoria"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    @Override
    public boolean modificar(Producto p) {
        String sql = "UPDATE producto SET nombre=?, descripcion=?, precio=?, stock=?, imagen=?, id_categoria=? WHERE id_producto=?";
        try {
            conn = ConexionBD.getInstancia().getConexion();
            ps = conn.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImagen());
            ps.setInt(6, p.getIdCategoria());
            ps.setInt(7, p.getIdProducto());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM producto WHERE id_producto=?";
        try {
            conn = ConexionBD.getInstancia().getConexion();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
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
                p.setImagen(rs.getString("imagen"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    // 🆕 IMPLEMENTACIÓN CON ENTIDAD: Productos destacados (Poco Stock)
    @Override
    public List<Producto> listarProductosDestacados() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT id_producto, nombre, descripcion, precio, stock, imagen, id_categoria FROM producto WHERE stock > 0 ORDER BY stock ASC LIMIT 4";
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
                p.setImagen(rs.getString("imagen"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    // 🆕 IMPLEMENTACIÓN CON ENTIDAD: Catálogo filtrado dinámicamente
    @Override
    public List<Producto> listarProductosPorCategoria(int idCategoria) {
        List<Producto> lista = new ArrayList<>();
        String sql = (idCategoria == 0) 
            ? "SELECT id_producto, nombre, descripcion, precio, stock, imagen, id_categoria FROM producto WHERE stock > 0"
            : "SELECT id_producto, nombre, descripcion, precio, stock, imagen, id_categoria FROM producto WHERE id_categoria = ? AND stock > 0";
        try {
            conn = ConexionBD.getInstancia().getConexion();
            ps = conn.prepareStatement(sql);
            if (idCategoria != 0) {
                ps.setInt(1, idCategoria);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                p.setImagen(rs.getString("imagen"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}