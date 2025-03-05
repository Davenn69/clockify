import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentScreen extends ConsumerWidget{
  Widget build(BuildContext context, WidgetRef ref){
    return Hero(
      tag: "animatedBox",
      child: Scaffold(
        backgroundColor: Color(0xFF233971),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  color: Color(0xFF233971),
                  width: 200,
                  height: 200,
                ),
              )
            )
        ),
      ),
    );
  }
}