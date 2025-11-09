import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/venda_provider.dart';
import '../providers/produto_provider.dart';
import '../models/venda.dart';

class VendasListScreen extends StatefulWidget {
  const VendasListScreen({super.key});
  static const routeName = '/vendas';

  @override
  State<VendasListScreen> createState() => _VendasListScreenState();
}

class _VendasListScreenState extends State<VendasListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<VendaProvider>(context, listen: false).loadAll();
    Provider.of<ProdutoProvider>(context, listen: false).loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<VendaProvider>(context);
    final prodProv = Provider.of<ProdutoProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Vendas')),
      body: prov.loading
          ? const Center(child: CircularProgressIndicator())
          : prov.vendas.isEmpty
          ? const Center(child: Text('Nenhuma venda registrada'))
          : ListView.builder(
        itemCount: prov.vendas.length,
        itemBuilder: (ctx, i) {
          final Venda v = prov.vendas[i];
          final produto = prodProv.findById(v.idProduto);
          final produtoNome = produto?.nome ?? 'Produto #${v.idProduto}';
          return Dismissible(
            key: ValueKey(v.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) async {
              await prov.delete(v.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Venda excluída')),
              );
            },
            child: ListTile(
              title: Text(produtoNome),
              subtitle: Text('Cliente: ${v.cliente} • R\$ ${v.valorTotal.toStringAsFixed(2)}'),
              onTap: () => Navigator.pushNamed(context, '/venda_form', arguments: v.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/venda_form'),
      ),
    );
  }
}
