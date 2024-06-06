class Entrada {
  final int id_entrada;
  final int id_usuario;
  final String titulo;
  final String contenido;
  final String dibujo;
  final String audio;
  final String fecha;

  Entrada({
    required this.id_entrada,
    required this.id_usuario,
    this.titulo = '',
    this.contenido = '',
    this.dibujo = '',
    this.audio = '',
    required this.fecha
  });
}
