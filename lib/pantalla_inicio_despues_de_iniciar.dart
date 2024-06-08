// lib/home.dart
import 'package:flutter/material.dart';
import 'pantalla_calendario.dart';
import 'pantalla_nueva_entrada_diario.dart';
import 'pantalla_mi_perfil.dart';
import 'pantalla_emociones.dart';
import 'pantalla_estadisticas.dart'; // Importa la pantalla de estadísticas de emojis
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
      backgroundColor: Colors.teal.shade300,
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
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                child: Column(
                  children: [
                    Text(
                      '¿Cómo te sientes?',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: emociones.map((emocion) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            emocion['emoji']!,
                            style: TextStyle(fontSize: 22.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EstadisticasEmojis()), // Asegúrate de pasar la lista correcta
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter, // Alinea el texto en la parte superior del Stack
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/ESTADISTICAS.png',
                      fit: BoxFit.cover,
                      height: 175.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0), // Ajusta la posición del texto desde la parte superior
                    child: Text(
                      'Estadísticas de emociones',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Calendario()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.calendar_today),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EntradaDiario(emocion: 'Seleccionar ', emoji: '')),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.add),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeAfterLogin()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(),
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
