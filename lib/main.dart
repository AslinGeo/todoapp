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
   List _todoList=[];
  final _todoservice=TodoService();
  int val=-1;
  getAllTodo() async{
    var todos=await  _todoservice.readAllTodo();
   
    _todoList=<Todo>[];
    todos.forEach((todo){
       setState(() {
          var todoModal=Todo();
        todoModal.id=todo['id'];

        todoModal.name=todo['name'];
       
        _todoList.add(todoModal);
       });
    });
   

  }
  passingToDo(){
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
    setState(() {
      
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView.builder(itemCount: _todoList.length,itemBuilder: (context,index){
        
        return Card(
          
          color: Colors.white,
          child: ListTile(
           
            title: Text(_todoList[index].name ?? ''),
        
            leading: Radio(
              
                  value: index,
                  groupValue: val,
                  onChanged: (value) async{
                    // setState(() {
                         
                    //    });
                     
                    _todoList[index].status='completed';
                   
                      
                       _showSuccessSnackBar(
                           'Todo Completed');
                            getAllTodo();
                    // var result= await TodoService().deleteTodo(z);
                  
                    
                    //  if (result != null) {
                    //    setState(() {
                         
                    //    });
                     
                    //    getAllTodo();
                      
                    //    _showSuccessSnackBar(
                    //        'Todo Completed');
                    //  }
                  },
                  activeColor: Colors.blueAccent,
                ),
          ),
          elevation: 8,
          shadowColor: Colors.green.shade100,
          
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
         showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: ((context, setState) {
                return  PopUP(context,callback:(){passingToDo();},
                setStateFuncV:setState
                );
                }));
                 },
            );
      },
      backgroundColor: Colors.green.shade700,
      
      child:Icon(Icons.add,color: Colors.white,),
      ),
     
    );
  }
}
