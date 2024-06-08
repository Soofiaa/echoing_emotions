import 'package:echoing_emotions/pantalla_entrada_dibujo.dart';
import 'package:echoing_emotions/usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entrada.dart';

class DBHelper_calendario{
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
            'fecha TEXT),'
                'emocion TEXT,'
                'emoji TEXT),'

        );
        }
    );
  }
  Future<void> insertarEntrada(Entrada entrada) async {
    final db = await databaseC;
    await db.insert(
      'misEntradas',
      {
        //'id_entrada':entrada.id_entrada,
        'id_usuario':entrada.id_usuario,
        'titulo':entrada.titulo,
        'contenido':entrada.contenido,
        'dibujo': entrada.dibujo,
        'audio':entrada.audio,
        'fecha':entrada.fecha,
        'emocion':entrada.emocion,
        'emoji':entrada.emoji,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Entrada>> obtenerEntradas() async {
    final db = await databaseC;
    final entradas = await db.query('misEntradas');
    return entradas.map((map) => Entrada(
      id_entrada: map['id_entrada'] as int,
      id_usuario: map['id_usuario'] as int,
      titulo: map['titulo'] as String,
      contenido: map['contenido'] as String,
      dibujo: map['dibujo'] as String,
      audio: map['audio'] as String?,
      fecha: map['fecha'] as String,
    )).toList();
  }

  Future buscarFecha(int Id_User,String fecha) async {
    final db = await databaseC;
    final result = await db.query(
      'misEntradas',
      where: 'id_usuario =? AND fecha = ?',
      whereArgs: [Id_User,fecha],
    );
    return result;
  }

  Future buscarUsuario(int Id_User) async {
    final db = await databaseC;
    final result = await db.query(
      'misEntradas',
      where: 'id_usuario =?',
      whereArgs: [Id_User],
    );
    return result;
  }

  Future<void> eliminarBaseDeDatos() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'misEntradas.db');
    await databaseFactory.deleteDatabase(databasePath);
    print('aaa');
  }
}