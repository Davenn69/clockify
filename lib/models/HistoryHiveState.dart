import 'package:clockify_miniproject/Detail/Views/detail_screen.dart';
import 'package:clockify_miniproject/data/Activity.dart';
import 'package:clockify_miniproject/data/ActivityHive.dart';
import 'package:clockify_miniproject/services/HiveService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date){
  return date!=null ? DateFormat("dd MMM yyyy").format(date) : "-";
}
String formatTime(DateTime time){
  return time!=null ? DateFormat("hh:mm:ss").format(time) : "-";
}
String formatDuration(Duration duration){
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return "$hours : $minutes : $seconds";
}

Route _createRouteForDetail(ActivityHive activity){
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondAnimation)=>DetailScreen(activity: activity,),
      transitionDuration: Duration(milliseconds: 400),
      reverseTransitionDuration:  Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondAnimation, child){
        var tween = Tween(begin: Offset(1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child,);
      }
  );
}

Widget activityDateWidget(DateTime date){
  return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.white.withAlpha(50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            "${formatDate(date)}",
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                color: Color(0xFFF8D068)
            ),
          ),
        ),
      )
  );
}
Widget activityHistoryWidget(ActivityHive activity, BuildContext context){
  return Slidable(
    endActionPane: ActionPane(motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) async {
              await HiveService.deleteActivity(activity.uuid);
            },
            backgroundColor: Colors.redAccent,
            label: 'Delete',
          ),
        ]
    ),
    child: SizedBox(
      height: 60,
      width: double.infinity,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(_createRouteForDetail(activity));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey.withAlpha(100),
                    width: 1
                )
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${formatDuration(activity.end_time.difference(activity.start_time))}",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.lock_clock,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text(
                          "${formatTime(activity.start_time)} - ${formatTime(activity.end_time)}",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${activity.description}",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text(
                          "${activity.location_lat} ${activity.location_lng}",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class HistoryHiveState{
  late List<ActivityHive> history = [];

  HistoryHiveState({required this.history});

  HistoryHiveState getData(){
    return HistoryHiveState(
        history: [...history]
    );
  }

}

class HistoryHiveStateNotifier extends StateNotifier<HistoryHiveState>{
  HistoryHiveStateNotifier() : super(HistoryHiveState(history: [
  ]));

  void getAllData()async {
    List<ActivityHive> allActivities = await HiveService.getAllActivities();
    // for(int i=0; i<allActivities.length; i++){
    //   print("uuid + " + allActivities[i].uuid);
    // }
    // print("---");
    if (allActivities.isNotEmpty) {
      state.history!.sort((a, b) {
        DateTime dateA = a.created_at;
        DateTime dateB = b.created_at;

        return dateA.compareTo(dateB);
      });
      state = HistoryHiveState(history: [
        ...allActivities,
      ]);
    }
  }

    List<Widget> makeWidget(BuildContext context) {
      getAllData();
      if (state.history.isNotEmpty) {
        DateTime? current = state.history[0].start_time;
        List<Widget> content = [];
        content.add(activityDateWidget(current!));

        for (int i = 0; i < state.history.length; i++) {
          if (formatDate(state.history[i].start_time).trim() != formatDate(current!).trim()) {
            current = state.history[i].start_time;
            content.add(activityDateWidget(state.history[i].start_time));
          }
          content.add(activityHistoryWidget(state.history[i], context));
        }

        return content;
      }
      return [
        Text(
          "No data",
          style: GoogleFonts.nunitoSans(
              color: Colors.white,
              fontSize: 24
          ),
        ),
      ];
    }
}