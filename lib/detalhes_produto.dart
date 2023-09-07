import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:crtech/produtos/meus_produtos.dart';
import 'package:crtech/produtos/produtos.dart';

class DetalhesProdutoMaior extends StatefulWidget {
  final Produtos produto;

  DetalhesProdutoMaior({
    required this.produto,
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

    // Encontre produtos sugeridos com base na categoria do produto atual
    produtosSugeridos = MeusProdutos.todosProdutos
        .where((produto) =>
            produto.categoria == widget.produto.categoria &&
            produto != widget.produto) // Exclui o produto selecionado
        .toList();
  }

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
      appBar: AppBar(
        title: Text(widget.produto.nome),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.produto.imagem,
              width: 150,
              height: 150,
            ),
          ),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
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
          _comentarioEnviado
              ? SizedBox.shrink()
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
                        _enviarComentario();
                      },
                      child: Text('Enviar Comentário'),
                    ),
                  ],
                ),
          SizedBox(height: 20.0),
          Text(
            'Sugestões de Produtos',
            style: TextStyle(fontSize: 18),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: produtosSugeridos.length,
              itemBuilder: (context, index) {
                final produtoSugerido = produtosSugeridos[index];
                return GestureDetector(
                  onTap: () {
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
