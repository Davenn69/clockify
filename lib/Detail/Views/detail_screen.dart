import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data/Activity.dart';

String formatTime(DateTime? time) {
  return time != null ? DateFormat('hh:mm:ss').format(time) : "-";
}

String formatDate(DateTime? time){
  return time != null ? DateFormat("dd MMM yyyy").format(time) : "-";
}

String formatDuration(Duration duration){
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return "$hours : $minutes : $seconds";
}

Widget SaveDeleteState(WidgetRef ref){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF45CDDC),
                        Color(0xFF2EBED9),
                      ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent
                      ),
                      onPressed: (){
                      },
                      child: Text(
                        "SAVE",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white
                        ),
                      )
                  )
              )
          ),
          SizedBox(width: 20,),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent
                      ),
                      onPressed: (){
                      },
                      child: Text(
                        "DELETE",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade500
                        ),
                      )
                  )
              )
          ),
        ]
    ),
  );
}

class DetailScreen extends ConsumerWidget{
  Activity activity;
  DetailScreen({required this.activity});
  Widget build(BuildContext context, WidgetRef ref){
    final TextEditingController _descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF233971),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
            "Detail",
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
              color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: Color(0xFF233971),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap:(){
                        Navigator.pushReplacementNamed(context, "/activity");
                      },
                      child: Text(
                        "${formatDate(activity.created_at)}",
                        style: GoogleFonts.nunitoSans(
                            color: Color(0xFFF8D068),
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80),
                Text(
                  formatDuration(activity.end_time.difference(activity.start_time)),
                  style: GoogleFonts.nunitoSans(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color : Colors.white
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Start Time",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${formatTime(activity.start_time)}",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${formatDate(activity.start_time)}",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "End Time",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${formatTime(activity.end_time)}",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${formatDate(activity.end_time)}",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 275,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          size: 30,
                          color: Color(0xFFF8D068),
                        ),
                        Text(
                          "${activity.location_lat} ${activity.location_lng}",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: "Write your activity here...",
                      filled: true,
                      fillColor: Colors.white,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SaveDeleteState(ref),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}