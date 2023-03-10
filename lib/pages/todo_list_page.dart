import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repositories.dart';
import '../models/todo.dart';
import '../widgets/todo_list_item.dart';
import 'login.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todoList = [];

  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  void initState() {
    super
        .initState(); //Ao recarregar a tela de TodolistPage, iniciamos o estado do app com a lista que estava salva no todoRepository.

    todoRepository.getTodoList().then((value) {
      setState(() {
        todoList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final formKey = GlobalKey<FormState>();
    final tarefaKey = GlobalKey<FormFieldState>();
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Sobre o Aplicativo'),
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            print('teste');
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Notas da Vers??o'),
                      IconButton(
                        icon: Icon(Icons.telegram),
                        onPressed: () {
                          setState(() {
                            print('Voc?? clicou em notas da vers??o !!');
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Fale com o desenvolvedor'),
                      IconButton(
                        icon: Icon(Icons.telegram),
                        onPressed: () {
                          setState(() {
                            print('Lorem Ipsulum.climber !!');
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 5,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Lista de Tarefas',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 5),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    print('teste');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('You is my Fan?'),
                      duration: const Duration(seconds: 1),
                    ));
                    Navigator.push(
                        //Navegar para a p??gina de login
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  });
                },
              )
            ],
            backgroundColor: Colors.blue,
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                              maxLength: 15,
                              key: tarefaKey,
                              validator: _validaTarefa,
                              controller: todoController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Adicionar uma tarefa',
                                hintText: 'Ex> Corrida 1km',
                              )),
                        ),
                        SizedBox(width: 8), //Caixa Vazia para separar.

                        ElevatedButton(
                          //Bot??o de +

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            //fixedSize: Size(50, 50),
                          ),
                          onPressed: () async {
                            if (tarefaKey.currentState?.validate() == false) {
                              return;
                            }
                            String text = todoController.text;
                            setState(() {
                              //Setando a mudan??a de estado da tela ao pressionar o bot??o de +
                              Todo newTodo = Todo(
                                title: text,
                                dateTime: DateTime.now(),
                              );
                              todoList.add(newTodo);
                            });
                            todoController
                                .clear(); //Limpar o campo de Texto ap??s inserir um novo registro
                            todoRepository.saveTodoList(todoList);
                          },
                          child: Text('+', style: TextStyle(fontSize: 30)),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Flexible(
                      child: ListView(
                        shrinkWrap:
                            true, //par??metro que define a responsividade da lista, ela cresce conforme o tamanho ou quantidade de componentes
                        children: [
                          for (Todo todo
                              in todoList) //Para cada String todo na lista de tarefas todoList eu adiciono um item na lista.
                            TodoListItem(
                              todo: todo,
                              onDelete: onDelete,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              'Voc?? possui ${todoList.length} tarefa(s) pendentes'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todoList.clear();
                              todoRepository.saveTodoList(todoList);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(14)),
                          child: Text('Limpar tudo'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  String? _validaTarefa(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a tarefa!';
    }
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todoList.indexOf(todo);

    setState(() {
      todoList
          .remove(todo); //Remover um item da Lista ao clicar no botao delete.
    });
    todoRepository.saveTodoList(todoList);
  }
}
