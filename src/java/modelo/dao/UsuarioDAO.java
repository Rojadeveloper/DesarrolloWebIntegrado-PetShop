/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import modelo.config.ConexionBD;
import modelo.entidad.Usuario;
import java.sql.*;

public class UsuarioDAO {

    public Usuario login(String correo, String password) {
        Usuario user = null;

        String sql = "SELECT * FROM usuario WHERE correo=? AND password=?";

        try(Connection con = ConexionBD.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, correo.trim());
            ps.setString(2, password.trim())    ;

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new Usuario();
                user.setId(rs.getInt("id_usuario"));
                user.setNombre(rs.getString("nombre"));
                user.setCorreo(rs.getString("correo"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}