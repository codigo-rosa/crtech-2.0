import 'package:crtech/produtos/categorias_produtos.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/produtos/meus_produtos.dart';

class DetalhesProdutoMaior extends StatefulWidget {
  final Produtos produto;
  // final List<Produtos> todosProdutos;

  DetalhesProdutoMaior({
    required this.produto,
    // required this.todosProdutos,
  });

  @override
  _DetalhesProdutoMaiorState createState() => _DetalhesProdutoMaiorState();
}

class _DetalhesProdutoMaiorState extends State<DetalhesProdutoMaior> {
  double _rating = 0.0;
  TextEditingController _commentController = TextEditingController();
  bool _comentarioEnviado = false;
  List<Produtos> produtosSugeridos = [];

  @override
  void initState() {
    super.initState();

    // Encontre produtos relacionados com base no ID do produto atual
    produtosSugeridos = MeusProdutos.todosProdutos
        .where((produto) => produto.categoria == widget.produto.categoria &&
        produto != widget.produto)
        .toList();
  }

  @override
  void _enviarComentario() {
    final comentario = _commentController.text;
    print('Comentário enviado pelo cliente: $comentario');
    setState(() {
      _comentarioEnviado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 242, 241, 241),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  widget.produto.imagem,
                  width: MediaQuery.of(context).size.width -
                      32, // Defina o tamanho desejado
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 35.0),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome: ${widget.produto.nome}'),
                    Text(
                        'Preço: R\$ ${widget.produto.preco.toStringAsFixed(2)}'),
                    Text('Descrição: ${widget.produto.descricao}'),
                    const SizedBox(height: 7.0),
                    // Ícone de estrela com estatísticas das avaliações
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Espaço para sugestões de produtos
            const SizedBox(height: 20.0),
            Text(
              'Sugestões de Produtos',
              style: TextStyle(fontSize: 18),
            ),
            // Lista de produtos sugeridos
            Container(
              height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: produtosSugeridos.length,
              itemBuilder: (context, index) {
                final produtoSugerido = produtosSugeridos[index];
                return GestureDetector(
                  onTap: () {
                    // Navegue para a página de detalhes deste produto
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesProdutoMaior(
                          produto: produtoSugerido,
                         ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          produtoSugerido.imagem,
                          width: 50,
                          height: 50,
                        ),
                        Text(produtoSugerido.nome),
                     ],
                    ),
                  ),
                );
              },
            ),
          ),
               SizedBox(height: 7.0),
             // Espaço para comentário
             Container(
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.white,
               ),
               child: _comentarioEnviado
                   ? const SizedBox
                       .shrink() // Oculta o espaço do comentário após o envio
                   : Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(bottom: 8.0),
                             child: const Text(
                               'Avalie este produto',
                                style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: 'roboto',
                               ),
                             ),
                           ),
                           const Text(
                             'Compartilhe seus pensamentos com outros clientes',
                             style: TextStyle(
                               fontWeight: FontWeight.normal,
                             ),
                           ),
                           TextField(
                             controller: _commentController,
                             decoration: InputDecoration(
                               labelText: 'Comentário',
                               border: InputBorder.none,
                             ),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               _enviarComentario();  //Chama o método para enviar o comentário
                             },
                             child: Text('Enviar Comentário'),
                           ),
                         ],
                       ),
                     ),


             ),
          ],
      ),
    ),
    );

  }

            
            // ),
    //       ],
    //     ),
    //   ),
    // );

    @override
    void dispose() {
      _commentController.dispose();
      super.dispose();
    }
  }

