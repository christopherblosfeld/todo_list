import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[200],
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(DateFormat('dd/MM/yyyy - HH:mm:ss').format(todo.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                  )),
              Text(todo.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
              IconButton(
                  onPressed: () {
                    onDelete(todo);
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ));
  }
}

//void setState(Null Function() param0) {}
