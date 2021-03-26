import 'package:flutter/material.dart';
import 'package:todo_list_app/database_file.dart';
import 'package:todo_list_app/screens/taskpage.dart';
import 'package:todo_list_app/widgets.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea (
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                      bottom: 30.0,
                    ),
                    child: Icon(
                      Icons.playlist_add,
                      color: Colors.green,
                      size: 70.0,
                    ),
                  ),
                  
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                       builder: (context, snapshot){
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => Taskpage(
                                          task: snapshot.data[index],
                                        )

                                    ),
                                  );
                                },
                                child: Taskcardwidget(
                                  title: snapshot.data[index].title,
                                ),
                              );
                            },
                        );
                       }
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 30.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => Taskpage(task: null)

                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width:60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(50.0)
                          
                    ),
                    child: Icon(Icons.add,
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

