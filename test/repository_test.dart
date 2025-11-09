import 'package:flutter_test/flutter_test.dart';
import 'package:loja_app/data/repository.dart';
import 'package:loja_app/models/produto.dart';
import 'package:loja_app/models/venda.dart';

void main() {
  final repository = Repository();

  // Limpa os dados antes de cada teste
  setUp(() async {
    await repository.limparDados(); // Certifique-se de implementar esse método no Repository
  });

  group('Testes de Unidade - Repository', () {
    test('Teste 1: Criar e listar Produto', () async {
      final produto = Produto(
        nome: 'Teclado Mecânico',
        preco: 250.0,
        estoque: 10,
        descricao: 'Teclado com switches azuis',
        categoria: 'Periféricos',
      );

      await repository.salvarProduto(produto);
      final produtos = await repository.listarProdutos();

      expect(produtos.isNotEmpty, true);
      expect(produtos.any((p) => p.nome == 'Teclado Mecânico'), true);
    });

    test('Teste 2: Deletar Produto', () async {
      final produto = Produto(
        nome: 'Mouse Gamer',
        preco: 150.0,
        estoque: 20,
        descricao: 'Mouse com LED RGB',
        categoria: 'Periféricos',
      );

      await repository.salvarProduto(produto);
      var produtos = await repository.listarProdutos();
      final id = produtos.last.id!;

      await repository.deletarProduto(id);
      produtos = await repository.listarProdutos();

      expect(produtos.any((p) => p.id == id), false);
    });

    test('Teste 3: Atualizar Produto', () async {
      final produto = Produto(
        nome: 'Monitor 24"',
        preco: 800.0,
        estoque: 5,
        descricao: 'Monitor Full HD',
        categoria: 'Monitores',
      );

      await repository.salvarProduto(produto);
      var produtos = await repository.listarProdutos();
      final id = produtos.last.id!;

      final atualizado = Produto(
        id: id,
        nome: 'Monitor 27"',
        preco: 1200.0,
        estoque: 3,
        descricao: 'Monitor Curvo QHD',
        categoria: 'Monitores',
      );

      await repository.salvarProduto(atualizado);
      produtos = await repository.listarProdutos();

      expect(produtos.last.nome, equals('Monitor 27"'));
      expect(produtos.last.preco, equals(1200.0));
    });

    test('Teste 4: Criar e listar Venda', () async {
      final produto = Produto(
        nome: 'Headset Gamer',
        preco: 300.0,
        estoque: 15,
        descricao: 'Headset com microfone embutido',
        categoria: 'Periféricos',
      );

      await repository.salvarProduto(produto);
      final produtos = await repository.listarProdutos();
      final idProduto = produtos.last.id!;

      final venda = Venda(
        idProduto: idProduto,
        quantidade: 2,
        valorTotal: 600.0,
        data: DateTime.now().toIso8601String(),
        cliente: 'Brunno',
      );

      await repository.salvarVenda(venda);
      final vendas = await repository.listarVendas();

      expect(vendas.isNotEmpty, true);
      expect(vendas.last.valorTotal, equals(600.0));
      expect(vendas.last.idProduto, equals(idProduto));
    });
  });
}