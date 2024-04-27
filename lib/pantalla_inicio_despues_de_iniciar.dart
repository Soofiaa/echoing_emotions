import 'package:flutter/material.dart';
import 'pantalla_calendario.dart'; // Importa la pantalla del calendario
import 'pantalla_nueva_entrada_diario.dart'; // Importa la pantalla de entrada del diario
import 'pantalla_mi_perfil.dart'; // Importa la pantalla HomeAfterLogin

class Home extends StatelessWidget {
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
            child: Text(
              '¡Bienvenido a tu día lleno de posibilidades!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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