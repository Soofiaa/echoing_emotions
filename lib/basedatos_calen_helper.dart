import 'package:echoing_emotions/pantalla_entrada_dibujo.dart';
import 'package:echoing_emotions/usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entrada.dart';

class DBHelper_calendario {
  static final DBHelper_calendario instance = DBHelper_calendario._();
  static Database? _databaseC;

  DBHelper_calendario._();

  Future<Database> get databaseC async {
    if (_databaseC != null) {
      return _databaseC!;
    }
    _databaseC = await _initDatabaseEn();
    return _databaseC!;
  }

  Future<Database> _initDatabaseEn() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'misEntradas.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE misEntradas ('
              'id_entrada INTEGER PRIMARY KEY AUTOINCREMENT,'
              'id_usuario INTEGER,'
              'titulo TEXT,'
              'contenido TEXT,'
              'dibujo TEXT,'
              'audio TEXT,'
              'fecha TEXT,'
              'emocion TEXT,'
              'emoji TEXT)',
        );
      },
    );
  }

  Future<void> insertarEntrada(Entrada entrada) async {
    final db = await databaseC;
    await db.insert(
      'misEntradas',
      entrada.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Entrada>> obtenerEntradas() async {
    final db = await databaseC;
    final entradas = await db.query('misEntradas');
    return entradas.map((map) => Entrada.fromMap(map)).toList();
  }

  Future<List<Map<String, dynamic>>> buscarFecha(int idUsuario, String fecha) async {
    final db = await databaseC;
    final result = await db.query(
      'misEntradas',
      where: 'id_usuario = ? AND fecha = ?',
      whereArgs: [idUsuario, fecha],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> buscarUsuario(int idUsuario) async {
    final db = await databaseC;
    final result = await db.query(
      'misEntradas',
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
    );
    return result;
  }

  Future<void> modificarEntrada(Entrada entrada) async {
    final db = await databaseC;
    await db.update(
      'misEntradas',
      entrada.toMap(),
      where: 'id_entrada = ?',
      whereArgs: [entrada.id_entrada],
    );
  }

  Future<void> eliminarEntrada(int idEntrada) async {
    final db = await databaseC;
    await db.delete(
      'misEntradas',
      where: 'id_entrada = ?',
      whereArgs: [idEntrada],
    );
  }

  Future<void> eliminarBaseDeDatos() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'misEntradas.db');
    await databaseFactory.deleteDatabase(databasePath);
  }
}