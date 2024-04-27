import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pantalla_inicio_sesion.dart'; // Importamos la pantalla de inicio de sesión

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
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

  Widget _buildInputField(String label, String placeholder, {VoidCallback? onTap, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.white),
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
        SizedBox(height: 8.0),
        TextFormField(
          onTap: onTap,
          style: TextStyle(color: Colors.white),
          controller: label == 'Fecha de nacimiento' ? _dateController : null,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.deepPurple.shade600.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

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
        child: ListView(
          children: [
            SizedBox(height: 24.0),
            Text(
              'Registrarse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            _buildInputField('Nombre', 'Inserte su nombre'),
            SizedBox(height: 16.0),
            _buildInputField('Apellido', 'Inserte su apellido'),
            SizedBox(height: 16.0),
            _buildInputField('Fecha de nacimiento', 'Fecha de nacimiento', onTap: () => _selectDate(context), icon: Icons.calendar_today),
            SizedBox(height: 16.0),
            _buildInputField('Correo electrónico', 'Inserte su correo electrónico'),
            SizedBox(height: 16.0),
            _buildInputField('Contraseña', 'Inserte su contraseña'),
            SizedBox(height: 16.0),
            _buildInputField('Confirmar contraseña', 'Inserte su contraseña nuevamente'),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para registrar al usuario
                // Navegar de regreso a la pantalla de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Registrarse'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}