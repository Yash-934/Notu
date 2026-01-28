
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:notu/models/book.dart';
import 'package:notu/models/chapter.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'notu.db');
    return await openDatabase(
      path,
      version: 3, // Incremented version to trigger onUpgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        thumbnail TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE chapters(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_id INTEGER,
        title TEXT,
        content TEXT,
        content_type INTEGER DEFAULT 0,
        FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE books ADD COLUMN thumbnail TEXT');
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE chapters ADD COLUMN content_type INTEGER DEFAULT 0');
    }
  }


  // Book operations
  Future<int> insertBook(Book book) async {
    Database db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<List<Book>> getBooks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }

  Future<int> updateBook(Book book) async {
    Database db = await database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    Database db = await database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Chapter operations
  Future<int> insertChapter(Chapter chapter) async {
    Database db = await database;
    return await db.insert('chapters', chapter.toMap());
  }

  Future<List<Chapter>> getChapters(int bookId) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'chapters',
      where: 'book_id = ?',
      whereArgs: [bookId],
    );
    return List.generate(maps.length, (i) {
      return Chapter.fromMap(maps[i]);
    });
  }

  Future<int> updateChapter(Chapter chapter) async {
    Database db = await database;
    return await db.update(
      'chapters',
      chapter.toMap(),
      where: 'id = ?',
      whereArgs: [chapter.id],
    );
  }

  Future<int> deleteChapter(int id) async {
    Database db = await database;
    return await db.delete(
      'chapters',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
