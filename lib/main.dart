import 'package:flutter/material.dart';
import 'package:todoo/popup.dart';
import 'package:todoo/todo_service.dart';
import 'package:todoo/todomodal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TODO APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _todoList = [];
  List _completetodo = [];

  final _todoservice = TodoService();
  int val = -1;
  getAllTodo() async {
    var todos = await _todoservice.readAllTodo();

    _todoList = <Todo>[];
    _completetodo = <Todo>[];
    todos.forEach((todo) {
      setState(() {
        var todoModal = Todo();
        todoModal.id = todo['id'];

        todoModal.name = todo['name'];

        todo['status'] == "completed"
            ? _completetodo.add(todoModal)
            : _todoList.add(todoModal);
      });
    });
  }

  passingToDo() {
    getAllTodo();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void initState() {
    getAllTodo();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              // color: Colors.green.shade100,
              child: Row(
                children: [
                  const Text(
                    'Active Todo',
                    style: TextStyle(
                        fontSize: 20,
                         fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  // var notcompleteTodo = _todoList.where((i) => i['completed'] == true).toList();

                  return Card(
                    // borderOnForeground: true,
                    margin: const EdgeInsets.only(left: 18, right: 18, top: 8),
                    color: Colors.grey.shade300,
                    child: ListTile(
                      title: Text(_todoList[index].name ?? ''),
                      leading: Radio(
                        value: index,
                        groupValue: val,
                        onChanged: (value) async {
                          // setState(() {

                          //    });
                          var _todo = Todo();
                          _todo.id = _todoList[index].id;
                          //  _todo.name=_todoList[index].name;
                          _todo.status = 'completed';

                          TodoService().updateTodo(_todo);

                          _showSuccessSnackBar('Todo Completed');
                          getAllTodo();
                        },
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                    elevation: 8,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.green.shade100,
                  );
                }),
            Container(
              margin: EdgeInsets.all(10),
              // color: Colors.green.shade100,
              child: Row(
                children: [
                  const Text(
                    'Completed Todo',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _completetodo.length,
                itemBuilder: (context, index) {
                  // var notcompleteTodo = _todoList.where((i) => i['completed'] == true).toList();

                  return Card(
                    // borderOnForeground: true,
                    margin: const EdgeInsets.only(left: 18, right: 18, top: 8),
                    color: Colors.grey.shade400,
                    child: ListTile(
                      title: Text(_completetodo[index].name ?? ''),
                      leading: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade800,
                        ),
                        onPressed: () {
                          var _todo = Todo();
                          _todo.id = _completetodo[index].id;
                          //  _todo.name=_todoList[index].name;
                          _todo.status = 'notcompleted';

                          TodoService().updateTodo(_todo);
                          getAllTodo();
                        },
                      ),
                    ),
                    elevation: 8,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.green.shade100,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: ((context, setState) {
                return PopUP(context, callback: () {
                  passingToDo();
                }, setStateFuncV: setState);
              }));
            },
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
