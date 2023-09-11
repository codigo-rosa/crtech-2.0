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
          title: Icon(Icons.check_circle, color: Colors.green, size: 48),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns! Sua seleção de entrega foi concluída!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Você receberá informações sobre a entrega em breve.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _limparCampos();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.pink, // Cor do texto
                ),
              ),
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
      body: Container(
        color: Color.fromARGB(255, 240, 238, 239),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informe seus dados pessoais:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 23),
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
              SizedBox(height: 30),
              Text(
                'Selecione o método de entrega:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
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
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.pink, // Cor do texto
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromARGB(240, 223, 221, 221), // Cor de fundo cinza
                  onPrimary: Colors.white, // Cor do texto branco
                  minimumSize: Size(150, 60), // Tamanho do botão
                ),
                child: Text(
                  'Receba em casa',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Tamanho da fonte
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.pink, // Cor do texto
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromARGB(240, 223, 221, 221), // Cor de fundo cinza
                  onPrimary: Colors.white, // Cor do texto branco
                  minimumSize: Size(300, 60), // Tamanho do botão
                ),
                child: Text(
                  'Retire em nossas lojas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Tamanho da fonte
                    color: Colors.black, // Cor do texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
