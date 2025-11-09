import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/produto_provider.dart';
import '../models/produto.dart';

class ProdutosListScreen extends StatefulWidget {
  const ProdutosListScreen({super.key});
  static const routeName = '/';

  @override
  State<ProdutosListScreen> createState() => _ProdutosListScreenState();
}

class _ProdutosListScreenState extends State<ProdutosListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProdutoProvider>(context, listen: false).loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProdutoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/vendas'),
            tooltip: 'Vendas',
          )
        ],
      ),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : prov.produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado'))
          : ListView.builder(
        itemCount: prov.produtos.length,
        itemBuilder: (ctx, i) {
          final Produto p = prov.produtos[i];
          return Dismissible(
            key: ValueKey(p.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) async {
              await prov.delete(p.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Produto "${p.nome}" excluído')),
              );
            },
            child: ListTile(
              title: Text(p.nome),
              subtitle: Text('${p.categoria} • R\$ ${p.preco.toStringAsFixed(2)} • Qtde: ${p.estoque}'),
              onTap: () => Navigator.pushNamed(context, '/produto_form', arguments: p.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/produto_form'),
      ),
    );
  }
}
