import 'package:beyblade/beyblade_model.dart'; // Importa el modelo Beyblade.
import 'package:flutter/material.dart'; // Importa el paquete Flutter para UI.

/// Página para agregar un nuevo Beyblade a la lista existente.
class AddBeybladeFormPage extends StatefulWidget {
  const AddBeybladeFormPage({super.key});

  @override
  _AddBeybladeFormPageState createState() => _AddBeybladeFormPageState();
}

/// Estado asociado a la página `AddBeybladeFormPage`.
class _AddBeybladeFormPageState extends State<AddBeybladeFormPage> {
  // Controlador para manejar la entrada de texto.
  TextEditingController nameController = TextEditingController();

  /// Método para manejar el envío del formulario.
  ///
  /// Verifica si el campo de texto está vacío y, si no lo está,
  /// crea un nuevo objeto `Beyblade` y cierra la página, devolviendo el objeto.
  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      // Muestra un mensaje de error si el campo está vacío.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the beyblade name'),
      ));
    } else {
      // Crea un nuevo Beyblade con el nombre proporcionado.
      var newBeyblade = Beyblade(nameController.text);
      Navigator.of(context).pop(newBeyblade); // Devuelve el nuevo objeto.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new beyblade'),
        backgroundColor: const Color(0xFF9F0000), // Color personalizado para el AppBar.
      ),
      body: Container(
        color: const Color(0xFF895858), // Fondo de la página.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              // Campo de texto para ingresar el nombre del Beyblade.
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: nameController, // Controlador para manejar el texto ingresado.
                  style: const TextStyle(decoration: TextDecoration.none), // Estilo del texto.
                  decoration: const InputDecoration(
                    labelText: 'Beyblade Name',
                    labelStyle: TextStyle(color: Colors.black), // Color de la etiqueta.
                  ),
                ),
              ),
              // Botón para enviar el formulario.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => submitPup(context), // Llama al método submitPup al presionar.
                      child: const Text('Submit Beyblade'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
