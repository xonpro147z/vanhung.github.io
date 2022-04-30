import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todoapp/Service/Auth_service.dart';
import 'package:todoapp/pages/PhoneAuth.dart';
import 'package:todoapp/pages/SignInPage.dart';

import 'HomePage.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({Key? key}) : super(key: key);

  @override
  State<SignUpPages> createState() => SignUpPagesState();
}

class SignUpPagesState extends State<SignUpPages> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool circular =false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Đăng kí",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem("images/google.svg", "Tiếp tục với Google", 25,()async{
                await authClass.googleSignIn(context);
              }),
              SizedBox(
                height: 15,
              ),
              buttonItem('images/phone2.svg', "Tiếp tục với Điện thoại", 30,(){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
              }),
              SizedBox(height: 15,),
              Text ("Hoặc",style: TextStyle(color: Colors.black,fontSize: 18),),
              SizedBox(
                height: 15,
              ),
              textItem("Email...", emailController,false),
                SizedBox(
                  height: 15,
                ),
              textItem("Mật khẩu...", pwdController,true), //obscure text có 2 thuộc tính true và false: dùng cho phần bảo
              //mật phần mật khẩu không dc hiện
              SizedBox(
                height: 30,
              ),
              colorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bạn đã có tài khoản?",style: TextStyle(
                    fontSize: 16,
                    color: Colors.black),),
                  InkWell(
                    onTap:(){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignInPages()), (route) => false);
                    },
                    child:
                  Text(" Đăng nhập",style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget colorButton()
  {
    return InkWell(
      onTap:() async{
        setState(() {
          circular = true;
        });
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
              email: emailController.text, password: pwdController.text);
          //tạo dữ liệu cho thủ tục đăng kí
          print(userCredential.user?.email);
          setState(() {
            circular=false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
        }
        catch(e)
        {
          final snackbar =SnackBar(content:Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular=false;
          });
        }

      },
      child: Container(
      width: MediaQuery.of(context).size.width -90,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors:[
        Colors.orangeAccent,
        Colors.orangeAccent,
        Colors.orangeAccent,
        ]),
      ),
      child: Center(
        child:circular?CircularProgressIndicator(): Text("Đăng kí",style:TextStyle(color: Colors.white,fontSize: 25)),
      ),
      ),
    );
  }
  Widget buttonItem(String imagepath, String buttonName, double size,  VoidCallback? onTap) {
    return InkWell(
      onTap:onTap,
      child:Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 60,
      height: 60,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 1, color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagepath,
              height: size,
              width: size,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              buttonName,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
      ),

      ),

    );

  }
  Widget textItem(String labeltext, TextEditingController controller,bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style:TextStyle(
            fontSize: 17, color: Colors.black,
        ),
        decoration: InputDecoration(
        labelText: labeltext, labelStyle: TextStyle(fontSize: 17, color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
             borderSide:BorderSide(width: 1.5,
              color: Colors.amber),
        ),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide:BorderSide(width: 1,
    color: Colors.grey),),
      ),
      ),
    );
  }
}
