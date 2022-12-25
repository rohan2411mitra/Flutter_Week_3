import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_password_2/utils/color_utils.dart';
import 'package:login_password_2/reusable_widgets/reuse.dart';
import 'package:login_password_2/screens/signup_screen.dart';
import 'package:login_password_2/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[
        hexStringToColor("333333"),hexStringToColor("444444"),
        hexStringToColor("555555")],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: SingleChildScrollView(child:Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
        child: Column(
          children: <Widget>[
            logoWidget("assets/images/Person.png"),
            SizedBox(
              height: 30,
            ),
            reusableTextField("Enter Email", Icons.person_outline, false, _emailTextController),
            SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Password", Icons.lock, true, _passwordTextController),
            SizedBox(
              height: 20,
            ),
            signInSignUpButton(context, true, (){
              FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailTextController.text, password: _passwordTextController.text).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });

            }),
            SignUpOption()
          ],
        ),
        ),
        ),
      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
