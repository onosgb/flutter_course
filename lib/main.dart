import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

final List<Todo> _todoList = [
  Todo('Paint House', 'Paint it black'),
  Todo('Pet the dog', 'Use combo to brush as well')
];

void main() => runApp(MaterialApp(home: TodosScreen(todos: _todoList)));

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  State<TodosScreen> createState() => _TodosScreen();
}

class _TodosScreen extends State<TodosScreen> {
  // using the alert method
  void _addTask() async {
    final Todo? result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController titleController = TextEditingController();
          TextEditingController descriptionController = TextEditingController();

          return AlertDialog(
            title: const Text('Add task'),
            content: SizedBox(
                height: 120,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    )
                  ],
                )),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final String title = titleController.text;
                    final String description = descriptionController.text;
                    if (title.isNotEmpty && description.isNotEmpty) {
                      Navigator.pop(context, Todo(title, description));
                    }
                  },
                  child: const Text('Save'))
            ],
          );
        });

    if (result != null) {
      setState(() {
        _todoList.add(Todo(result.title, result.description));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = _todoList[index];
          return ListTile(
            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(todo: todo)));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(todo.title)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(todo.description),
        ));
  }
}

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Task Form')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Enter title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Enter Description'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final String title = titleController.text;
                    final String description = descriptionController.text;
                    if (title.isNotEmpty && description.isNotEmpty) {
                      Navigator.pop(context, Todo(title, description));
                    }
                  },
                  child: const Text('Save'))
            ])
          ],
        ));
  }
}