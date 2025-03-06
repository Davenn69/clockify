import 'package:clockify_miniproject/services/get_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class TimeLocationState{
  final DateTime? startTime;
  final DateTime? endTime;
  final String? geolocation;

  TimeLocationState({this.startTime, this.endTime, this.geolocation});

  TimeLocationState copyWith({DateTime? startTime, DateTime? endTime, String? geolocation}){
    return TimeLocationState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      geolocation: geolocation ?? this.geolocation
    );
  }
}

class TimeLocationNotifier extends StateNotifier<TimeLocationState>{
  TimeLocationNotifier() : super(TimeLocationState());

  void startTimer(){
    state = state.copyWith(startTime: DateTime.now());
  }

  void stopTimer() {
    state = state.copyWith(endTime: DateTime.now());
  }

  Future<void> updateGeolocation() async {
    Position position = await getCurrentLocation();
    String location = "${position.latitude}, ${position.longitude}";
    print("location" + location);
    state = state.copyWith(geolocation: location);
  }

  void reset() {
    state = TimeLocationState();
  }
}