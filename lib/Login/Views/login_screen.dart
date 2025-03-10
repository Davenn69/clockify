import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Password/Views/password_screen.dart';
import '../../Register/Views/register_screen.dart';

class LoginScreen extends StatefulWidget{
  LoginScreen({super.key});

  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();

  Route _createRouteForPasswordScreen(String email){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation)=>PasswordScreen(email: email,),
      transitionDuration: Duration(milliseconds: 400),
      reverseTransitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondAnimation, child){
          var tween = Tween(begin: Offset(1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeIn));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
      }
    );
  }

  Route _createRouteForRegisterScreen(){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondAnimation)=>RegisterScreen(),
        transitionDuration: Duration(milliseconds: 400),
        reverseTransitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondAnimation, child){
          var tween = Tween(begin: Offset(1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeIn));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        }
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF233971),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Image.asset(
                  width: 250,
                  height: 250,
                  "assets/images/clockify-medium.png"
                ),
                SizedBox(height: 150),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    style: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      color: Colors.white
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: EdgeInsets.only(left:20),
                      labelText: "Email",
                      labelStyle: GoogleFonts.nunitoSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40, // Controls how much space the icon takes
                        minHeight: 60,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF45CDDC),
                          Color(0xFF2EBED9),
                        ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    )
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent
                      ),
                      onPressed: (){
                        Navigator.of(context).push(_createRouteForPasswordScreen(_emailController.text));
                      },
                      child: Text(
                        "SIGN IN",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      )
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(_createRouteForRegisterScreen());
                  },
                  child: Text(
                    "Create a new account?",
                    style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}