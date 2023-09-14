import 'package:crtech/tela/tela_pix.dart';
import 'package:crtech/tela/tela_selecao_entrega.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crtech/produtos/produtos.dart';

class TelaDePagamento extends StatefulWidget {
  final List<Produtos> produtos;
  final double valorTotal;

  TelaDePagamento({required this.produtos, required this.valorTotal});

  @override
  _TelaDePagamentoState createState() => _TelaDePagamentoState();
}

class _TelaDePagamentoState extends State<TelaDePagamento> {
  String _selectedCardType = 'Visa';
  int _selectedInstallments = 1;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();

  TextStyle _defaultTextStyle({bool isBold = false}) {
    return TextStyle(
      fontSize: 18,
      fontFamily: 'Arial',
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: Colors.black, // Cor do texto preto
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
        backgroundColor: Colors.pink, // Cor de fundo rosa
      ),
      body: Container(
        color: Color.fromARGB(239, 238, 237, 237), // Cor de fundo cinza
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dados de pagamento',
              style: _defaultTextStyle(isBold: true),
            ),
            SizedBox(height: 26),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecione o tipo de cartão',
                  style: _defaultTextStyle(),
                ),
                DropdownButton<String>(
                  value: _selectedCardType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCardType = newValue ?? 'Visa';
                    });
                  },
                  items: <String>['Visa', 'MasterCard', 'Amex', 'Outro']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: _defaultTextStyle()),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número do Cartão',
                    labelStyle: _defaultTextStyle(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _expirationDateController,
                  decoration: InputDecoration(
                    labelText: 'Data de Expiração',
                    labelStyle: _defaultTextStyle(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _securityCodeController,
                  decoration: InputDecoration(
                    labelText: 'Código de Segurança',
                    labelStyle: _defaultTextStyle(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Selecione o número de parcelas',
                  style: _defaultTextStyle(),
                ),
                DropdownButton<int>(
                  value: _selectedInstallments,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedInstallments = newValue ?? 1;
                    });
                  },
                  items:
                      List.generate(12, (index) => index + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child:
                          Text('$value Parcelas', style: _defaultTextStyle()),
                    );
                  }).toList(),
                ),
                SizedBox(height: 200),
                Text(
                  'Valor Total: R\$ ${widget.valorTotal.toStringAsFixed(2)}',
                  style: _defaultTextStyle(),
                ),
                SizedBox(height: 16),
                Text(
                  'Parcelado em $_selectedInstallments parcela(s) de R\$ ${(widget.valorTotal / _selectedInstallments).toStringAsFixed(2)}',
                  style: _defaultTextStyle(),
                ),
                SizedBox(height: 16),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_validarCampos()) {
                    double valorParcela =
                        widget.valorTotal / _selectedInstallments;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Detalhes do Pagamento',
                            style: _defaultTextStyle(isBold: true),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Tipo de Cartão: $_selectedCardType',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Número do Cartão: ${_cardNumberController.text}',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Data de Expiração: ${_expirationDateController.text}',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Código de Segurança: ${_securityCodeController.text}',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Número de Parcelas: $_selectedInstallments',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Valor Total: R\$ ${widget.valorTotal.toStringAsFixed(2)}',
                                style: _defaultTextStyle(),
                              ),
                              Text(
                                'Valor de Cada Parcela: R\$ ${valorParcela.toStringAsFixed(2)}',
                                style: _defaultTextStyle(),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaSelecaoEntrega(),
                                  ),
                                );
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.pink, // Cor do botão rosa
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Campos obrigatórios',
                            style: _defaultTextStyle(isBold: true),
                          ),
                          content: Text(
                            'Por favor, preencha todos os campos.',
                            style: _defaultTextStyle(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: _defaultTextStyle(),
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
                  minimumSize: Size(200, 60), // Tamanho do botão
                ),
                child: Text(
                  'Finalizar Compra',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: Colors.black, // Cor do texto preto
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validarCampos() {
    return _selectedCardType.isNotEmpty &&
        _cardNumberController.text.isNotEmpty &&
        _expirationDateController.text.isNotEmpty &&
        _securityCodeController.text.isNotEmpty &&
        widget.valorTotal > 0.0;
  }
}
