/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import modelo.dao.IUsuarioDAO;
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
}