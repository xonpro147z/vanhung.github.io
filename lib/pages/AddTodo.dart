import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white70,
        Colors.white,
      ])),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.arrow_left,
                  color: Color.fromARGB(255, 19, 19, 19), size: 28),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thêm",
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "kế hoạch cho hôm nay",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2),
                  ),
                  SizedBox(height: 20),
                  label("Nội dung kế hoạch"),
                  SizedBox(height: 15),
                  title(),
                  SizedBox(height: 30),
                  label("Phân loại công việc"),
                  Row(
                    children: [
                      SizedBox(height: 12),
                      chipData("Quan trọng", 0xff2664fa),
                      SizedBox(width: 20),
                      chipData("Đã lên ", 0xff2bc89d),
                    ],
                  ),
                  SizedBox(height: 20),
                  label("Mô tả"),
                  SizedBox(height: 12),
                  description(),
                  SizedBox(height: 20),
                  label("Chủ đề"),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      SizedBox(height: 12),
                      chipData("Nấu ăn", 0xff2664fa),
                      SizedBox(width: 20),
                      chipData("Tập thể dục", 0xff2bc89d),
                      SizedBox(width: 20),
                      chipData("Làm bài tập", 0xffD59412),
                      SizedBox(width: 20),
                      chipData("Nhảy", 0xffE30CCF),
                      SizedBox(width: 20),
                      chipData("Thiết kế", 0xff0CE31F),
                      SizedBox(width: 60),
                    ],
                  ),
                  SizedBox(height: 30),
                  button(),
                  SizedBox(width: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget button() {
    return Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
            child: Text(
          "Thêm công việc",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )));
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffebe6e6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Mô tả công việc....",
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget chipData(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(
        label,
        style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 2),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: "Nội dung kế hoạch",
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(
            left: 10,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
          fontSize: 15),
    );
  }
}
