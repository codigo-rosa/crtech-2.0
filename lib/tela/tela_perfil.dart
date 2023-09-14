import 'package:crtech/main.dart';
import 'package:flutter/material.dart';
import 'package:crtech/tela/carrrossel.dart';

class TelaPerfil extends StatefulWidget {
  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  // Declaração dos controladores para os campos de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Retornar para página inicial'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(253, 207, 230, 1),
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('logo/logo.jpg'),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Fique por dentro das novidades e promoções!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: senhaController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showPassword = !_showPassword;
                          // Redesenha o widget para atualizar o campo de senha
                          setState(() {});
                        },
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Lógica para redefinir a senha
                      // Você pode adicionar a lógica de redefinição de senha aqui
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Esqueceu sua senha?'),
                            content: Text(
                              'Enviamos um email com instruções para redefinir sua senha.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Obtém os valores dos campos
                      String nome = nomeController.text;
                      String email = emailController.text;

                      // Chama o método para enviar os dados
                      enviarDados(nome, email);

                      // Limpa os campos
                      nomeController.clear();
                      emailController.clear();
                      senhaController.clear();

                      // Navega para a página principal
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Aplicativo()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 240, 238, 239), // Cor de fundo cinza
                      onPrimary: Colors.black, // Cor do texto preto
                    ),
                    child: const Text(
                      'Iniciar Sessão',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('COMUNICADO'),
                      content: Text(
                        'Nosso atendimento via WhatsApp está temporariamente fora do ar.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.phone),
            ),
          ),
        ],
      ),
    );
  }

  void enviarDados(String nome, String email) {
    // Lógica para enviar os dados para o console
    print('Nome: $nome');
    print('Email: $email');
  }
}
