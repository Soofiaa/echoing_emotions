import 'package:echoing_emotions/pantalla_inicio_despues_de_iniciar.dart';
import 'package:echoing_emotions/usuarios.dart';
import 'package:flutter/material.dart';
import 'entrada.dart';
import 'pantalla_registro.dart'; // Importamos la pantalla de registro
import 'pantalla_recuperar_contrasena.dart'; // Importamos la pantalla de recuperación
import 'pantalla_mi_perfil.dart'; // Importamos la pantalla de inicio después del inicio de sesión exitoso
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'basedatos_calen_helper.dart';
import 'usuario_sesion.dart'; // Importamos el Singleton para la sesión de usuario

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dbHelper = DatabaseHelper.instance;
  final dbCalendario = DBHelper_calendario.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent.shade200, Colors.teal.shade300],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenido a \n Echoing Emotions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Deja que tu mente descanse mientras tu corazón se expresa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: emailController,
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
              controller: passwordController,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecuperarPassword()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16.0),
                ),
                child: const Text(
                  '',  //
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;

                await DatabaseHelper.instance.database;
                final int idUser = await DatabaseHelper.instance.iniciarUsuario(email, password);

                setState(() {
                  if (idUser != 0) {
                    // id global como esta hecho hay que agregar el usuarios a global
                    UsuarioSesion().usuario = Usuarios(
                      id: idUser,
                      nombre: '',
                      apellido: '',
                      fechaNacimiento: '',
                      correoElectronico: email,
                      password: password,
                    );
                    // Navegar a la pantalla de inicio después del inicio de sesión exitoso
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } else {
                    errorMessage = 'Las credenciales están incorrectas, vuelva a ingresarlas o regístrese';
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(color: Colors.black87),
              ),
            ),
/*
            ElevatedButton( //boton de prueba
              onPressed: () async {
                //eliminar bases de datos

                //await DatabaseHelper.instance.database;
                //await DatabaseHelper.instance.eliminarBaseDeDatos();
                //await DBHelper_calendario.instance.databaseC;
                //await DBHelper_calendario.instance.eliminarBaseDeDatos();

                //


                  /*final nuevoUser = Usuarios(
                  id: 1,
                  nombre: 'nombre',
                  apellido: 'apellido',
                  fechaNacimiento: 'fechaNacimiento',
                  correoElectronico: 'correo',
                  password: 'password',
                );

                await DatabaseHelper.instance.database;
                await DatabaseHelper.instance.insertarUsuario(nuevoUser);

                final usuarios = await DatabaseHelper.instance.obtenerUsuarios();
                for (final usuario in usuarios) {
                  final nombre = usuario.nombre;
                  final id = usuario.id;
                  print('nombre: $nombre , id: $id');
                }*/

                //final nuevaEntrada = Entrada(
                  //id_entrada: 4,
                  //id_usuario: 1,
                  //titulo: 'cccc',
                  //contenido: 'cccc...',
                  //audio: 'ccc',
                //fecha: '2024-05-29',
                //);

                //await DBHelper_calendario.instance.databaseC;
                //await DBHelper_calendario.instance.insertarEntrada(nuevaEntrada);
                //await DBHelper_calendario.instance.databaseC;
                //final ent =await DBHelper_calendario.instance.buscarUsuario(1);
                //print(ent);
                //final entradas = await DBHelper_calendario.instance.buscarFecha(1,'2024-06-08');
                //print(entradas);
                //await DBHelper_calendario.instance.modificarEntrada(nuevaEntrada);
                final entradasGuardadas = await dbCalendario.obtenerEntradas();
                for (final Ens in entradasGuardadas) {
                  final titulo = Ens.titulo;
                  final contenido = Ens.contenido;
                  final fecha = Ens.fecha;
                  final id = Ens.id_entrada;
                  final idUser = Ens.id_usuario;
                  print('titulo: $titulo, contenido: $contenido, fecha:$fecha, id: $id, idUsuario: $idUser');
                }
                await DBHelper_calendario.instance.eliminarEntrada(9);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'usuario',
                style: TextStyle(color: Colors.black87),
              ),
            ),

        */

            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.0),
              ),
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

