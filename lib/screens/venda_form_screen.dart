import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/venda.dart';
import '../models/produto.dart';
import '../providers/venda_provider.dart';
import '../providers/produto_provider.dart';

class VendaFormScreen extends StatefulWidget {
  const VendaFormScreen({super.key});
  static const routeName = '/venda_form';

  @override
  State<VendaFormScreen> createState() => _VendaFormScreenState();
}

class _VendaFormScreenState extends State<VendaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isInit = true;
  Venda? _editing;
  int? _selectedProdutoId;
  final Map<String, dynamic> _form = {
    'quantidade': '1',
    'cliente': '',
    'data': DateTime.now().toIso8601String(),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final arg = ModalRoute.of(context)!.settings.arguments;
      final prodProv = Provider.of<ProdutoProvider>(context, listen: false);
      prodProv.loadAll();
      if (arg != null && arg is int) {
        // carregar venda existente
        final vendaProv = Provider.of<VendaProvider>(context, listen: false);
        vendaProv.loadAll().then((_) {
          final v = vendaProv.vendas.firstWhere((e) => e.id == arg, orElse: () => null as Venda);
          if (v != null) {
            setState(() {
              _editing = v;
              _selectedProdutoId = v.idProduto;
              _form['quantidade'] = v.quantidade.toString();
              _form['cliente'] = v.cliente;
              _form['data'] = v.data;
            });
          }
        });
      }
      _isInit = false;
    }
  }

  double _calculateTotal(Produto? produto) {
    if (produto == null) return 0.0;
    final q = int.tryParse(_form['quantidade'] ?? '1') ?? 1;
    return produto.preco * q;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (_selectedProdutoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione um produto')));
      return;
    }
    final quantidade = int.parse(_form['quantidade']);
    final prodProv = Provider.of<ProdutoProvider>(context, listen: false);
    final produto = prodProv.findById(_selectedProdutoId!);
    final valorTotal = (produto?.preco ?? 0.0) * quantidade;

    final venda = Venda(
      id: _form['id'] as int?,
      idProduto: _selectedProdutoId!,
      quantidade: quantidade,
      valorTotal: valorTotal,
      data: _form['data'],
      cliente: _form['cliente'],
    );

    await Provider.of<VendaProvider>(context, listen: false).save(venda);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final prodProv = Provider.of<ProdutoProvider>(context);
    final produtos = prodProv.produtos;
    final Produto? selectedProduto = _selectedProdutoId != null ? prodProv.findById(_selectedProdutoId!) : null;

    return Scaffold(
      appBar: AppBar(title: Text(_editing == null ? 'Nova Venda' : 'Editar Venda')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: _selectedProdutoId,
                decoration: const InputDecoration(labelText: 'Produto'),
                items: produtos.map((p) => DropdownMenuItem(value: p.id, child: Text('${p.nome} — R\$ ${p.preco.toStringAsFixed(2)}'))).toList(),
                onChanged: (v) {
                  setState(() {
                    _selectedProdutoId = v;
                  });
                },
                validator: (v) => v == null ? 'Selecione um produto' : null,
              ),
              TextFormField(
                initialValue: _form['quantidade'],
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || int.tryParse(v) == null || int.parse(v) <= 0) ? 'Informe quantidade válida' : null,
                onSaved: (v) => _form['quantidade'] = v!,
              ),
              TextFormField(
                initialValue: _form['cliente'],
                decoration: const InputDecoration(labelText: 'Cliente'),
                validator: (v) => (v == null || v.isEmpty) ? 'Informe o cliente' : null,
                onSaved: (v) => _form['cliente'] = v!,
              ),
              const SizedBox(height: 12),
              Text('Total: R\$ ${_calculateTotal(selectedProduto).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _save, child: const Text('Salvar')),
              if (_editing != null)
                TextButton(
                  onPressed: () async {
                    await Provider.of<VendaProvider>(context, listen: false).delete(_editing!.id!);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
