import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todoapp/Service/Auth_service.dart';
import 'package:todoapp/pages/AddTodo.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:todoapp/pages/PhoneAuth.dart';
import 'package:todoapp/pages/SignInPage.dart';
import 'package:todoapp/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPages();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
