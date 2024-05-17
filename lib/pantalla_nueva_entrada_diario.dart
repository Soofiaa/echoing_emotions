import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pantalla_entrada_dibujo.dart'; // Importa la clase de dibujo
import 'dart:ui';


class EntradaDiario extends StatefulWidget {
  @override
  _EntradaDiarioState createState() => _EntradaDiarioState();
}

class _EntradaDiarioState extends State<EntradaDiario> {
  TextEditingController _textController = TextEditingController();
  final double _initialHeight = 100.0; // Altura inicial del contenedor
  List<Offset?> _drawingPoints = []; // Lista para almacenar los puntos del dibujo

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Flexible(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: _initialHeight, // Altura mínima
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: TextField(
                      controller: _textController,
                      textAlign: TextAlign.justify,
                      maxLines: null, // Permite un número ilimitado de líneas
                      keyboardType: TextInputType.multiline, // Habilita el salto de línea
                      decoration: InputDecoration(
                        hintText: 'Escribe aquí',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Mostrar el dibujo guardado como una pizarra pequeña
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntradaDibujo(initialPoints: _drawingPoints)),
                  );
                  if (result != null) {
                    setState(() {
                      _drawingPoints = result;
                    });
                  }
                },
                child: Container(
                  height: 150, // Altura de la pizarra pequeña
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _drawingPoints.isNotEmpty
                      ? CustomPaint(
                    painter: PizarraPainter(_drawingPoints),
                  )
                      : Center(child: Text('Toca para dibujar')),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntradaDibujo(initialPoints: _drawingPoints)),
          );
          if (result != null) {
            setState(() {
              _drawingPoints = result;
            });
          }
        },
        child: Icon(Icons.edit), // Icono de lápiz
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Puedes agregar otros widgets aquí si es necesario
            ],
          ),
        ),
      ),
    );
  }
}

class PizarraPainter extends CustomPainter {
  final List<Offset?> points;

  PizarraPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // Dibujar puntos individuales
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
