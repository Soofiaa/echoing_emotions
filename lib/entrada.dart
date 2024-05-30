class Entrada {
  int id_entrada;
  int id_usuario;
  String titulo;
  String contenido;
  String dibujo;
  String audio;
  String fecha;

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
