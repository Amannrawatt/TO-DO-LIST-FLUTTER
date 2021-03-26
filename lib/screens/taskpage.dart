import 'package:flutter/material.dart';
import 'package:todo_list_app/database_file.dart';
import 'package:todo_list_app/models/task.dart';
import 'package:todo_list_app/models/todo.dart';
import 'package:todo_list_app/widgets.dart';
class Taskpage extends StatefulWidget {
  final Task task;
  Taskpage({@required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId = 0;

  String _taskTitle= "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;
  bool _contentvisible = false;
  @override
  void initState() {
   if(widget.task != null){
     _taskTitle = widget.task.title;
     _taskId= widget.task.id;
   }
   _titleFocus = FocusNode();
   _descriptionFocus = FocusNode();
   _todoFocus = FocusNode();

    super.initState();
  }
   @override
  void dispose() {
    // TODO: implement dispose
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
         child: Stack(
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: EdgeInsets.symmetric(
                 vertical: 17.0,
             ),
                   child: Row(
                     children: [

                       GestureDetector(
                         onTap: () {
                           Navigator.pop(context);
                         },
                         child: Padding(
                           padding: EdgeInsets.all(17.0),
                           child: Icon(Icons.arrow_back,
                           size: 30.0,
                           color: Colors.black,),
                         ),
                       ),
                       Expanded(
                           child: TextField(
                             focusNode: _titleFocus,
                             onSubmitted: (value) async {
                             print("Field value: $value");
                            if( value !=""){

                              if(widget.task == null){


                                Task _newTask = Task(
                                    title: value
                                );

                               _taskId=  await _dbHelper.insertTask(_newTask);
                               setState(() {

                               });
                                print("New task has been created with id: $_taskId");
                              } else{
                                 await _dbHelper.updateTaskTitle(_taskId, value);
                              print("task updated");
                              }
                              }
                             },
                             controller: TextEditingController()..text = _taskTitle,
                             decoration: InputDecoration(
                               hintText: "Enter day",
                               border: InputBorder.none,

                             ),
                             style: TextStyle(
                               fontSize: 26.0,
                               fontWeight: FontWeight.bold,
                               color: Color(0xFF211551),
                             ),
                           ),
                        )
                     ],
                   ),
                 ),
                 TextField(
                   focusNode: _descriptionFocus,
                   onSubmitted: (value){
                     _todoFocus.requestFocus();
                   },
                   decoration: InputDecoration(
                     hintText: "Enter your task",
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.symmetric(
                       horizontal: 20.0,
                     ),
                   ),
                 ),
                 FutureBuilder(
                   initialData: [],
                   future: _dbHelper.getTodo(_taskId),
                   builder: (context, snapshot){
                   return Expanded(
                     child: ListView.builder(
                         itemCount:snapshot.data.length,
                         itemBuilder: (context,index) {
                       return GestureDetector(
                         onTap: (){
                          print("todo is done: ${snapshot.data[index].isDone}");
                         },
                         child: Todowidget(
                           text: snapshot.data[index].title,
                           isDone: snapshot.data[index].isDone == 0 ? false :true ,

                         ),
                       );
                     }
                     ),
                   );
                   },
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: 20.0
                   ),
                   child: Row(
                     children: [
                       Container(
                         margin: EdgeInsets.only(
                           right: 10.0,
                         ),
                         child: Icon(Icons.control_point
                           , color: Colors.blueAccent,size: 20.0,),

                       ),
                       Expanded(
                         child: TextField(
                           focusNode: _todoFocus,
                           onSubmitted: (value) async{
                             if( value !=""){

                               if(widget.task != null){

                                 DatabaseHelper _dbHelper = DatabaseHelper();
                                 Todo _newTodo = Todo(
                                     title: value,
                                   isDone: 0,
                                   taskId: widget.task.id,
                                 );

                                 await _dbHelper.insertTodo(_newTodo);
                                setState(() {

                                });
                               }
                             }
                           },
                           decoration: InputDecoration(

                             hintText: "Enter To-Do item",
                             border: InputBorder.none,
                           ),

                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
             Positioned(
               bottom: 30.0,
               right: 24.0,
               child: GestureDetector(
                 onTap: () async {
                   if(_taskId != 0) {
                     await _dbHelper.deleteTask(_taskId);
                     Navigator.pop(context);
                   }
                 },
                 child: Container(
                   width:60.0,
                   height: 60.0,
                   decoration: BoxDecoration(
                       color: Color(0xFFFE3577),
                       borderRadius: BorderRadius.circular(50.0)

                   ),
                   child: Icon(Icons.delete_forever,
                     size: 40.0,
                     color: Colors.white,
                   ),
                 ),
               ),
             )
           ],
         ),
        ),
      ),
    );
  }
}
