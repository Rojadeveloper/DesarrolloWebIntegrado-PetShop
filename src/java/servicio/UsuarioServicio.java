/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import modelo.dao.UsuarioDAO;
import modelo.entidad.Usuario;

public class UsuarioServicio {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    public Usuario login(String correo, String password) {

        // Validación básica
        if (correo == null || password == null) {
            return null;
        }
        
        // Llamada al DAO
        Usuario user = usuarioDAO.login(correo, password);

        // Lógica de negocio
        if (user != null) {
            System.out.println("Login correcto");
        } else {
            System.out.println("Login incorrecto");
        }

        return user;
    }
}