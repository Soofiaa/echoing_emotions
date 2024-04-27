/*
* Una idea de cómo almacenar el registro del usuario
* */

class Usuario {
  String nombre;
  String apellido;
  String fechaNacimiento;
  String correoElectronico;
  String password;

  Usuario({
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.correoElectronico,
    required this.password,
  });
}
