class Activity{
  late String uuid;
  late String description;
  late DateTime start_time;
  late DateTime end_time;
  late double location_lat;
  late double location_lng;
  late DateTime created_at;
  late DateTime updated_at;
  late String useruuid;

  Activity({required this.uuid, required this.description, required this.start_time, required this.end_time, required this.location_lat, required this.location_lng, required this.created_at, required this.updated_at, required useruuid});
}