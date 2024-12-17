// Arthur de Araujo Custódio


import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class Aluno {
  final int? id;
  final String nome;
  final int idade;

  Aluno({this.id, required this.nome, required this.idade});

  // Converte um mapa em um objeto Aluno
  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
    );
  }

  // Converte o objeto Aluno em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
    };
  }
}

class DatabaseHelper {
  late Database db;

  // Caminho do banco de dados no sistema de arquivos
  Future<void> initDatabase() async {
    final dbPath = p.join(Directory.current.path, 'alunos.db');
    db = sqlite3.open(dbPath);
    print('Banco de dados criado em: $dbPath');

    await _createTable();
  }

  // Criação da tabela TB_ALUNOS
  Future<void> _createTable() async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL
      );
    ''');
    print('Tabela TB_ALUNOS criada com sucesso.');
  }

  // Inserção de dados de forma assíncrona
  Future<void> insertAluno(Aluno aluno) async {
    db.execute(
      'INSERT INTO TB_ALUNOS (nome, idade) VALUES (?, ?);',
      [aluno.nome, aluno.idade],
    );
    print('Aluno inserido: ${aluno.nome}, ${aluno.idade} anos.');
  }

  // Consulta de dados
  Future<List<Aluno>> getAllAlunos() async {
    final resultSet = db.select('SELECT * FROM TB_ALUNOS;');
    List<Aluno> alunos = resultSet
        .map((row) => Aluno.fromMap({
              'id': row['id'],
              'nome': row['nome'],
              'idade': row['idade'],
            }))
        .toList();

    return alunos;
  }

  // Atualização de dados
  Future<void> updateAluno(Aluno aluno) async {
    db.execute(
      'UPDATE TB_ALUNOS SET nome = ?, idade = ? WHERE id = ?;',
      [aluno.nome, aluno.idade, aluno.id],
    );
    print('Aluno atualizado: ${aluno.id} -> ${aluno.nome}, ${aluno.idade} anos.');
  }

  // Exclusão de dados
  Future<void> deleteAluno(int id) async {
    db.execute('DELETE FROM TB_ALUNOS WHERE id = ?;', [id]);
    print('Aluno com ID $id removido.');
  }

  // Fechar banco
  void closeDatabase() {
    db.dispose();
    print('Banco de dados fechado.');
  }
}

void main() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.initDatabase();

  // Inserção de dados
  await dbHelper.insertAluno(Aluno(nome: 'Arthur', idade: 22));
  await dbHelper.insertAluno(Aluno(nome: 'Lucas', idade: 17));

  // Consulta de todos os alunos
  print('\n--- Lista de Alunos ---');
  List<Aluno> alunos = await dbHelper.getAllAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  // Atualização de um aluno
  if (alunos.isNotEmpty) {
    Aluno alunoAtualizado = Aluno(
      id: alunos[0].id,
      nome: 'Arthur de Araujo',
      idade: 18,
    );
    await dbHelper.updateAluno(alunoAtualizado);
  }

  // Consulta após atualização
  print('\n--- Alunos Após Atualização ---');
  alunos = await dbHelper.getAllAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  // Exclusão de um aluno
  if (alunos.isNotEmpty) {
    await dbHelper.deleteAluno(alunos[1].id!);
  }

  // Consulta após exclusão
  print('\n--- Alunos Após Exclusão ---');
  alunos = await dbHelper.getAllAlunos();
  for (var aluno in alunos) {
    print('ID: ${aluno.id}, Nome: ${aluno.nome}, Idade: ${aluno.idade}');
  }

  // Fechar o banco de dados
  dbHelper.closeDatabase();
}