import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela_selecao_entrega.dart'; // Importe a classe TelaSelecaoEntrega

class TelaPIX extends StatefulWidget {
  @override
  _TelaPIXState createState() => _TelaPIXState();
}

class _TelaPIXState extends State<TelaPIX> {
  String chavePix = 'pix@codigo-rosa.com.br'; // Sua chave PIX

  void _mostrarMensagemDeSucesso(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Parabéns!'),
          content: Text('Seu pagamento foi efetuado com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                // Navegar para a página de seleção de formas de entrega
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaSelecaoEntrega(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _copiarChavePix(BuildContext context) {
    Clipboard.setData(ClipboardData(text: chavePix));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Código copiado!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento com PIX'),
        backgroundColor: Colors.pink, // Defina a cor desejada (rosa)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto "QRCODE"
          Text(
            'QRCODE:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Imagem
          Center(
            // Centralize a imagem
            child: Image.asset(
              'assets/qrcode.png', // Substitua pelo caminho da sua imagem PIX
              width: 770,
              height: 130,
            ),
          ),
          SizedBox(
              height: 2), // Espaçamento entre a imagem e o texto "CHAVE PIX:"
          // Texto "CHAVE PIX:"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHAVE PIX:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8), // Espaçamento
              Text(
                chavePix,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink, // Cor rosa para a chave PIX
                ),
              ),
            ],
          ),
          SizedBox(height: 30), // Espaçamento entre o texto e o botão
          // Botão "Copiar chave"
          ElevatedButton(
            onPressed: () {
              _copiarChavePix(context); // Copiar chave PIX
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 240, 238, 239),
            ),
            child: Text(
              'Copiar chave',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
