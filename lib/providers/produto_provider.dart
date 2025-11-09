import 'package:flutter/material.dart';
import '../data/repository.dart';
import '../models/produto.dart';

class ProdutoProvider extends ChangeNotifier {
  final Repository _repo = Repository();

  List<Produto> _produtos = [];
  List<Produto> get produtos => _produtos;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadAll() async {
    _loading = true;
    notifyListeners();
    _produtos = await _repo.listarProdutos();
    _loading = false;
    notifyListeners();
  }

  Future<void> save(Produto p) async {
    await _repo.salvarProduto(p);
    await loadAll();
  }

  Future<void> delete(int id) async {
    await _repo.deletarProduto(id);
    await loadAll();
  }

  Produto? findById(int id) {
    try {
      return _produtos.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
