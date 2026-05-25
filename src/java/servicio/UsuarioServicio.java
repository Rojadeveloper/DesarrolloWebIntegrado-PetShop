/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import modelo.dao.IUsuarioDAO;
import modelo.dto.RegistroDTO;
import modelo.dao.impl.UsuarioDAOImpl;
import modelo.entidad.Usuario;
import modelo.factory.DAOFactory;

public class UsuarioServicio {

    private IUsuarioDAO usuarioDAO;
    
    public UsuarioServicio(){
        usuarioDAO = DAOFactory.getUsuarioDAO();
    }

    public Usuario login(String correo, String password) {

        if (!isValid(correo,password)) {
            return null;
        }
        
        return usuarioDAO.login(correo.trim(), password.trim());
    }
    
    private boolean isValid(String correo, String password){
        return correo !=null && password !=null && !correo.trim().isEmpty() && !password.trim().isEmpty();   
    }
    
    public boolean registrarUsuario(RegistroDTO dto) {

        IUsuarioDAO usuarioDAO = DAOFactory.getUsuarioDAO();

        if (usuarioDAO.existeCorreo(dto.getCorreo())) {
            return false;
        }

        Usuario usuario = new Usuario();

        usuario.setNombre(dto.getNombre());
        usuario.setApellido(dto.getApellido());
        usuario.setCorreo(dto.getCorreo());
        usuario.setPassword(dto.getPassword());
        usuario.setTelefono(dto.getTelefono());
        usuario.setDireccion(dto.getDireccion());

        return usuarioDAO.registrarUsuario(usuario);
    }
}