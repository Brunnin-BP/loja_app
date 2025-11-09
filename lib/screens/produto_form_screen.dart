import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produto.dart';
import '../providers/produto_provider.dart';

class ProdutoFormScreen extends StatefulWidget {
  const ProdutoFormScreen({super.key});
  static const routeName = '/produto_form';

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _form = {};
  bool _isInit = true;
  Produto? _editing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final arg = ModalRoute.of(context)!.settings.arguments;
      if (arg != null && arg is int) {
        final prov = Provider.of<ProdutoProvider>(context, listen: false);
        _editing = prov.findById(arg);
        if (_editing != null) {
          _form['id'] = _editing!.id;
          _form['nome'] = _editing!.nome;
          _form['categoria'] = _editing!.categoria;
          _form['preco'] = _editing!.preco.toString();
          _form['estoque'] = _editing!.estoque.toString();
          _form['descricao'] = _editing!.descricao;
        }
      }
      _isInit = false;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final produto = Produto(
      id: _form['id'] as int?,
      nome: _form['nome'],
      categoria: _form['categoria'],
      preco: double.parse(_form['preco']),
      estoque: int.parse(_form['estoque']),
      descricao: _form['descricao'],
    );

    await Provider.of<ProdutoProvider>(context, listen: false).save(produto);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final title = _editing == null ? 'Novo Produto' : 'Editar Produto';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _form['nome'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => (v == null || v.isEmpty) ? 'Informe o nome' : null,
                onSaved: (v) => _form['nome'] = v!,
              ),
              TextFormField(
                initialValue: _form['categoria'],
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (v) => (v == null || v.isEmpty) ? 'Informe a categoria' : null,
                onSaved: (v) => _form['categoria'] = v!,
              ),
              TextFormField(
                initialValue: _form['preco'],
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o preço';
                  final n = double.tryParse(v.replaceAll(',', '.'));
                  if (n == null) return 'Preço inválido';
                  return null;
                },
                onSaved: (v) => _form['preco'] = v!.replaceAll(',', '.'),
              ),
              TextFormField(
                initialValue: _form['estoque'],
                decoration: const InputDecoration(labelText: 'Estoque'),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || int.tryParse(v) == null) ? 'Qtde inválida' : null,
                onSaved: (v) => _form['estoque'] = v!,
              ),
              TextFormField(
                initialValue: _form['descricao'],
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                onSaved: (v) => _form['descricao'] = v ?? '',
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _save, child: const Text('Salvar')),
              if (_editing != null)
                TextButton(
                  onPressed: () async {
                    await Provider.of<ProdutoProvider>(context, listen: false).delete(_editing!.id!);
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
