import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';
import 'dart:convert';

const todoListKey = 'todo_list';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(
            todoListKey) ?? //Semelhante a um IF, SE for nulo, retorne uma lista vazia.
        '[]'; //A função dos colchetes é retornar uma lista vazia, caso ainda não tenha nada armazenado na lista anterior.
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todoList) {
    final String jsonString = json.encode(todoList);
    sharedPreferences.setString(todoListKey, jsonString);
  }
}
