import 'dart:convert'; // Paquete para decodificar JSON.
import 'dart:io'; // Paquete para manejar solicitudes HTTP.
import 'dart:async'; // Paquete para usar funcionalidades asincrónicas.

/// Clase que representa un Beyblade con información adicional como su imagen, tipo, dirección de giro, peso, sistema y calificación.
class Beyblade {
  final String name; // Nombre del Beyblade.
  String? beybladeUrl; // URL de la imagen asociada al Beyblade.
  String? type; // Tipo de Beyblade.
  String? spinDirection; // Dirección de giro del Beyblade (por ejemplo, izquierda o derecha).
  String? weight; // Peso del Beyblade.
  String? system; // Sistema de ensamblaje del Beyblade.
  String? apiname; // Nombre del Beyblade usado para consultas en la API.

  int rating = 10; // Calificación predeterminada del Beyblade.

  /// Constructor que inicializa un Beyblade con su nombre.
  Beyblade(this.name);

  /// Método asincrónico para obtener información del Beyblade desde un servidor local.
  ///
  /// Realiza una solicitud HTTP GET a un servidor local en la dirección `localhost:3000`.
  /// Recupera información como la imagen, tipo, dirección de giro, peso y sistema del Beyblade.
  Future getImageUrl() async {
    // Si ya se tiene la URL de la imagen, no se realiza otra solicitud.
    if (beybladeUrl != null) {
      return;
    }

    HttpClient http = HttpClient(); // Crea un cliente HTTP.
    try {
      apiname = name; // Configura el nombre para la consulta en la API.

      // Construye la URI del servidor local con el nombre del Beyblade.
      var uri = Uri.http('localhost:3000', '/beyblades/name/$apiname');
      var request = await http.getUrl(uri); // Realiza la solicitud GET.
      var response = await request.close(); // Cierra la solicitud y espera la respuesta.
      var responseBody = await response.transform(utf8.decoder).join(); // Decodifica la respuesta JSON.

      // Si la respuesta es exitosa (código 200), se extraen los datos.
      if (response.statusCode == 200) {
        var data = json.decode(responseBody); // Decodifica la respuesta JSON.
        beybladeUrl = data["imgUrl"]; // Asigna la URL de la imagen.
        type = data["type"]; // Asigna el tipo del Beyblade.
        spinDirection = data["spin_direction"]; // Asigna la dirección de giro.
        weight = data["weight"]; // Asigna el peso.
        system = data["system"]; // Asigna el sistema.
      } else {
        print('Beyblade no encontrado'); // Maneja el caso en que no se encuentra el Beyblade.
      }
    } catch (exception) {
      // Maneja errores en la solicitud.
      print('Error al hacer la solicitud: $exception');
    }
  }
}
