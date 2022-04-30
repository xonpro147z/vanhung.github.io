import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:todoapp/Service/Auth_service.dart';
class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start =30;
  bool wait = false;
  String buttonName = "Gửi";
  String verificationId = "";
  String smsCode = "";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            "Đăng kí",
            style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
            SizedBox(
              height: 20,
            ),
            textField(),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  authClass.signInWithPhoneNumber(verificationId, smsCode, context);
                },
              child:Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                Expanded(
                    child: Container(
                        height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal:12),
                      ),
                    ),
                    Text("Nhập 6 chữ số được nhận", style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal:12),

                      ),
                    ),
                  ],

                ),),),
              SizedBox(
                height: 30,
              ),
            otpField(),
              SizedBox(
                height: 40,
              ),
              RichText(text: TextSpan(
                children: [
                  TextSpan(text: "Gửi lại mã trong ",style:TextStyle(fontSize: 16,color: Colors.black)),
                TextSpan(text: "00:$start ",style:TextStyle(fontSize: 16,color: Colors.red),),
                  TextSpan(text: "giây",style:TextStyle(fontSize: 16,color: Colors.black),),
                ],
              ),),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width -60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                 child: Text("Được rồi đi thôi", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700, color:Colors.white)),
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
  void startTimer()
  {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec,(timer) {
    if (start==0)
      {
      setState(() {
        timer.cancel();
        wait =false;
      });
      }
    else
      {
        setState(() {
          start --;
        });

      }
    });
  }
  Widget otpField()
  {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width -30,
      fieldWidth: 56,
      otpFieldStyle:  OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Colors.white,
      ),
      style: TextStyle(
          fontSize: 17
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }
  Widget textField()
  {
    return Container(
      width: MediaQuery.of(context).size.width -  40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        controller: phoneController,
        decoration: InputDecoration(
            border: InputBorder.none,
          hintText: "Nhập số điện thoại...",
          hintStyle: TextStyle(color: Colors.black,fontSize: 17),
          contentPadding: const EdgeInsets.symmetric(vertical: 19,horizontal: 8),
          prefixIcon:Padding(
         padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 8),
            child: Text("+84", style: TextStyle(color: Colors.black,fontSize: 17),
            ),
          ),
      suffixIcon: InkWell(
        onTap:wait?null: () async {
          start =30;
          startTimer();
          setState(() {
            wait=true;
            buttonName ="Gửi lại";
          });
          await authClass.verifyPhoneNumber("+84 ${phoneController.text}", context,setData);
        },
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child: Text(buttonName, style: TextStyle(color: wait? Colors.grey:Colors.black,fontSize: 17,fontWeight: FontWeight.bold),
        ),
      ),
    )
    ),
      )
    );
  }
  void setData(String verificationId)
  {
    setState(() {
      verificationId = verificationId;
    });

  }
}
