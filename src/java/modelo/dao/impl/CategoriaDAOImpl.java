package modelo.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.config.ConexionBD;
import modelo.dao.ICategoriaDAO;
import modelo.entidad.Categoria;

public class CategoriaDAOImpl implements ICategoriaDAO {

    @Override
    public List<Categoria> listarCategorias() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT id_categoria, nombre, estado FROM categoria WHERE estado = 1";

        try (Connection conn = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria c = new Categoria();
                // 🔍 Nota: Si tus setters en Categoria.java se llaman diferente, adáptalos (ej: setId(..))
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setNombre(rs.getString("nombre"));
                c.setEstado(rs.getInt("estado"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}