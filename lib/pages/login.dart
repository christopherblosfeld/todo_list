import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';
import '../models/todo.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final senhaKey = GlobalKey<FormFieldState>();
    final loginKey = GlobalKey<FormFieldState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text('Página de Login', textAlign: TextAlign.center),
          elevation: 5,
        ),
        body: Center(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  key: loginKey,
                  validator: _validaLogin,
                  controller: loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    hintText: 'Ex: joseph',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  validator: _validaSenha,
                  key: senhaKey,
                  controller: senhaController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (loginKey.currentState?.validate() == false) {
                        return;
                      }
                      if (senhaKey.currentState?.validate() == false) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Login concedido!!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      String login = loginController.text;
                      String senha = senhaController.text;
                      setState(() {
                        print('Entrou');
                        Navigator.push(
                            //Navegar para a página de login
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoListPage()));
                      });
                    },
                    child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validaLogin(String? login) {
    if (login == '') {
      return 'Informe um login!';
    } else if (login != 'christopher') {
      return 'Login inválido';
    }
  }

  String? _validaSenha(String? senha) {
    if (senha == '') {
      return 'Informe uma senha!';
    } else if (senha != 'dev1234') {
      return 'Senha inválida!';
    }
  }
}
