// lib/home.dart
import 'package:flutter/material.dart';
import 'pantalla_calendario.dart'; // Importa la pantalla del calendario
import 'pantalla_nueva_entrada_diario.dart'; // Importa la pantalla de entrada del diario
import 'pantalla_mi_perfil.dart'; // Importa la pantalla HomeAfterLogin
import 'pantalla_emociones.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  final List<Map<String, String>> emociones = [
    {'emoji': '😨', 'name': 'Miedo'},
    {'emoji': '😢', 'name': 'Tristeza'},
    {'emoji': '😠', 'name': 'Ira'},
    {'emoji': '😊', 'name': 'Alegría'},
    {'emoji': '😲', 'name': 'Sorpresa'},
    {'emoji': '😒', 'name': 'Desagrado'},
    {'emoji': '😳', 'name': 'Vergüenza'},
    {'emoji': '😮', 'name': 'Asombro'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      backgroundColor: Colors.teal.shade300, // Establece el color de fondo verde
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Meditar puede ayudarte a dormir mejor.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmocionesUsuario()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white), // Establece el color de fondo del botón blanco
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Hace que el botón tenga esquinas redondeadas
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  children: [
                    Text(
                      '¿Cómo te sientes?',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: emociones.map((emocion) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            emocion['emoji']!,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Alinea los botones en la parte inferior de la pantalla
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Organiza los botones horizontalmente
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navega a la pantalla del calendario al presionar el botón del calendario
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Calendario()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Establece el color de fondo del botón blanco
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(), // Hace que el botón sea redondo
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.calendar_today),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navega a la pantalla de entrada del diario al presionar el botón de agregar entrada al diario
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EntradaDiario()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Establece el color de fondo del botón blanco
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(), // Hace que el botón sea redondo
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.add),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navega a la pantalla HomeAfterLogin al presionar el botón de perfil
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeAfterLogin()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white), // Establece el color de fondo del botón blanco
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(), // Hace que el botón sea redondo
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
