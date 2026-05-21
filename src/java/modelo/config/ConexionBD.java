/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.config;


import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {
    private static ConexionBD instancia;
    private Connection conn;
    private static final String URL = "jdbc:mysql://localhost:3306/tienda_mascotas";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private ConexionBD(){
        try{
            Class.forName("com.mysql.jdbc.Driver"); // Driver antiguo
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            
        } catch (Exception e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
    }
    
    public static ConexionBD getInstancia() {

        if (instancia == null){
            instancia = new ConexionBD();
        }
        return instancia;
    }
    public Connection getConexion(){
        return conn;
    }
}