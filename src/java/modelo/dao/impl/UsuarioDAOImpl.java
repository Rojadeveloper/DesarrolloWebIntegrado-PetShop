/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao.impl;
import modelo.dao.IUsuarioDAO;
import modelo.entidad.Usuario;
import modelo.config.ConexionBD;
import java.sql.*;
/**
 *
 * @author User
 */
public class UsuarioDAOImpl implements IUsuarioDAO{
    
    @Override  
    public Usuario login(String correo, String password) {
        
        Usuario user = null;

        String sql = "SELECT id_usuario, nombre, correo, rol FROM usuario WHERE correo=? AND password=?";
        Connection con = ConexionBD.getInstancia().getConexion();
                
        try(PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, password)    ;

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new Usuario();
                user.setId(rs.getInt("id_usuario"));
                user.setNombre(rs.getString("nombre"));
                user.setCorreo(rs.getString("correo"));
                user.setRol(rs.getString("rol"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
