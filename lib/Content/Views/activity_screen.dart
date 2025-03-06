import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final _selectedProvider = StateProvider<int>((ref)=>0);

class ActivityScreen extends ConsumerWidget{
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      backgroundColor: Color(0xFF233971),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                      width: 125,
                      height: 125,
                      "assets/images/clockify-medium.png"
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){Navigator.pushReplacementNamed(context, "/content");},
                        child: Text(
                          "Timer",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){ref.read(_selectedProvider.notifier).state=1;},
                            child: Text(
                              "Activity",
                              style: GoogleFonts.nunitoSans(
                                  color: Color(0xFFF8D068),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Hero(
                            tag: "timer-activity",
                            child: AnimatedContainer(
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: 3,
                              color : Color(0xFFF8D068),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 90),
                ],
              ),
            ),
          )
      ),
    );
  }
}