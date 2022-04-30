import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../pages/HomePage.dart';
import '../pages/SignInPage.dart';
class AuthClass {

  final  _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          UserCredential userCredential = await auth.signInWithCredential(
              credential);
          storeTokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (builder) => HomePage()), (
              route) => false);
        }
        catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
      else {
        final snackbar = SnackBar(content: Text('Không thể đăng nhập!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
    catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async
  {
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async
  {
    return await storage.read(key: "token");
  }
  Future<void>verifyPhoneNumber(String phoneNumber,BuildContext context,Function setData) async
  {
    PhoneVerificationCompleted verificationCompleted =(PhoneAuthCredential phoneAutCredential) async {
      showSnackBar(context,"Xác thực thành công");
    };
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception){
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent =(String verificationID,[int? forceResnedingtoken]){
      showSnackBar(context,"Mã xác minh được gửi trên số điện thoại");
      setData(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String vericationID){
      showSnackBar(context,"Hết giờ");
    };
    try{
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }
  Future<void>signInWithPhoneNumber(String verificationId, String smsCode, BuildContext context)async {
    try{
      AuthCredential credential =PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
     UserCredential userCredential = await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (builder) => HomePage()), (
          route) => false);
          showSnackBar(context, "Đã đăng nhập");
    }
        catch(e){
          showSnackBar(context, "Đã đăng nhập");
        }
      showSnackBar(context, "Đã đăng nhập");
  }
  void showSnackBar(BuildContext context, String text)
  {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<void>logout()async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    }
    catch (e) {
    }
  }
}
