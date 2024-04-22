import 'package:flutter/material.dart';
import 'configuracion.dart'; // Importa la pantalla de configuración
import 'acerca_de.dart'; // Importa la pantalla "Acerca de Echoing Emotions"
import 'login_screen.dart'; // Importa la pantalla de inicio de sesión

class HomeAfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent.shade200, Colors.green.shade400],
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Bienvenido, ¿Qué quieres hacer el día de hoy?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de configuración al presionar "Configuración"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configuracion()),
                  );
                },
                child: Text('Configuración', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla "Acerca de Echoing Emotions" al presionar "Acerca de Echoing Emotions"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AcercaDe()),
                  );
                },
                child: Text('Acerca de Echoing Emotions', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de inicio de sesión al presionar "Cerrar sesión"
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false, // Elimina todas las rutas anteriores
                  );
                },
                child: Text('Cerrar sesión', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 30), // Espacio adicional al final de la pantalla
          ],
        ),
      ),
    );
  }
}
