import 'package:flutter/material.dart';
import 'pantalla_configuracion.dart'; // Importa la pantalla de configuración
import 'pantalla_acerca_de.dart'; // Importa la pantalla "Acerca de Echoing Emotions"
import 'pantalla_inicio_sesion.dart'; // Importa la pantalla de inicio de sesión

class HomeAfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent.shade200, Colors.teal.shade300],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Reemplaza con la ruta de tu imagen de perfil
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navega a la pantalla de configuración al presionar "Configuración"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configuracion()),
                  );
                },
                icon: Icon(Icons.settings), // Agrega un icono al botón
                label: Text('Configuración', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navega a la pantalla "Acerca de Echoing Emotions" al presionar "Acerca de Echoing Emotions"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcercaDe()),
                  );
                },
                icon: Icon(Icons.info), // Agrega un icono al botón
                label: Text('Acerca de Echoing Emotions', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Muestra un diálogo de confirmación al presionar "Cerrar sesión"
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿Cerrar sesión?'),
                        content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Cierra el diálogo
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navega a la pantalla de inicio de sesión al presionar "Sí"
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false, // Elimina todas las rutas anteriores
                              );
                            },
                            child: Text('Sí'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.logout), // Agrega un icono al botón
                label: Text('Cerrar sesión', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 30), // Espacio adicional al final de la pantalla
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                '¡Tienes el poder de hacer que hoy sea increíble!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
