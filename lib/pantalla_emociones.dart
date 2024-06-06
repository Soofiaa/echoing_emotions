// lib/emociones_usuario.dart
import 'package:flutter/material.dart';
import 'pantalla_nueva_entrada_diario.dart'; // Importa la pantalla de entrada del diario

class EmocionesUsuario extends StatefulWidget {
  @override
  _EmocionesUsuarioState createState() => _EmocionesUsuarioState();
}

class _EmocionesUsuarioState extends State<EmocionesUsuario> {
  final List<Map<String, dynamic>> emociones = [
    {'emoji': '😨', 'name': 'Miedo'},
    {'emoji': '😢', 'name': 'Tristeza'},
    {'emoji': '😠', 'name': 'Ira'},
    {'emoji': '😊', 'name': 'Alegría'},
    {'emoji': '😲', 'name': 'Sorpresa'},
    {'emoji': '😒', 'name': 'Desagrado'},
    {'emoji': '😳', 'name': 'Vergüenza'},
    {'emoji': '😮', 'name': 'Asombro'},
  ];

  String? seleccionada;

  void guardarEmocion() {
    if (seleccionada != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EntradaDiario(
            emocion: seleccionada!,
            emoji: emociones.firstWhere((e) => e['name'] == seleccionada)['emoji']!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, seleccione una emoción'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emociones Usuario'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: emociones.length,
              itemBuilder: (context, index) {
                final emocion = emociones[index];
                final isSelected = emocion['name'] == seleccionada;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      seleccionada = emocion['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                      color: isSelected ? Colors.blueAccent : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          emocion['emoji'],
                          style: TextStyle(fontSize: 40.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          emocion['name'],
                          style: TextStyle(fontSize: 20.0),
                        ),
                        if (isSelected)
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            height: 5.0,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: guardarEmocion,
              child: Text('Guardar Emoción'),
            ),
          ),
        ],
      ),
    );
  }
}
