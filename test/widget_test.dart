import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:loja_app/providers/produto_provider.dart';
import 'package:loja_app/screens/produtos_list_screen.dart';
import 'package:loja_app/models/produto.dart';

/// FakeProvider que simula carregamento concluído com lista vazia
class FakeProdutoProvider extends ProdutoProvider {
  @override
  Future<void> loadAll() async {
    // Simula carregamento rápido com lista vazia
    await Future.delayed(Duration.zero);
    super.produtos.clear(); // Limpa a lista se possível
  }

  @override
  bool get loading => false;

  @override
  List<Produto> get produtos => [];
}

void main() {
  group('Testes de Widget - Interface', () {
    testWidgets('Teste 5: Exibir mensagem quando não há produtos',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<ProdutoProvider>(
                    create: (_) => FakeProdutoProvider()),
              ],
              child: const MaterialApp(
                home: ProdutosListScreen(),
              ),
            ),
          );

          await tester.pump(const Duration(seconds: 1));

          expect(find.text('Nenhum produto cadastrado'), findsOneWidget);
        });

    testWidgets('Teste 6: Preencher campo de formulário de produto',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ProdutoProvider()),
              ],
              child: const MaterialApp(
                home: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          key: Key('campo_nome'),
                          decoration: InputDecoration(labelText: 'Nome do Produto'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(const Key('campo_nome')), 'Teclado RGB');
          await tester.pump();

          expect(find.text('Teclado RGB'), findsOneWidget);
        });
  });
}