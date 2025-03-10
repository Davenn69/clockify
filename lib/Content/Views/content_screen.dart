import 'dart:async';

import 'package:clockify_miniproject/data/ActivityHive.dart';
import 'package:clockify_miniproject/models/TimeLocationState.dart';
import 'package:clockify_miniproject/services/HiveService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

final _selectedProvider = StateProvider<int>((ref)=>0);
final _isStart = StateProvider<bool>((ref)=>true);
final _isResetStop = StateProvider<bool>((ref)=>true);
final _stopWatchTimerProvider = StateProvider<StopWatchTimer>((ref){
  final stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      );
  return stopWatchTimer;
  }
);
final stopWatchTimeProvider = StreamProvider<int>((ref){
 final stopWatch = ref.watch(_stopWatchTimerProvider);
 return stopWatch.rawTime;
}
);
final timeLocationProvider = StateNotifierProvider<TimeLocationNotifier, TimeLocationState>((ref){
  return TimeLocationNotifier();
});

Widget StartState(WidgetRef ref, StateProvider<bool> provider, void Function(WidgetRef, TimeLocationNotifier) startTimer, TimeLocationNotifier notifier){
  // print(ref.read(provider.notifier).state);
  return Container(
      width: 300,
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
            ref.read(provider.notifier).state = !ref.read(provider.notifier).state;
            startTimer(ref, notifier);
          },
          child: Text(
            "START",
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),
          )
      )
  );
}

Widget NotStartState(WidgetRef ref, StateProvider<bool> isResetStop, StateProvider<bool> isStart, void Function(WidgetRef, TimeLocationNotifier) stopTimer, void Function(WidgetRef, TimeLocationNotifier) resetTimer, TimeLocationNotifier notifier, ActivityHive activity){
  return ref.read(isResetStop.notifier).state ? ResetStopState(ref, isResetStop, isStart, stopTimer, resetTimer, notifier) : SaveDeleteState(ref, isResetStop, isStart, notifier, resetTimer, activity);
}

