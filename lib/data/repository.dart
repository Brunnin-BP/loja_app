import 'package:sqflite/sqflite.dart';
import '../models/produto.dart';
import '../models/venda.dart';
import 'database_helper.dart';

class Repository {
  final dbHelper = DatabaseHelper();

  // ---------- Produtos ----------
  Future<void> salvarProduto(Produto produto) async {
    final db = await dbHelper.database;
    final map = produto.toMap();
    if (produto.id == null) {
      await db.insert('produtos', map, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      await db.update('produtos', map, where: 'id = ?', whereArgs: [produto.id]);
    }
  }

  Future<List<Produto>> listarProdutos() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) => Produto.fromMap(maps[i]));
  }

  Future<void> deletarProduto(int id) async {
    final db = await dbHelper.database;
    await db.delete('produtos', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- Vendas ----------
  Future<void> salvarVenda(Venda venda) async {
    final db = await dbHelper.database;
    final map = venda.toMap();
    if (venda.id == null) {
      await db.insert('vendas', map, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      await db.update('vendas', map, where: 'id = ?', whereArgs: [venda.id]);
    }
  }

  Future<List<Venda>> listarVendas() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('vendas');
    return List.generate(maps.length, (i) => Venda.fromMap(maps[i]));
  }

  Future<void> deletarVenda(int id) async {
    final db = await dbHelper.database;
    await db.delete('vendas', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> limparDados() async {
    final db = await dbHelper.database;
    await db.delete('vendas');
    await db.delete('produtos');
  }

}
