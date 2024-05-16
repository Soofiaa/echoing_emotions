import 'package:flutter/material.dart';
import 'pantalla_entrada_texto.dart';

class EntradaClaseTexto extends StatefulWidget {
  @override
  _EntradaClaseTextoState createState() => _EntradaClaseTextoState();
}

class _EntradaClaseTextoState extends State<EntradaClaseTexto> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada de Texto'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent.shade200, Colors.teal.shade300],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo de texto para escribir la entrada
              TextFormField(
                controller: _controller,
                style: TextStyle(color: Colors.black), // Letras negras
                decoration: InputDecoration(
                  labelText: 'Escribe lo que tu desees',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // Puedes ajustar la cantidad de líneas
              ),
              SizedBox(height: 16.0),

              // Botón para guardar la entrada
              ElevatedButton(
                onPressed: () {
                  final entrada = _controller.text;
                  //  guardar la entrada en tu base de datos o donde desees
                  print('Entrada guardada: $entrada');
                },
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
