import 'package:hive/hive.dart';

part 'ActivityHive.g.dart';

@HiveType(typeId: 0)
class ActivityHive extends HiveObject{
  @HiveField(0)
  String uuid;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime? start_time;

  @HiveField(3)
  DateTime? end_time;

  @HiveField(4)
  double location_lat;

  @HiveField(5)
  double location_lng;

  @HiveField(6)
  DateTime? created_at;

  @HiveField(7)
  DateTime? updated_at;

  @HiveField(8)
  String useruuid;

  ActivityHive({
    required this.uuid,
    required this.description,
    required this.start_time,
    required this.end_time,
    required this.location_lat,
    required this.location_lng,
    required this.created_at,
    required this.updated_at,
    required this.useruuid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'description': description,
      'start_time': start_time,
      'end_time': end_time,
      'location_lat': location_lat,
      'location_lng': location_lng,
      'created_at': created_at,
      'updated_at': updated_at,
      'useruuid': useruuid,
    };
  }
}