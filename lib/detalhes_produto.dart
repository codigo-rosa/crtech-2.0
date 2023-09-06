import 'package:crtech/produtos/produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/produtos/meus_produtos.dart';

class DetalhesProdutoMaior extends StatefulWidget {
  final Produtos produto;
  final List<Produtos> todosProdutos;

  DetalhesProdutoMaior({
    required this.produto,
    required this.todosProdutos,
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
    produtosSugeridos = widget.todosProdutos
        .where((produto) => produto.id != widget.produto.id)
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
      backgroundColor: Color.fromARGB(104, 231, 231, 231),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.0),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  widget.produto.imagem,
                  width: MediaQuery.of(context).size.width -32, // Defina o tamanho desejado
                  height: 150,
                ),
              ),
            ),
             const SizedBox(height: 35.0),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.0),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome: ${widget.produto.nome}'),
                    Text('Preço: R\$ ${widget.produto.preco.toStringAsFixed(2)}'),
                    Text('Descrição: ${widget.produto.descricao}'),
                  SizedBox(height: 7.0),
                    // Ícone de estrela para avaliação
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
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
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.0),
            //         spreadRadius: 3,
            //         blurRadius: 5,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
             
            // ),




             // Espaço para comentário
                    _comentarioEnviado
                        ? SizedBox
                            .shrink() // Oculta o espaço do comentário após o envio
                        : Column(
                            children: [
                              TextField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  labelText: 'Comentário',
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _enviarComentario(); // Chama o método para enviar o comentário
                                },
                                child: Text('Enviar Comentário'),
                              ),
                            ],
                          ),


            // Espaço para sugestões de produtos
            SizedBox(height: 20.0),
            Text(
              'Sugestões de Produtos',
              style: TextStyle(fontSize: 18),
            ),
            // Lista de produtos sugeridos
            Column(
              children: produtosSugeridos.map((produto) {
                return ListTile(
                  leading: Image.asset(
                    produto.imagem,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(produto.nome),
                  onTap: () {
                    // Navegue para a página de detalhes deste produto
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetalhesProdutoMaior(
                          produto: produto,
                          todosProdutos: widget.todosProdutos,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    
    );

    @override
    void dispose() {
      _commentController.dispose();
      super.dispose();
    }
  }
}
