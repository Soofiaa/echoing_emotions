import 'package:flutter/material.dart';
import 'pantalla_entrada_texto.dart';
import 'pantalla_entrada_dibujo.dart';

class EntradaDiario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada nueva del diario'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent.shade200, Colors.teal.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16.0), // Espacio entre el texto y el botón
              TextButton(
                onPressed: () {
                  // Navegar a la interfaz EntradaClaseTexto
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntradaClaseTexto()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // Fondo blanco
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Borde rectangular y alargado
                  ),
                ),
                child: Text(
                  'Quiero escribir',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black, // Texto negro
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Espacio adicional
              TextButton(
                onPressed: () {
                  // Navegar a la interfaz EntradaDibujo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntradaDibujo()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // Fondo blanco
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Borde rectangular y alargado
                  ),
                ),
                child: Text(
                  'Quiero dibujar',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black, // Texto negro
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
