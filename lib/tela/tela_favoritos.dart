import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/barra_inferior.dart';
import 'package:provider/provider.dart';
import 'package:crtech/favoritos_provider.dart';

class TelaFavoritos extends StatefulWidget {
  final List<Produtos> favoritos;

  const TelaFavoritos({Key? key, required this.favoritos}) : super(key: key);

  @override
  TelaFavoritosState createState() => TelaFavoritosState();
}

class TelaFavoritosState extends State<TelaFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favoritos'),
          backgroundColor: Colors.pink,
        ),
        backgroundColor: Color.fromARGB(239, 238, 237, 237),
        body: widget.favoritos.isEmpty
            ? Center(
                child: Text(
                  'Adicione seus produtos favoritos aqui!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: widget.favoritos.length,
                itemBuilder: (context, index) {
                  final produto = widget.favoritos[index];
                  
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16), // Espaçamento externo do contêiner
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo do contêiner
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Image.asset(produto.imagem),
                      title: Text(produto.nome),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preço: R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(produto.preco)}\nDescrição: ${produto.descricao}',
                          )
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.favorite,
                              color: Color.fromARGB(255, 231, 130, 164),
                              ),
                              onPressed: () {
                                setState(() {
                                widget.favoritos.removeAt(index);
                                });
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
