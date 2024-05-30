import 'package:echoing_emotions/usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mydatabase.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE mitabla('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'nombre TEXT,'
              'apellido TEXT,'
              'fechaNacimiento TEXT,'
              'correoElectronico TEXT,'
              'password TEXT)'
        );
      }
    );
  }

  Future<void> insertarUsuario(Usuarios usuario) async {
    final db = await database;
    await db.insert(
      'mitabla',
      {
        'nombre': usuario.nombre,
        'apellido': usuario.apellido,
        'fechaNacimiento': usuario.fechaNacimiento,
        'correoElectronico': usuario.correoElectronico,
        'password': usuario.password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Usuarios>> obtenerUsuarios() async {
    final db = await database;
    final usuariosMap = await db.query('mitabla');
    return usuariosMap.map((map) => Usuarios(
      id: map['id'] as int, // Asegúrate de que 'id' esté definido en la consulta
      nombre: map['nombre'] as String,
      apellido: map['apellido'] as String,
      fechaNacimiento: map['fechaNacimiento'] as String,
      correoElectronico: map['correoElectronico'] as String,
      password: map['password'] as String,
    )).toList();
  }



  Future<void> eliminarBaseDeDatos() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'mydatabase.db');
    await databaseFactory.deleteDatabase(databasePath);
    print('aaa');
  }
}

