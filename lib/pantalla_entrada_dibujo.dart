import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:ui'; // Importación de dart:ui para PointMode

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}

class EntradaDibujo extends StatefulWidget {
  final List<DrawingPoint?> initialPoints;

  EntradaDibujo({required this.initialPoints});

  @override
  _EntradaDibujoState createState() => _EntradaDibujoState();
}

class _EntradaDibujoState extends State<EntradaDibujo> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<DrawingPoint?> drawingPoints = [];

  @override
  void initState() {
    super.initState();
    drawingPoints = widget.initialPoints;
  }

  void saveDrawing(BuildContext context) {
    Navigator.pop(context, drawingPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dibujo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, drawingPoints);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveDrawing(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                drawingPoints.add(
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
            },
            onPanUpdate: (details) {
              setState(() {
                drawingPoints.add(
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
            },
            onPanEnd: (details) {
              setState(() {
                drawingPoints.add(null);
              });
            },
            child: CustomPaint(
              painter: _DrawingPainter(drawingPoints),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Row(
              children: [
                Slider(
                  min: 0,
                  max: 40,
                  value: strokeWidth,
                  onChanged: (val) => setState(() => strokeWidth = val),
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() => drawingPoints = []),
                  icon: Icon(Icons.clear),
                  label: Text("Clear Board"),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [],
          ),
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i]!.offset, drawingPoints[i + 1]!.offset,
            drawingPoints[i]!.paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [drawingPoints[i]!.offset], drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
