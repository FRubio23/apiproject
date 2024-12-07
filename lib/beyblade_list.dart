import 'package:beyblade/beyblade_card.dart'; // Importa la clase BeybladeCard.
import 'package:flutter/material.dart'; // Paquete principal de Flutter para interfaces gráficas.
import 'beyblade_model.dart'; // Modelo del objeto Beyblade.

/// Lista de Beyblades representados en forma de tarjetas.
/// Este widget utiliza un `ListView` para mostrar múltiples Beyblades.
class BeybladesList extends StatelessWidget {
  final List<Beyblade> beyblades; // Lista de objetos Beyblade que se mostrarán.

  const BeybladesList(this.beyblades, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context); // Construye y retorna la lista.
  }

  /// Construye un `ListView` dinámico.
  ///
  /// Utiliza un `ListView.builder` para optimizar el rendimiento en listas grandes.
  ListView _buildList(context) {
    return ListView.builder(
      itemCount: beyblades.length, // Define el número de elementos en la lista.
      itemBuilder: (context, index) { // Genera un widget para cada elemento de la lista.
        return BeybladeCard(beyblades[index]); // Representa cada Beyblade con una tarjeta.
      },
    );
  }
}

