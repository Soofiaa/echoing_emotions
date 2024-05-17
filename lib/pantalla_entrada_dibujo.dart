import 'package:flutter/material.dart';
import 'dart:ui';

class EntradaDibujo extends StatefulWidget {
  final List<Offset?> initialPoints;

  EntradaDibujo({required this.initialPoints});

  @override
  _EntradaDibujoState createState() => _EntradaDibujoState();
}

class _EntradaDibujoState extends State<EntradaDibujo> {
  List<Offset?> points = [];

  @override
  void initState() {
    super.initState();
    points = List.from(widget.initialPoints); // Copiar los puntos iniciales
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pizarra de Dibujo')),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            points.add(details.localPosition); // Agregar el punto al dibujo
          });
        },
        onPanEnd: (details) {
          points.add(null); // Marcar el final del trazo
        },
        child: CustomPaint(
          painter: PizarraPainter(points),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, points); // Devolver los puntos dibujados
          print('Dibujo guardado');
        },
        child: Icon(Icons.save),
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
