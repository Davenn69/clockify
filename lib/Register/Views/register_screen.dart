import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final isPasswordVisible = StateProvider<bool>((ref)=>true);
final isConfirmPasswordVisible = StateProvider<bool>((ref)=>true);

Widget InputTextForEmail(TextEditingController controller, String labelText){
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.nunitoSans(
            fontSize: 20
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF233971).withAlpha(128), width: 2)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF233971), width:2)
        ),
    ),
  );
}

Widget InputTextForPassword(WidgetRef ref, TextEditingController controller, String labelText, StateProvider<bool> provider){
  final bool isVisible = ref.watch(provider);
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.visiblePassword,
    obscureText: !isVisible,
    decoration: InputDecoration(
        labelText: "Input your password",
        labelStyle: GoogleFonts.nunitoSans(
            fontSize: 20
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF233971).withAlpha(128), width: 2)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF233971), width:2)
        ),
        suffixIcon: GestureDetector(
            onTap: (){
              ref.read(provider.notifier).state = !isVisible;
            },
            child: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined)
        )
    ),
  );
}


class RegisterScreen extends ConsumerWidget{
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Widget build(BuildContext context, WidgetRef ref){

    void showModal(){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 350,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          "assets/images/success-medium.png"
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                          "Success",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                          "Your account has been successfully created.",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          color: Colors.grey.shade500
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    "Create New Account",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 40),
                  InputTextForEmail(_emailController, "Input your email"),
                  SizedBox(height: 40),
                  InputTextForPassword(ref, _passwordController, "Create your password", isPasswordVisible),
                  SizedBox(height: 40),
                  InputTextForPassword(ref, _confirmPasswordController, "Confirm your password", isConfirmPasswordVisible),
                  SizedBox(height: 50),
                  Stack(
                    children: [Padding(
                      padding: const EdgeInsets.only(top: 225),
                      child: Container(
                        width: 400,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Colors.black87.withAlpha(48),
                                offset: Offset(0, 2),
                                blurRadius: 10
                            )],
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
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              showModal();
                            });
                            Timer(Duration(seconds: 2), (){
                              Navigator.pushReplacementNamed(context, "/loading_content");
                            });
                          },
                          child: Text(
                            "OK",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
      ),
    );
  }
}