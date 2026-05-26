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

    // 🔍 Modificado: Agregamos apellido, password, telefono y direccion a la consulta SQL
        String sql = "SELECT id_usuario, nombre, apellido, correo, password, telefono, direccion, rol FROM usuario WHERE correo=? AND password=?";
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
                
                // 📝 Seteamos los campos faltantes para que fluyan hacia la sesión de perfil.jsp
                user.setApellido(rs.getString("apellido"));
                user.setPassword(rs.getString("password"));
                user.setTelefono(rs.getString("telefono"));
                user.setDireccion(rs.getString("direccion"));
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
    
    @Override
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuario SET nombre = ?, apellido = ?, password = ?, telefono = ?, direccion = ? WHERE id_usuario = ?";

        try (Connection con = ConexionBD.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getPassword());
            ps.setString(4, usuario.getTelefono());
            ps.setString(5, usuario.getDireccion());
            ps.setInt(6, usuario.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
