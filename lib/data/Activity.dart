class Activity{
  late String? uuid;
  late String description;
  late DateTime start_time;
  late DateTime end_time;
  late double location_lat;
  late double location_lng;
  late DateTime created_at;
  late DateTime updated_at;
  late String useruuid;

  Activity({this.uuid, required this.description, required this.start_time, required this.end_time, required this.location_lat, required this.location_lng, required this.created_at, required this.updated_at, required this.useruuid});

  Map<String, dynamic> toMap(String uuid) {
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