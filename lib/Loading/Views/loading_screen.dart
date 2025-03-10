import 'dart:async';
import 'package:clockify_miniproject/Content/Views/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Login/Views/login_screen.dart';

class LoadingScreen extends StatefulWidget{
  LoadingScreen({super.key});

  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>{

  Future<bool> getSessionNull() async{
    print("hello");
    final collection = await BoxCollection.open('MyAppCollection', {'sessionBox'});
    final sessionBox = await collection.openBox('sessionBox');

    final data = await sessionBox.get('sessionData');
    print("hello + ${data}");
    return data == null ? true : false;
  }

  void setOrUseSession()async{
    if (await getSessionNull()) {
      ScreenTimeout();
    }else{
      Navigator.of(context).push(_createRouteToContent());
    }
  }
  Route _createRoute(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondAnimation) => LoginScreen(),
      transitionDuration: Duration(milliseconds: 400),
      reverseTransitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondAnimation, child){
        var tween = Tween(begin: Offset(1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeIn));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      }
    );
  }

  Route _createRouteToContent(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondAnimation)=> ContentScreen(),
      transitionDuration: Duration(milliseconds: 400),
      reverseTransitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondAnimation, child){
        var tween = Tween(begin: Offset(1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeIn));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position:offsetAnimation, child: child);
      }
    );
  }

  void ScreenTimeout(){
    Timer(Duration(milliseconds: 1000),(){
      Navigator.of(context).push(_createRoute());
    });
  }

  void initState(){
    super.initState();
    setOrUseSession();
    // print(getSessionNull());


  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF233971),
      body:Center(
        child: Image.asset(
          width: 300,
          height: 300,
          "assets/images/clockify-big.png"
        ),
      )
    );
  }
}