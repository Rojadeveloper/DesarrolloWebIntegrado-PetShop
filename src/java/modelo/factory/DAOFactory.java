/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.factory;

import modelo.dao.IUsuarioDAO;
import modelo.dao.impl.UsuarioDAOImpl;

public class DAOFactory {
    
    public static IUsuarioDAO getUsuarioDAO() {

        return new UsuarioDAOImpl();
    }    
}
