import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantalla_entrada_dibujo.dart';
import 'pantalla_grabar_audio.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'pantalla_emociones.dart';

class EntradaDiario extends StatefulWidget {
  final String emocion;
  final String emoji;

  EntradaDiario({required this.emocion, required this.emoji});

  @override
  _EntradaDiarioState createState() => _EntradaDiarioState();
}

class _EntradaDiarioState extends State<EntradaDiario> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  final double _initialHeight = 100.0;
  final GrabarAudio grabarAudio = GrabarAudio();
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  List<DrawingPoint?> _drawingPoints = [];
  double _drawingScaleFactor = 0.55;
  String? _audioPath;
  DateTime? _entryDate; //en ese se guarda la fecha

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.emoji,
                      style: TextStyle(fontSize: 40.0), // Cambia el tamaño de la carita aquí
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      widget.emocion,
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'AbrilFatface',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Título',
                      hintStyle: TextStyle(
                        fontFamily: 'AbrilFatface',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: _initialHeight,
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
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: '¿Cómo te sientes hoy?',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_drawingPoints.isNotEmpty) _buildDrawingStack(),
                SizedBox(height: 20),
                if (_audioPath != null) _buildAudioPlayer(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveEntry,
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
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
            child: Icon(Icons.edit),
            backgroundColor: Colors.amber,
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GrabarAudio()),
              );
              if (result != null) {
                setState(() {
                  _audioPath = result;
                });
              }
            },
            child: Icon(
              Icons.mic,
            ),
          ),
        ],
      ),
    );
  }

  void _saveEntry() {
    final title = _titleController.text;
    final content = _textController.text;
    final drawingPoints = _drawingPoints;
    final audioPath = _audioPath;
    final entryDate = DateTime.now(); // Asignar la fecha actual

    // Aquí puedes agregar la lógica para guardar la entrada
    print('Título: $title');
    print('Contenido: $content');
    print('Puntos de dibujo: $drawingPoints');
    print('Ruta de audio: $audioPath');
    print('Fecha: $entryDate'); // Mostrar la fecha

    // Mostrar un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entrada guardada exitosamente')),
    );
  }

  Widget _buildDrawingStack() {
    return Container(
      height: 420,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: CustomPaint(
        painter: _DrawingPainter(_drawingPoints, scaleFactor: _drawingScaleFactor),
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
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
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  if (await audioRecorder.isRecording()) return;
                  if (_audioPath != null) {
                    final playerState = audioPlayer.playerState;
                    if (playerState.playing) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.setFilePath(_audioPath!);
                      await audioPlayer.play();
                    }
                  }
                },
                icon: Icon(audioPlayer.playing ? Icons.pause : Icons.play_arrow),
              ),
              SizedBox(width: 8),
              Text('Reproducir audio'),
            ],
          ),
        ),
      ],
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;
  final double scaleFactor;

  _DrawingPainter(this.drawingPoints, {this.scaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scaleFactor);

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
