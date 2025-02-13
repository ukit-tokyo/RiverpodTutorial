import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

class Todo {
  final String description;
  final bool completed;

  Todo({
    required this.description,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'completed': completed,
    };
  }
}

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    return [
      Todo(description: 'Learn Flutter', completed: true),
      Todo(description: 'Learn Riverpod'),
    ];
  }

  Future<void> addTodo(Todo todo) async {
    // final response = await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //   // We serialize our Todo object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(todo.toJson()),
    // );

    // List<Todo> newTodos = (jsonDecode(response.body) as List)
    //     .cast<Map<String, Object?>>()
    //     .map(Todo.fromJson)
    //     .toList();

    // state = AsyncData(newTodos);

    // final response = todo;

    // List<Todo> newTodos = [
    //   Todo(description: 'Learn Flutter', completed: true),
    //   Todo(description: 'Learn Riverpod'),
    // ];
    // newTodos.add(response);

    // state = AsyncData(newTodos);

    await Future.delayed(const Duration(seconds: 2));

    final prevState = await future;
    state = AsyncData([...prevState, todo]);
  }
}

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Todo>> todos = ref.watch(todoListProvider);

    return Column(
      children: [
        for (final todo in todos.value ?? [])
          ListTile(
            title: Text(todo.description),
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                // ref.read(todoListProvider.notifier).toggle(todo);
              },
            ),
          ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(todoListProvider.notifier)
                .addTodo(Todo(description: 'This is a new todo'));
          },
          child: const Text('Add todo'),
        ),
      ],
    );
  }
}
