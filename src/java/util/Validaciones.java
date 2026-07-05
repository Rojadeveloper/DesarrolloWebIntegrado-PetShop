/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author User
 */
public class Validaciones {

    // Verifica si un campo está vacío o contiene solo espacios
    public static boolean campoVacio(String texto) {
        return texto == null || texto.trim().isEmpty();
    }

    // Verifica que el correo tenga un formato válido
    public static boolean correoValido(String correo) {
        if (campoVacio(correo)) {
            return false;
        }

        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return correo.matches(regex);
    }
}
// Verifica que el texto tenga una longitud mínima
//    public static boolean longitudMinima(String texto, int minimo) {
//        return texto != null && texto.length() >= minimo;
//    }
//
//    public static boolean soloLetras(String texto) {
//        return texto != null && texto.matches("[a-zA-ZÁÉÍÓÚáéíóúÑñ ]+");
//    }
//
//    public static boolean soloNumeros(String texto) {
//        return texto != null && texto.matches("\\d+");
//    }
//
//    public static boolean contieneEspacios(String texto) {
//        return texto != null && texto.contains(" ");
//    }


