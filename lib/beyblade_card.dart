import 'package:beyblade/beyblade_model.dart'; // Modelo para representar un Beyblade.
import 'beyblade_detail_page.dart'; // Página de detalles de un Beyblade.
import 'package:flutter/material.dart';

/// Widget para mostrar una tarjeta con información básica de un Beyblade.
/// Se integra con la página de detalles al interactuar con la tarjeta.
class BeybladeCard extends StatefulWidget {
  final Beyblade beyblade; // Beyblade asociado a esta tarjeta.

  const BeybladeCard(this.beyblade, {super.key});

  @override
  _BeybladeCardState createState() => _BeybladeCardState(beyblade);
}

/// Estado de la tarjeta de Beyblade.
/// Administra la imagen, detalles y comportamiento interactivo.
class _BeybladeCardState extends State<BeybladeCard> {
  Beyblade beyblade; // Objeto Beyblade actual.
  String? renderUrl; // URL de la imagen del Beyblade.

  _BeybladeCardState(this.beyblade);

  @override
  void initState() {
    super.initState();
    renderBeybladePic(); // Carga la imagen del Beyblade al iniciar.
  }

  /// Devuelve el widget para mostrar la imagen del Beyblade.
  /// Incluye una animación que cambia entre un marcador de posición y la imagen cargada.
  Widget get beybladeImage {
    var beybladeAvatar = Hero(
      tag: beyblade, // Animación Hero al navegar a otra página.
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(renderUrl ?? ''), // Imagen del Beyblade o vacía.
          ),
        ),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)],
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'BEY', // Texto de marcador de posición.
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: beybladeAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond, // Muestra el marcador o la imagen.
      duration: const Duration(milliseconds: 1000), // Duración de la animación.
    );

    return crossFade;
  }

  /// Carga la URL de la imagen del Beyblade y actualiza el estado.
  void renderBeybladePic() async {
    await beyblade.getImageUrl(); // Método del modelo para obtener la URL.
    if (mounted) {
      setState(() {
        renderUrl = beyblade.beybladeUrl; // Asigna la URL cargada.
      });
    }
  }

  /// Devuelve el widget que muestra la información textual del Beyblade.
  Widget get beybladeCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 350,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Esquinas redondeadas.
          color: const Color(0xFFF8F8F8), // Fondo claro.
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.beyblade.name, // Nombre del Beyblade.
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Color(0xFF000600)), // Ícono de estrella.
                    Text(
                      ': ${widget.beyblade.rating}/10', // Calificación del Beyblade.
                      style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navega a la página de detalles del Beyblade.
  void showDigimonDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BeybladeDetailPage(beyblade); // Página de detalles.
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDigimonDetailPage(), // Navega a los detalles al tocar.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              beybladeCard, // Información textual.
              Positioned(top: 7.5, child: beybladeImage), // Imagen del Beyblade.
            ],
          ),
        ),
      ),
    );
  }
}
