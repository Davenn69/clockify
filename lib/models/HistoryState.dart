import 'package:clockify_miniproject/Detail/Views/detail_screen.dart';
import 'package:clockify_miniproject/data/Activity.dart';
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

Route _createRouteForDetail(Activity activity){
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
Widget activityHistoryWidget(Activity activity, BuildContext context){
  return Slidable(
    endActionPane: ActionPane(motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) { Navigator.pushReplacementNamed(context, '/');},
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

class HistoryState{
  late List<Activity> history = [];

  HistoryState({ required this.history});

  HistoryState getData(){
    return HistoryState(
      history: [...history]
    );
  }

}

class HistoryStateNotifier extends StateNotifier<HistoryState>{
  HistoryStateNotifier() : super(HistoryState(history: [
    Activity(
      uuid: "1",
      description: "Treadmill",
      start_time: DateTime(2024, 3, 1, 9, 0),
      end_time: DateTime(2024, 3, 1, 10, 0),
      location_lat: 12.9212,
      location_lng: 12.9212,
      created_at: DateTime(2024, 3, 1, 8, 0),
      updated_at: DateTime(2024, 3, 1, 8, 30),
      useruuid: "user_001",
    ),
    Activity(
      uuid: "2",
      description: "Cycling",
      start_time: DateTime(2024, 3, 2, 7, 0),
      end_time: DateTime(2024, 3, 2, 8, 0),
      location_lat: 12.9213,
      location_lng: 12.9213,
      created_at: DateTime(2024, 3, 2, 6, 30),
      updated_at: DateTime(2024, 3, 2, 6, 50),
      useruuid: "user_002",
    ),
    Activity(
      uuid: "3",
      description: "Swimming",
      start_time: DateTime(2024, 3, 3, 14, 0),
      end_time: DateTime(2024, 3, 3, 15, 30),
      location_lat: 12.9214,
      location_lng: 12.9214,
      created_at: DateTime(2024, 3, 3, 13, 0),
      updated_at: DateTime(2024, 3, 3, 13, 45),
      useruuid: "user_003",
    ),
    Activity(
      uuid: "4",
      description: "Yoga",
      start_time: DateTime(2024, 3, 4, 6, 0),
      end_time: DateTime(2024, 3, 4, 7, 0),
      location_lat: 12.9215,
      location_lng: 12.9215,
      created_at: DateTime(2024, 3, 4, 5, 30),
      updated_at: DateTime(2024, 3, 4, 5, 50),
      useruuid: "user_004",
    ),
    Activity(
      uuid: "5",
      description: "Weight Training",
      start_time: DateTime(2024, 3, 5, 18, 0),
      end_time: DateTime(2024, 3, 5, 19, 30),
      location_lat: 12.9216,
      location_lng: 12.9216,
      created_at: DateTime(2024, 3, 5, 17, 0),
      updated_at: DateTime(2024, 3, 5, 17, 45),
      useruuid: "user_005",
    ),
    Activity(
      uuid: "6",
      description: "Running",
      start_time: DateTime(2024, 3, 6, 5, 30),
      end_time: DateTime(2024, 3, 6, 6, 30),
      location_lat: 12.9217,
      location_lng: 12.9217,
      created_at: DateTime(2024, 3, 6, 4, 45),
      updated_at: DateTime(2024, 3, 6, 5, 15),
      useruuid: "user_006",
    ),
  ]));

  void getNewData(){
    state = HistoryState(history: [
      ...state.history,
    ]);
  }

  void sortByDate({bool ascending = true}){
    if (state.history.isNotEmpty){
      state.history!.sort((a, b){
        DateTime dateA = a.created_at;
        DateTime dateB = b.created_at;

        return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
      state = HistoryState(history: [...state.history!]);
    }
  }

  List<Widget> makeWidget(BuildContext context){
    if(state.history.isNotEmpty){
      DateTime current = state.history[0].start_time;
      List<Widget> content = [];
      content.add(activityDateWidget(current));

      for(int i=0; i<state.history.length; i++){
        if (state.history[i].start_time!=current){
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