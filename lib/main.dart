import 'package:flutter/material.dart';
import 'dart:async';
import 'beyblade_model.dart'; // Importa el modelo de datos para representar un Beyblade.
import 'beyblade_list.dart'; // Importa el widget para mostrar la lista de Beyblades.
import 'new_beyblade_form.dart'; // Importa el formulario para agregar un nuevo Beyblade.

void main() => runApp(const MyApp());

/// Clase principal de la aplicación.
/// Define el punto de entrada y la estructura básica de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de depuración.
      title: 'Colección de Beyblades', // Título de la aplicación.
      theme: ThemeData(brightness: Brightness.dark), // Establece un tema oscuro.
      home: const MyHomePage(
        title: 'My fav Beyblades', // Texto mostrado en la AppBar.
      ),
    );
  }
}

/// Widget de la página principal.
/// Contiene la lógica para mostrar la lista de Beyblades y agregar nuevos.
class MyHomePage extends StatefulWidget {
  final String title; // Título de la página.

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// Estado de la página principal.
/// Administra la lista de Beyblades y las interacciones del usuario.
class _MyHomePageState extends State<MyHomePage> {
  // Lista inicial de Beyblades predeterminados.
  List<Beyblade> initialBeyblades = [
    Beyblade('Hells_Scythe'),
    Beyblade('Wizard_Arrow'),
    Beyblade('Knight_Shield')
  ];

  /// Método que muestra el formulario para agregar un nuevo Beyblade.
  /// Al recibir el resultado del formulario, agrega el nuevo Beyblade a la lista.
  Future _showNewDigimonForm() async {
    Beyblade newBeyblade = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return const AddBeybladeFormPage(); // Formulario para ingresar datos del nuevo Beyblade.
      }),
    );
    initialBeyblades.add(newBeyblade); // Agrega el nuevo Beyblade a la lista.
    setState(() {}); // Actualiza la interfaz para reflejar los cambios.
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>(); // Clave para identificar el Scaffold.
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white), // Estilo del texto del título.
        ),
        centerTitle: true, // Centra el título en la AppBar.
        backgroundColor: const Color(0xff9f0000), // Color de fondo de la AppBar.
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add), // Ícono de agregar.
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            onPressed: _showNewDigimonForm, // Llama al formulario al presionar.
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 137, 88, 88), // Color de fondo de la página.
        child: Center(
          child: BeybladesList(initialBeyblades), // Muestra la lista de Beyblades.
        ),
      ),
    );
  }
}
