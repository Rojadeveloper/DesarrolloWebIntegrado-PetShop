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
            ps.setString(2, password);

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
    
    @Override
    public boolean registrarUsuario(Usuario usuario) {

        String sql = "INSERT INTO usuario(nombre, apellido, correo, password, telefono, direccion, rol) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getCorreo());
            ps.setString(4, usuario.getPassword());
            ps.setString(5, usuario.getTelefono()); 
            ps.setString(6, usuario.getDireccion());

            // CLIENTE AUTOMÁTICO
            ps.setString(7, "CLIENTE");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean existeCorreo(String correo) {

        String sql = "SELECT correo FROM usuario WHERE correo = ?";

        try (Connection con = ConexionBD.getInstancia().getConexion();
            PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, correo);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
