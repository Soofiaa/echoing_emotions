import 'package:echoing_emotions/usuarios.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pantalla_inicio_sesion.dart'; // Importamos la pantalla de inicio de sesión
import 'package:date_format/date_format.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';


class RegistrationScreen extends StatefulWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _dateController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();
    _correoController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildInputField(String label, String placeholder,
      {VoidCallback? onTap,
        IconData? icon,
        TextEditingController? controller,
        String? Function(String?)? validator,
        bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
            if (icon != null)
              GestureDetector(
                onTap: onTap,
                child: AbsorbPointer(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          onTap: onTap,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.deepPurple.shade600.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
          obscureText: obscureText,
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo electrónico';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula, un número y un carácter especial';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent.shade200, Colors.teal.shade300],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 24.0),
              const Text(
                'Registrarse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              _buildInputField(
                'Nombre',
                'Inserte su nombre',
                controller: _nombreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                'Apellido',
                'Inserte su apellido',
                controller: _apellidoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                'Fecha de nacimiento',
                'Fecha de nacimiento',
                onTap: () => _selectDate(context),
                icon: Icons.calendar_today,
                controller: _dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione su fecha de nacimiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                'Correo electrónico',
                'Inserte su correo electrónico',
                controller: _correoController,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                'Contraseña',
                'Inserte su contraseña',
                controller: _passwordController,
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              _buildInputField(
                'Confirmar contraseña',
                'Inserte su contraseña nuevamente',
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate())  {
                    // Crear instancia de User con los datos del formulario
                    User newUser = User(
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      fechaNacimiento: _dateController.text,
                      correoElectronico: _correoController.text,
                      contrasenya: _passwordController.text,
                    );
                    // Aquí puedes agregar la lógica para guardar el usuario o enviarlo a tu backend
                    final usuario = Usuarios(
                        id:1,
                        nombre:newUser.nombre,
                        apellido:newUser.apellido,
                        fechaNacimiento: newUser.fechaNacimiento,
                        correoElectronico: newUser.correoElectronico,
                        password: newUser.contrasenya
                    );



                    // Inserta un nombre (puedes hacer esto en el manejador del botón)
                    await DatabaseHelper.instance.database;
                    await DatabaseHelper.instance.insertarUsuario(usuario);


                    if (kDebugMode) {
                      print('User registered: ${newUser.nombre}, ${newUser.apellido}, ${newUser.fechaNacimiento}, ${newUser.correoElectronico}');
                    }

                    // Navegar de regreso a la pantalla de inicio de sesión
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  'Ya tienes una cuenta? Inicia sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class User {
  String nombre;
  String apellido;
  String fechaNacimiento;
  String correoElectronico;
  String contrasenya;

  User({
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.correoElectronico,
    required this.contrasenya,
  });
}
