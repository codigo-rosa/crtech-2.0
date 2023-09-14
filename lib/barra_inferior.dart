import 'package:crtech/avaliacao_cliente.dart';
import 'package:crtech/produtos/produtos.dart';
import 'package:crtech/tela/tela_perfil.dart';
import 'package:crtech/tela/tela_favoritos.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;
  final List<Produtos> favoritos;

  CustomBottomAppBar({
    required this.onTabSelected,
    required this.selectedIndex,
    required this.favoritos,
  });

  // Método para abrir a página de favoritos
  void _openFavoritesPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaFavoritos(favoritos: favoritos),
        ),
        );
  }

// Método para abrir a página de perfil
  void _openProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPerfil(),
      ),
    );
  }

  // Método para abrir a página de avaliação do cliente
  // void _openAvaliacaoClientePage(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AvaliacaoClientePage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Color.fromARGB(239, 238, 237, 237),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () => onTabSelected(0),
              color: Colors.pink),
          IconButton(
              icon: Icon(Icons.favorite), // Ícone de coração
              onPressed: () =>
                  _openFavoritesPage(context), // Abre a página de favoritos
              color: Colors.pink),
          IconButton(
              icon: Icon(Icons.person), // Ícone de perfil do usuário
              onPressed: () =>
                  _openProfilePage(context), // Abre a página de perfil
              color: Colors
                  .pink // Altere o ícone ativo/inativo conforme necessário
              ),
        ],
      ),
    );
  }
}
