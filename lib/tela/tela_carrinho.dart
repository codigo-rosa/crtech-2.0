import 'package:crtech/tela/tela_pix.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/tela/pagamento.dart';

class TelaCarrinho extends StatefulWidget {
  final List<Produtos> carrinho;

  const TelaCarrinho({Key? key, required this.carrinho}) : super(key: key);

  @override
  TelaCarrinhoState createState() => TelaCarrinhoState();
}

class TelaCarrinhoState extends State<TelaCarrinho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        backgroundColor: Colors.pink,
      ),
      body: widget.carrinho.isEmpty
          ? Center(
              child: Text(
                'Seu carrinho está vazio!',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: widget.carrinho.length,
              itemBuilder: (context, index) {
                final produto = widget.carrinho[index];
                return ListTile(
                  leading: Image.asset(produto.imagem),
                  title: Text(produto.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Preço: R\$ ${produto.preco}'),
                      Text('Descrição: ${produto.descricao}'),
                      Text('Quantidade: ${produto.quantidade}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.carrinho.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (widget.carrinho.isEmpty) {
                Navigator.popUntil(context, (route) => route.isFirst);
              } else {
                // Navegue para a tela de pagamento ao clicar em "Comprar"
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TelaDePagamento(
                      produtos: widget.carrinho,
                      valorTotal: calcularTotalCarrinho(widget.carrinho),
                    ),
                  ),
                );
              }
            },
            child: Icon(
              Icons.payment,
              color: Colors.black, // Define a cor do ícone como preto
            ),
            backgroundColor:
                Color.fromARGB(255, 240, 238, 239), // Cor de fundo cinza
          ),
          SizedBox(height: 16), // Espaço entre os botões
          FloatingActionButton(
            onPressed: () {
              // Navegue para a tela PIX ao clicar no botão "PIX"
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TelaPIX(),
                ),
              );
            },
            child: Icon(
              Icons.qr_code, // Ícone PIX (use o ícone desejado)
              color: Colors.black, // Cor do ícone (preto)
            ),
            backgroundColor:
                Color.fromARGB(255, 240, 238, 239), // Cor de fundo cinza
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total: R\$${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(calcularTotalCarrinho(widget.carrinho))}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  double calcularTotalCarrinho(List<Produtos> carrinho) {
    double total = 0.0;
    for (var produto in carrinho) {
      total += produto.preco * produto.quantidade;
    }
    return total;
  }
}
