import 'package:crtech/produtos/produtos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<Produtos> _favoritos = [];
  List<Produtos> get favoritos => _favoritos;

  void adicionarFavorito(Produtos produto) {
    if (!_favoritos.contains(produto)) {
      _favoritos.remove(produto);
    } else {
      _favoritos.add(produto);
    }

    notifyListeners();
  }

  void removerFavorito(Produtos produto) {
    if (_favoritos.contains(produto)) {
      _favoritos.remove(produto);
      notifyListeners();
    }
  }

  bool isFavorito(Produtos produto) {
    return _favoritos.contains(produto);
  }

  static FavoritosProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoritosProvider>(
      context,
      listen: listen,
    );
  }
}
