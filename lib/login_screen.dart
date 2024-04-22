import 'package:flutter/material.dart';
import 'registration_screen.dart'; // Importamos la pantalla de registro
import 'recuperar_password.dart'; // Importamos la pantalla de recuperación de contraseña
import 'home_after_login.dart'; // Importamos la pantalla de inicio después del inicio de sesión exitoso

/*
Falta revisar que las credenciales estén correctas al iniciar sesión
 */

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.greenAccent.shade200, Colors.green.shade400],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenido a \n Echoing Emotions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Deja que tu mente descanse mientras tu corazón se expresa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.0),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Correo electrónico',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.blue.shade600.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.email, color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.blue.shade600.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
              ),
            ),
            SizedBox(height: 8.0), // Espacio adicional entre la casilla de contraseña y el botón "¿Olvidaste la contraseña?"
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navegar a la pantalla de recuperación de contraseña al presionar el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecuperarPassword()),
                  );
                },
                child: Text(
                  '¿Olvidaste la contraseña?',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 24.0), // Espacio adicional entre el botón "¿Olvidaste la contraseña?" y el botón "Iniciar sesión"
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de inicio después del inicio de sesión exitoso al presionar el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeAfterLogin()),
                );
              },
              child: Text(
                'Iniciar sesión',
                style: TextStyle(color: Colors.black87),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 12.0), // Espacio adicional entre los botones
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro al presionar el botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
