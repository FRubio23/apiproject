import 'package:flutter/material.dart'; // Paquete de Flutter para interfaces gráficas.
import 'beyblade_model.dart'; // Modelo del objeto Beyblade.
import 'dart:async'; // Librería para manejar asincronía.

/// Página de detalles de un Beyblade.
/// Permite visualizar información y asignar una calificación personalizada.
class BeybladeDetailPage extends StatefulWidget {
  final Beyblade beyblade; // Beyblade asociado a esta página.

  const BeybladeDetailPage(this.beyblade, {super.key});

  @override
  _BeybladeDetailPageState createState() => _BeybladeDetailPageState();
}

/// Estado de la página de detalles del Beyblade.
/// Maneja el contenido dinámico como la calificación del Beyblade.
class _BeybladeDetailPageState extends State<BeybladeDetailPage> {
  final double beybladeAvarterSize = 150.0; // Tamaño del avatar del Beyblade.
  double _sliderValue = 10.0; // Valor inicial del slider para calificaciones.

  /// Widget para agregar una calificación personalizada al Beyblade.
  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF9F0000), // Color del slider.
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue, // Valor actual del slider.
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating; // Actualiza el valor del slider.
                    });
                  },
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}', // Muestra el valor del slider.
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        submitRatingButton, // Botón para enviar la calificación.
      ],
    );
  }

  /// Actualiza la calificación del Beyblade.
  /// Muestra un diálogo si la calificación es menor a 5.
  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog(); // Muestra un mensaje de error.
    } else {
      setState(() {
        widget.beyblade.rating = _sliderValue.toInt(); // Asigna la nueva calificación.
      });
    }
  }

  /// Muestra un cuadro de diálogo para errores en la calificación.
  Future<void> _ratingErrorDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: const Text("Come on! They're good!"), // Mensaje de error.
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo.
            )
          ],
        );
      },
    );
  }

  /// Botón para enviar la calificación.
  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(), // Llama a la función para actualizar la calificación.
      child: const Text('Submit'),
    );
  }

  /// Imagen del Beyblade mostrada como avatar en la parte superior.
  Widget get beybladeImage {
    return Hero(
      tag: widget.beyblade, // Animación Hero para transiciones visuales.
      child: Container(
        height: beybladeAvarterSize,
        width: beybladeAvarterSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Forma circular.
          boxShadow: const [ // Sombras para dar profundidad.
            BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
            BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
            BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000)),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.beyblade.beybladeUrl ?? ''), // Imagen del Beyblade.
          ),
        ),
      ),
    );
  }

  /// Muestra la calificación actual del Beyblade.
  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.star, size: 40.0, color: Colors.black), // Ícono de estrella.
        Text(
          '${widget.beyblade.rating}/10', // Calificación numérica.
          style: const TextStyle(color: Colors.black, fontSize: 30.0),
        ),
      ],
    );
  }

  /// Perfil completo del Beyblade.
  /// Incluye la imagen, nombre y detalles adicionales.
  Widget get beybladeProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(color: Color(0xFF895858)), // Fondo decorativo.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          beybladeImage, // Imagen del Beyblade.
          Text(
            widget.beyblade.name, // Nombre del Beyblade.
            style: const TextStyle(color: Colors.black, fontSize: 32.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.beyblade.type != null) infoRow('Tipo de Beyblade', widget.beyblade.type!),
                if (widget.beyblade.spinDirection != null) infoRow('Dirección de giro', widget.beyblade.spinDirection!),
                if (widget.beyblade.weight != null) infoRow('Peso', widget.beyblade.weight!),
                if (widget.beyblade.system != null) infoRow('Sistema', widget.beyblade.system!),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  /// Widget auxiliar para mostrar filas de información adicional.
  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.black)),
          Text(value, style: const TextStyle(fontSize: 20.0, color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF895858),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9F0000),
        title: Text('Meet ${widget.beyblade.name}'), // Título dinámico.
      ),
      body: ListView(
        children: <Widget>[
          beybladeProfile, // Perfil del Beyblade.
          addYourRating, // Sección para calificar.
        ],
      ),
    );
  }
}
