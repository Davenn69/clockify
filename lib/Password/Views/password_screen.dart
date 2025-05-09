import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

final isVisibleProvider = StateProvider<bool>((ref)=>true);

class PasswordScreen extends ConsumerWidget {
  final TextEditingController _passwordController = TextEditingController();
  late String email;

  PasswordScreen({super.key, required this.email});

  void setSessionKey(String email)async{
    final collection = await BoxCollection.open("MyAppCollection", {'sessionBox'});
    final sessionBox = await collection.openBox('sessionBox');

    final data = await sessionBox.put('sessionData', email);
    print(email);
  }

  Widget build(BuildContext context, WidgetRef ref) {
    final bool isVisible = ref.watch(isVisibleProvider);
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    "Password",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: _passwordController,
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
                          ref.read(isVisibleProvider.notifier).state = !isVisible;
                        },
                          child: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined)
                      )
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
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
                        setSessionKey(email);
                        Navigator.pushReplacementNamed(context, "/loading_content");
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left:82),
                    child: GestureDetector(
                      onTap: (){},
                      child: Text(
                          "Forgot password?",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black87.withAlpha(100),
                          color: Colors.black87.withAlpha(100)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}