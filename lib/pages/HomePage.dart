import 'package:flutter/material.dart';
import 'package:todoapp/Service/Auth_service.dart';
import 'package:todoapp/pages/SignUpPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Lịch trình hôm nay",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("images/avatar.jpg"),
          ),
          SizedBox(
            width: 12,
          )
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Thứ 5, ngày 28/04",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(21),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.white, items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.indigoAccent,
                  Colors.purple,
                ],
              ),
            ),
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            title: Container(),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 30,
            color: Colors.black,
          ),
          title: Container(),
        ),
      ]),
    );
  }
}
