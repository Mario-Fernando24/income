import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart'; 

// Clase para manejar SharedPreferences de forma más sencilla
class SharefPref {

  // Método para guardar un valor con una clave
  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance(); 
    // Obtiene la instancia de SharedPreferences (abre la "cajita" de almacenamiento)

    prefs.setString(key, json.encode(value));  
    // Convierte el valor a JSON (String) y lo guarda bajo la clave proporcionada.
  }

  // Método para leer un valor guardado
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance(); 
    // Abre la instancia de SharedPreferences

    if (prefs.getString(key) != null) {
      // Si existe un valor guardado con esa clave...

      return json.decode(prefs.getString(key)!); 
      // Lo obtiene (como String), lo decodifica desde JSON
      // y devuelve el valor en su tipo original (Map, List, String, int, etc.)
    }

    return null; 
    // Si no existe nada guardado con esa clave, devuelve null
  }

  // Método para eliminar un valor guardado
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance(); 
    // Obtiene instancia de SharedPreferences

    return prefs.remove(key); 
    // Elimina el valor guardado bajo esa clave y devuelve true si lo eliminó.
  }

  // Método para verificar si una clave existe en SharedPreferences
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance(); 
    // Obtiene instancia de SharedPreferences

    return prefs.containsKey(key); 
    // Devuelve true si existe la clave, false si no.
  }
}
