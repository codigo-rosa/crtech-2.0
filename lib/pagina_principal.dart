import 'package:crtech/detalhes_produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crtech/appBar.dart';
import 'package:crtech/barra_inferior.dart';
import 'package:crtech/produtos/meus_produtos.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/tela/carrrossel.dart';
import 'package:crtech/tela/tela_carrinho.dart';

class PaginaPrincipal extends StatefulWidget {
  final List<Produtos> carrinho;

  const PaginaPrincipal({Key? key, required this.carrinho}) : super(key: key);

  @override
  _EstadoPaginaPrincipal createState() => _EstadoPaginaPrincipal();
}

class _EstadoPaginaPrincipal extends State<PaginaPrincipal> {
  int isSelected = 0;
  List<bool> favoritos = List.filled(MeusProdutos.todosProdutos.length, false);
  String searchText = "";
  List<Produtos> listaDeProdutos = MeusProdutos.todosProdutos;
  List<Produtos> carrinho = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onCartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaCarrinho(carrinho: carrinho),
            ),
          );
        },
        onSearchChanged: (text) {
          setState(() {
            searchText = text;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: Column(
          children: [
            Carrossel(), // Adicione o carrossel aqui
            construirCategoriasDeProdutos(),
            Expanded(
              child: construirProdutosExibidos(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onTabSelected: (index) {
          setState(() {
            isSelected = index;
          });
        },
        selectedIndex: isSelected,
        favoritos: favoritos,
      ),
    );
  }

  Widget construirCardDeProdutos(Produtos produtos, int index, int id) {
    double _rating = 0.0;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Ícone de coração para favoritar
              IconButton(
                iconSize: 18.5, // Tamanho do ícone
                icon: Icon(
                  favoritos[index] ? Icons.favorite : Icons.favorite_border,
                  color: Color.fromARGB(255, 231, 130, 164),
                ),
                onPressed: () {
                  setState(() {
                    favoritos[index] = !favoritos[index];
                  });
                },
              ),
              // Ícone de carrinho para adicionar ao carrinho
              IconButton(
                iconSize: 18.5, // Tamanho do ícone
                icon: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.black, // Cor do ícone de carrinho
                ),
                onPressed: () {
                  setState(() {
                    carrinho.add(produtos);
                  });
                  mostrarModalConfirmacao(context);
                },
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesProdutoMaior(
                      produto: produtos,
                      todosProdutos: [],
                    ),
                  ),
                );
              },
              child: Image.asset(
                produtos.imagem,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              produtos.descricao,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Text(
                  'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(produtos.preco)}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3),
                const Text(
                  'À vista ou em até 10x no cartão',
                  style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 11,
                    color: Color.fromARGB(255, 102, 102, 102),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void mostrarModalConfirmacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Produto adicionado ao carrinho.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget construirCategoriasDeProdutos() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            construirCategoriaDeProdutos(index: 0, nome: "Ver tudo"),
            construirCategoriaDeProdutos(index: 1, nome: "Gamer"),
            construirCategoriaDeProdutos(index: 2, nome: "Rede"),
            construirCategoriaDeProdutos(index: 3, nome: "Hardware"),
          ],
        ),
      ),
    );
  }

  Widget construirCategoriaDeProdutos({
    required int index,
    required String nome,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = index;
          searchText = "";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          nome,
          style: TextStyle(
            color: isSelected == index ? Colors.white : Colors.pink,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget construirProdutosExibidos() {
    List<Produtos> produtosExibidos;

    produtosExibidos = listaDeProdutos.where((produto) {
      return produto.descricao.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    if (isSelected == 1) {
      produtosExibidos = produtosExibidos.where((produto) {
        return MeusProdutos.listaGamer.contains(produto);
      }).toList();
    } else if (isSelected == 2) {
      produtosExibidos = produtosExibidos.where((produto) {
        return MeusProdutos.listaDeRede.contains(produto);
      }).toList();
    } else if (isSelected == 3) {
      produtosExibidos = produtosExibidos.where((produto) {
        return MeusProdutos.listaDeHardware.contains(produto);
      }).toList();
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      itemCount: produtosExibidos.length,
      itemBuilder: (context, index) {
        final produtos = produtosExibidos[index];
        return construirCardDeProdutos(produtos, index, produtos.id);
      },
    );
  }
}
