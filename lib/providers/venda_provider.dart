import 'package:flutter/material.dart';
import '../data/repository.dart';
import '../models/venda.dart';

class VendaProvider extends ChangeNotifier {
  final Repository _repo = Repository();

  List<Venda> _vendas = [];
  List<Venda> get vendas => _vendas;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadAll() async {
    _loading = true;
    notifyListeners();
    _vendas = await _repo.listarVendas();
    _loading = false;
    notifyListeners();
  }

  Future<void> save(Venda v) async {
    await _repo.salvarVenda(v);
    await loadAll();
  }

  Future<void> delete(int id) async {
    await _repo.deletarVenda(id);
    await loadAll();
  }
}
