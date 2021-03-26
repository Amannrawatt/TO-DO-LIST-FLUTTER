import 'package:flutter/material.dart';
class Taskcardwidget extends StatelessWidget {
  final String title;
  final String desc;
  Taskcardwidget({this.title , this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(20.0),
     ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? "(Unnamed Task)",
        style: TextStyle(color: Colors.indigo[700],
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: 10.0,
        ),
        child: Text(
          desc ?? "No description added",
          style: TextStyle(fontSize: 16.0, color: Colors.grey, height: 1.5,),
        ),
      ),
    ],
  )
    );
  }
}

class Todowidget extends StatelessWidget {
  final String text;
  final bool isDone;
  Todowidget({this.text,@required this.isDone,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 5.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 10.0,
            ),
            child: Icon(isDone ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isDone ? Colors.blueAccent : Colors.black,size: 20.0,),

          ),
          Text(
            text ?? "(Unnamed To-Do)",
            style: TextStyle(
              color: isDone ? Colors.indigo[900] : Colors.grey[600],
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}

