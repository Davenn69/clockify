import 'package:clockify_miniproject/services/get_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class TimeLocationState{
  final DateTime? startTime;
  final DateTime? endTime;
  final String? geolocation;

  TimeLocationState({this.startTime, this.endTime, this.geolocation});

  TimeLocationState copyWith({required bool resetStart, required bool resetEnd, DateTime? startTime, DateTime? endTime, String? geolocation}){
    return TimeLocationState(
      startTime: resetStart ? null : (startTime ?? this.startTime),
      endTime: resetEnd ? null : (endTime ?? this.endTime),
      geolocation: geolocation ?? this.geolocation
    );
  }
}

class TimeLocationNotifier extends StateNotifier<TimeLocationState>{
  TimeLocationNotifier() : super(TimeLocationState());

  void startTimer(){
    state = state.copyWith(resetStart : false, resetEnd : false, startTime: DateTime.now());
  }

  void stopTimer() {
    state = state.copyWith(resetStart : false, resetEnd : false, endTime: DateTime.now());
  }

  void resetTimer(){
    state = state.copyWith(resetStart : true, resetEnd : true);
  }

  Future<void> updateGeolocation() async {
    Position position = await getCurrentLocation();
    String location = "${position.latitude}, ${position.longitude}";
    state = state.copyWith(resetStart : false, resetEnd : false, geolocation: location);
  }

  void reset() {
    state = TimeLocationState();
  }
}