Widget SaveDeleteState(WidgetRef ref, StateProvider<bool> provider1, StateProvider<bool> provider2, TimeLocationNotifier notifier, void Function(WidgetRef, TimeLocationNotifier) resetTimer, ActivityHive activity){
  final resetStopCondition = ref.watch(_isResetStop);
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
                      onPressed: ()async{

                        // final collection = await BoxCollection.open("MyAppCollection", {'activityBox'});
                        // final CollectionBox<Map> activityBox = await collection.openBox<Map>('activityBox');
                        // HiveService service = HiveService(activityBox: activityBox);
                        await HiveService.saveActivity(activity);

                        List<ActivityHive> activities = await HiveService.getAllActivities();
                        for(var item in activities){
                          print(item.description);
                        }
                        ref.read(provider1.notifier).state = !ref.read(provider1.notifier).state;
                        ref.read(provider2.notifier).state = !ref.read(provider2.notifier).state;
                        resetTimer(ref, notifier);
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
                        ref.read(provider1.notifier).state = !ref.read(provider1.notifier).state;
                        ref.read(provider2.notifier).state = !ref.read(provider2.notifier).state;
                        resetTimer(ref, notifier);
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

Widget ResetStopState(WidgetRef ref, StateProvider<bool> isResetStop, StateProvider<bool> isStart, void Function(WidgetRef, TimeLocationNotifier) stopTimer, void Function(WidgetRef, TimeLocationNotifier) resetTimer, TimeLocationNotifier notifier){
  final resetStopCondition = ref.watch(_isResetStop);
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
                      ref.read(isResetStop.notifier).state = !ref.read(isResetStop.notifier).state;
                      stopTimer(ref, notifier);
                    },
                    child: Text(
                      "STOP",
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
                      ref.read(isStart.notifier).state = !ref.read(isStart.notifier).state;
                      resetTimer(ref, notifier);
                    },
                    child: Text(
                      "RESET",
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

class ContentScreen extends ConsumerWidget{

  final _descriptionController = TextEditingController();

  void startTimer(WidgetRef ref, TimeLocationNotifier notifier){
    String currentTime = DateTime.now().toString();
    print(currentTime);
    final stopWatchTimer = ref.watch(_stopWatchTimerProvider.notifier);
    stopWatchTimer.state = StopWatchTimer(
      mode: StopWatchMode.countUp,
    );
    stopWatchTimer.state.onStartTimer();
    notifier.startTimer();
  }

  Future<void> stopTimer(WidgetRef ref, TimeLocationNotifier notifier)async{
    final stopWatchTimer = ref.watch(_stopWatchTimerProvider.notifier);
    stopWatchTimer.state.onStopTimer();
    notifier.stopTimer();
    await notifier.updateGeolocation();
  }

  void resetTimer(WidgetRef ref, TimeLocationNotifier notifier){
    final stopWatchTimer = ref.watch(_stopWatchTimerProvider.notifier);
    stopWatchTimer.state.onResetTimer();
    notifier.resetTimer();
  }

  Widget build(BuildContext context, WidgetRef ref){

    final currentPage = ref.watch(_selectedProvider);
    final condition = ref.watch(_isStart);
    final _stopWatchTime = ref.watch(stopWatchTimeProvider);
    final stopWatchTimer = ref.watch(_stopWatchTimerProvider);
    final state = ref.watch(timeLocationProvider);
    final notifier = ref.read(timeLocationProvider.notifier);

    if(state.geolocation == null){
      Future.delayed(Duration.zero, () {
        notifier.updateGeolocation();
      });
    }

    String formatTime(DateTime? time) {
      return time != null ? DateFormat('hh:mm:ss').format(time) : "-";
    }

    String formatDate(DateTime? time){
      return time != null ? DateFormat("dd MMM yyyy").format(time) : "-";
    }

    return Scaffold(
      backgroundColor: Color(0xFF233971),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                        "assets/images/clockify-medium.png",
                        width: 200,
                        fit: BoxFit.cover
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Text(
                                "Timer",
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
                      GestureDetector(
                        onTap:(){
                          Navigator.pushReplacementNamed(context, "/activity");
                        },
                        child: Text(
                          "Activity",
                          style: GoogleFonts.nunitoSans(
                              color: ref.read(_selectedProvider.notifier).state == 1 ? Color(0xFFF8D068):Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Text(
                      _stopWatchTime.when(data: (value)=> StopWatchTimer.getDisplayTime(value, milliSecond: false).replaceAll(":", " : "), loading: () => "00 : 00 : 00", error: (err, stack) => "Error"),
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
                            "${formatTime(state.startTime)}",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${formatDate(state.startTime)}",
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
                            "${formatTime(state.endTime)}",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${formatDate(state.endTime)}",
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
                        children: state.geolocation == null ? <Widget>[SpinKitCircle(
                          color: Colors.white,
                          size: 30,
                        )] : <Widget>[

                          Icon(
                            Icons.location_on_outlined,
                            size: 30,
                            color:  Color(0xFFF8D068)
                          ),
                          Text(
                            "${state.geolocation}",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  ),
                  SizedBox(height: 20),
                  condition ? StartState(ref, _isStart, startTimer, notifier) : NotStartState(ref, _isResetStop, _isStart, stopTimer, resetTimer, notifier, ActivityHive(
                    uuid: "8",
                    description: _descriptionController.text,
                    start_time: state.startTime,
                    end_time: state.endTime,
                    location_lat: 12.0913,
                    location_lng: 12.9213,
                    created_at: state.startTime,
                    updated_at: DateTime(2024, 3, 2, 6, 50),
                    useruuid: "user_002",
                  ),),
                  SizedBox(height: 40)
                ],
              ),
            ),
          )
      ),
    );
  }
}