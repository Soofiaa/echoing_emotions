import 'dart:ui';
import 'package:echoing_emotions/usuario_sesion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'pantalla_entrada_dibujo.dart';
import 'pantalla_grabar_audio.dart';
import 'pantalla_estadisticas.dart';
import 'package:record/record.dart';
import 'GEStion_estadísticas.dart';
import 'package:just_audio/just_audio.dart';
import 'basedatos_calen_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'entrada.dart';
import 'package:provider/provider.dart';
import 'pantalla_emociones.dart';
import 'pantalla_calendario.dart';
import 'pantalla_inicio_despues_de_iniciar.dart';


class EntradaDiario extends StatefulWidget {
  final String? emocion;
  final String? emoji;
  final Event? evento;

  EntradaDiario({required this.emocion, required this.emoji, this.evento});
  final dbCalendario = DBHelper_calendario.instance;

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
  DateTime? _entryDate;

  String? _emocion;
  String? _emoji;
  String? _selectedBackgroundImage;
  List<String> _backgroundNames = ['Libreta rosada', 'Caligrafía', 'Cielo', 'Infinito', 'Arcoíris'];
  List<String> _backgroundImages = [
    'assets/fondo1.jpg',
    'assets/fondo2.jpg',
    'assets/fondo3.jpg',
    'assets/fondo4.jpg',
    'assets/fondo5.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _emocion = widget.emocion;
    _emoji = widget.emoji;
    _selectedBackgroundImage = _backgroundImages[0]; // Default background

    if (widget.evento != null) {
      _titleController.text = widget.evento!.titulo;
      _textController.text = widget.evento!.contenido;
      _audioPath = widget.evento!.audio;
      _emocion = widget.evento!.emocion;
      _emoji = widget.evento!.emoji;
      _drawingPoints = _parseDrawingPoints(widget.evento!.dibujo);
    }
  }

  List<DrawingPoint?> _parseDrawingPoints(String dibujo) {
    List<DrawingPoint?> points = [];
    var pointStrings = dibujo.split(',');
    for (var pointString in pointStrings) {
      if (pointString.isNotEmpty) {
        var pointData = pointString.split(':');
        if (pointData.length == 4) {
          points.add(DrawingPoint(
            Offset(double.parse(pointData[0]), double.parse(pointData[1])),
            Paint()
              ..color = Color(int.parse(pointData[2]))
              ..strokeWidth = double.parse(pointData[3])
              ..strokeCap = StrokeCap.round,
          ));
        }
      }
    }
    return points;
  }

  Future<void> _selectEmotion() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmocionesUsuario()),
    );

    if (result != null) {
      setState(() {
        _emocion = result;
        _emoji = _getEmojiForEmotion(result);
      });
    }
  }

  String _getEmojiForEmotion(String emocion) {
    switch (emocion) {
      case 'Miedo':
        return '😨';
      case 'Tristeza':
        return '😢';
      case 'Ira':
        return '😠';
      case 'Alegría':
        return '😊';
      case 'Sorpresa':
        return '😲';
      case 'Desagrado':
        return '😒';
      case 'Vergüenza':
        return '😳';
      case 'Asombro':
        return '😮';
      default:
        return '😊';
    }
  }

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
                    if (_emoji != null)
                      GestureDetector(
                        onTap: _selectEmotion,
                        child: Text(
                          _emoji!,
                          style: const TextStyle(fontSize: 40.0),
                        ),
                      ),
                    if (_emocion != null)
                      SizedBox(width: 10.0),
                    if (_emocion != null)
                      GestureDetector(
                        onTap: _selectEmotion,
                        child: Text(
                          _emocion!,
                          style: const TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (_emocion == null)
                      ElevatedButton(
                        onPressed: _selectEmotion,
                        child: Text('Seleccionar emoción'),
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
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedBackgroundImage,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBackgroundImage = newValue;
                        });
                      },
                      items: _backgroundImages.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(_backgroundNames[_backgroundImages.indexOf(value)]),
                        );
                      }).toList(),
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
                      image: DecorationImage(
                        image: AssetImage(_selectedBackgroundImage!),
                        fit: BoxFit.cover,
                      ),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/estadisticas');
                  },
                  child: Text('Ver estadísticas'),
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
                MaterialPageRoute(
                    builder: (context) =>
                        EntradaDibujo(initialPoints: _drawingPoints)),
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
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Icon(Icons.home),
            backgroundColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
  Future<void> _saveEntry() async {
    int? userId = UsuarioSesion().id;
    int ID = userId ?? 0;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    final title = _titleController.text;
    final content = _textController.text;
    final drawingPoints = _drawingPoints.map((point) => point != null ? '${point.offset.dx}:${point.offset.dy}:${point.paint.color.value}:${point.paint.strokeWidth}' : '').join(',');
    final audioPath = _audioPath;
    final emocion = _emocion;
    final emoji = _emoji;

    final nuevaEntrada = Entrada(
      id_entrada: widget.evento != null ? widget.evento!.id : null,
      id_usuario: ID,
      titulo: title,
      contenido: content,
      dibujo: drawingPoints,
      audio: audioPath,
      fecha: widget.evento != null ? widget.evento!.fecha : formattedDate,
      emocion: emocion,
      emoji: emoji,
    )
    ;

    if (widget.evento != null) {
      await DBHelper_calendario.instance.modificarEntrada(nuevaEntrada);
    } else {
      await DBHelper_calendario.instance.insertarEntrada(nuevaEntrada);
    }

    if (emoji != null) {
      Provider.of<EmotionStatistics>(context, listen: false)
          .incrementEmotion(emoji);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Entrada guardada exitosamente')),
    );

    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
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
        canvas.drawPoints(PointMode.points, [drawingPoints[i]!.offset],
            drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
