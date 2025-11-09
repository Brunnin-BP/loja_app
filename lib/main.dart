import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/produtos_list_screen.dart';
import 'screens/produto_form_screen.dart';
import 'screens/vendas_list_screen.dart';
import 'screens/venda_form_screen.dart';
import 'providers/produto_provider.dart';
import 'providers/venda_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LojaApp());
}

class LojaApp extends StatelessWidget {
  const LojaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdutoProvider()),
        ChangeNotifierProvider(create: (_) => VendaProvider()),
      ],
      child: MaterialApp(
        title: 'Loja App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: ProdutosListScreen.routeName,
        routes: {
          ProdutosListScreen.routeName: (_) => const ProdutosListScreen(),
          ProdutoFormScreen.routeName: (_) => const ProdutoFormScreen(),
          VendasListScreen.routeName: (_) => const VendasListScreen(),
          VendaFormScreen.routeName: (_) => const VendaFormScreen(),
        },
      ),
    );
  }
}
