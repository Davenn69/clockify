import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingContentScreen extends StatefulWidget{
  LoadingContentScreen({super.key});

  State<LoadingContentScreen> createState() => LoadingContentScreenState();
}

class LoadingContentScreenState extends State<LoadingContentScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  void ContentReady(){
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
    Timer(Duration(seconds: 2),(){  
      Navigator.pushReplacementNamed(context, "/content");
    });
  }
  
  void initState(){
    super.initState();
    ContentReady();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index){
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value * (index + 1) / 1.5),
                  child: Hero(
                    tag: index == 1 ? "animatedBox" : "box$index",
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF233971),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              },
            );
          })
        ),
        )
      );
  }
}