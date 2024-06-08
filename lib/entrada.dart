import 'package:echoing_emotions/pantalla_entrada_dibujo.dart';

class Entrada {
  final int id_entrada;
  final int id_usuario;
  final String titulo;
  final String contenido;
  final String dibujo;
  final String? audio;
  final String fecha;
  final String? emocion;
  final String? emoji;

  Entrada({
    required this.id_entrada,
    required this.id_usuario,
    this.titulo = '',
    this.contenido = '',
    this.dibujo = '',
    this.audio = '',
    required this.fecha,
    this.emocion = '',
    this.emoji = ''
  });
}
