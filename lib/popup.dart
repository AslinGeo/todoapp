// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:todoo/todo_service.dart';
import 'package:todoo/todomodal.dart';


class PopUP extends StatefulWidget {
  PopUP(BuildContext context, {Key? key, this.callback, this.setStateFuncV})
      : super(key: key);
  Function? callback;
  Function? setStateFuncV;
  @override
  State<PopUP> createState() => _PopUPState();
}

class _PopUPState extends State<PopUP> {
 
  var _todoName = TextEditingController();
  var _todoStatus=TextEditingController();
  bool _validateTodoName = false;
  var _todoservice = TodoService();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: const Text('Enter Todo Data'),
    
      content: TextField(
        controller: _todoName,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Enter Todo',
          labelText: 'Todo',
          errorText: _validateTodoName ? 'Please Enter Value' : null,
        ),
      ),
      
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          textColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    _todoName.text.isEmpty
                        ? _validateTodoName = true
                        : _validateTodoName = false;
                  });
                  if (_validateTodoName == false) {
                    var _todo = Todo();
                    _todo.name = _todoName.text;
                    // _todo.status="notcompleted";

                    var result = await _todoservice.saveTodo(_todo);
                    widget.setStateFuncV!(() {
                      widget.callback!();
                    });
                    //  setState(() {

                    //  });
                    // print(result);4
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Apply'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
              ),
           
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
