import 'dart:ffi';
import 'package:flutter/material.dart';
class TodoCard extends StatelessWidget {
  const TodoCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme( 
            child: Transform.scale(scale: 1,5)(
            child: Checkbox(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
            value: true, onChanged: (bool value){},
        ),
        data: ThemeData(primarySwatch: Colors.blue,
        unselectedWidgetColor: Color(0xff5e616a) 
        ),),),
        ],
      ),
    );
  }
}