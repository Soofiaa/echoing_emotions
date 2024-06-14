class Entrada {
  final int? id_entrada;
  final int id_usuario;
  final String titulo;
  final String contenido;
  final String dibujo;
  final String? audio;
  final String fecha;
  final String? emocion;
  final String? emoji;

  Entrada({
    this.id_entrada,
    required this.id_usuario,
    required this.titulo,
    required this.contenido,
    required this.dibujo,
    this.audio,
    required this.fecha,
    this.emocion,
    this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_entrada': id_entrada,
      'id_usuario': id_usuario,
      'titulo': titulo,
      'contenido': contenido,
      'dibujo': dibujo,
      'audio': audio,
      'fecha': fecha,
      'emocion': emocion,
      'emoji': emoji,
    };
  }

  static Entrada fromMap(Map<String, dynamic> map) {
    return Entrada(
      id_entrada: map['id_entrada'],
      id_usuario: map['id_usuario'],
      titulo: map['titulo'],
      contenido: map['contenido'],
      dibujo: map['dibujo'],
      audio: map['audio'],
      fecha: map['fecha'],
      emocion: map['emocion'],
      emoji: map['emoji'],
    );
  }
}