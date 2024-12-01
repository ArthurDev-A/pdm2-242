//
//

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Aluno {
  int? id;
  String? nome;
  String? dataNascimento;

  Aluno({this.id, this.nome, this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }

  @override
  String toString() {
    return 'Aluno{id: $id, nome: $nome, dataNascimento: $dataNascimento}';
  }
}

class AlunoDatabase {
  static final AlunoDatabase instance = AlunoDatabase._init();

  static Database? _database;

  AlunoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('aluno.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAluno(Aluno aluno) async {
    final db = await database;
    return await db.insert('TB_ALUNOS', aluno.toMap());
  }

  Future<Aluno?> getAluno(int id) async {
    final db = await database;
    final maps = await db.query(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Aluno(
      id: maps.first['id'] as int?,
      nome: maps.first['nome'] as String?,
      dataNascimento: maps.first['data_nascimento'] as String?,
    );
  }

  Future<List<Aluno>> getAllAlunos() async {
    final db = await database;
    final maps = await db.query('TB_ALUNOS');

    return List.generate(maps.length, (i) {
      return Aluno(
        id: maps[i]['id'] as int?,
        nome: maps[i]['nome'] as String?,
        dataNascimento: maps[i]['data_nascimento'] as String?,
      );
    });
  }

  Future<int> updateAluno(Aluno aluno) async {
    final db = await database;
    return await db.update(
      'TB_ALUNOS',
      aluno.toMap(),
      where: 'id = ?',
      whereArgs: [aluno.id],
    );
  }

  Future<int> deleteAluno(int id) async {
    final db = await database;
    return await db.delete(
      'TB_ALUNOS',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() async {
  // Inicializar o banco de dados
  final db = AlunoDatabase.instance;

  // Inserir um aluno
  final aluno = Aluno(nome: 'João', dataNascimento: '2000-01-01');
  int alunoId = await db.insertAluno(aluno);
  final aluno2 = Aluno(nome: 'Arthur', dataNascimento: '2006-08-14');
  int alunoId2 = await db.insertAluno(aluno2);
  // Buscar um aluno pelo ID
  Aluno? retrievedAluno = await db.getAluno(alunoId);
  Aluno? retrievedAluno2 = await db.getAluno(alunoId2);
  print('Aluno recuperado: $retrievedAluno');
  print('Aluno recuperado: $retrievedAluno2');

  // Atualizar os dados de um aluno
  if (retrievedAluno != null) {
    retrievedAluno.nome = 'João da Silva';
    await db.updateAluno(retrievedAluno);
  }
  if (retrievedAluno2 != null) {
    retrievedAluno2.nome = 'Arthur de Araujo';
    await db.updateAluno(retrievedAluno2);
  }

  // Buscar todos os alunos
  List<Aluno> alunos = await db.getAllAlunos();
  print('Todos os alunos: $alunos');

  // Deletar um aluno
  await db.deleteAluno(alunoId);
}
