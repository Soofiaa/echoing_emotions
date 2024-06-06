// usuario_sesion.dart

import 'usuarios.dart';

class UsuarioSesion {
  // Única instancia de la clase
  static final UsuarioSesion _instance = UsuarioSesion._internal();

  // Variable para almacenar el usuario
  Usuarios? _usuario;

  // Constructor privado
  UsuarioSesion._internal();

  // Factory constructor que devuelve la instancia única
  factory UsuarioSesion() {
    return _instance;
  }

  // Getter para obtener el usuario
  Usuarios? get usuario => _usuario;

  // Setter para establecer el usuario
  set usuario(Usuarios? usuario) {
    _usuario = usuario;
  }

  // Getter para obtener el ID del usuario
  int? get id => _usuario?.id;
}