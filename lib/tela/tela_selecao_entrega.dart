import 'package:flutter/material.dart';

class TelaSelecaoEntrega extends StatefulWidget {
  @override
  _TelaSelecaoEntregaState createState() => _TelaSelecaoEntregaState();
}

class _TelaSelecaoEntregaState extends State<TelaSelecaoEntrega> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  bool entregaSelecionada = false;
  bool retiradaSelecionada = false;

  void _mostrarMensagemDeSucesso(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Icon(Icons.check_circle,
              color: Colors.green, size: 48), // Ícone de check
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns! Seu pagamento foi efetuado com sucesso!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Você receberá um email com as informações do pagamento.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                _limparCampos();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _limparCampos() {
    _nomeController.clear();
    _enderecoController.clear();
    _telefoneController.clear();
  }

  bool _validarCampos() {
    return _nomeController.text.isNotEmpty &&
        _enderecoController.text.isNotEmpty &&
        _telefoneController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Seleção de Entrega'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Informe seus dados pessoais:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            SizedBox(height: 16),
            Text(
              'Selecione o método de entrega:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_validarCampos()) {
                  setState(() {
                    entregaSelecionada = true;
                    retiradaSelecionada = false;
                  });
                  _mostrarMensagemDeSucesso(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Campos obrigatórios'),
                        content: Text('Por favor, preencha todos os campos.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Color.fromARGB(255, 240, 238, 239), // Cor de fundo cinza
                onPrimary: Colors.black, // Cor do texto preto
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    entregaSelecionada
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                    color: entregaSelecionada ? Colors.green : null,
                  ), // Ícone de check
                  SizedBox(width: 8),
                  Text('Entrega: Receba no seu endereço'),
                ],
              ),
            ),
            SizedBox(height: 16), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                if (_validarCampos()) {
                  setState(() {
                    entregaSelecionada = false;
                    retiradaSelecionada = true;
                  });
                  _mostrarMensagemDeSucesso(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Campos obrigatórios'),
                        content: Text('Por favor, preencha todos os campos.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Color.fromARGB(255, 240, 238, 239), // Cor de fundo cinza
                onPrimary: Colors.black, // Cor do texto preto
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    retiradaSelecionada
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                    color: retiradaSelecionada ? Colors.green : null,
                  ), // Ícone de check
                  SizedBox(width: 8),
                  Text('Retirada: Retire em uma de nossas lojas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
