import 'package:hive_flutter/hive_flutter.dart';

import '../data/Activity.dart';
import '../data/ActivityHive.dart';

class HiveService{
  static late CollectionBox<Map> activityBox;
  static late ActivityHive activity;

  static void init(CollectionBox<Map> box) {
    activityBox = box;
  }

  static Future<void> saveActivity(Activity activity) async {
    List<ActivityHive> allActivities = await getAllActivities();
    await activityBox.put("${allActivities.length+1}", activity.toMap('${allActivities.length+1}'));
    print(allActivities.length+1);
  }

  static Future<List<ActivityHive>> getAllActivities() async {
    final keys = await activityBox.getAllKeys();
    final List<ActivityHive> activities = [];

    for (var key in keys) {
      final data = await activityBox.get(key);
      if (data != null) {
        activities.add(mapToActivity(Map<String, dynamic>.from(data)));
      }
    }
    return activities;
  }

  static ActivityHive mapToActivity(Map<String, dynamic> data) {
    return ActivityHive(
      uuid: data['uuid'],
      description: data['description'],
      start_time: data['start_time'],
      end_time: data['end_time'],
      location_lat: data['location_lat'],
      location_lng: data['location_lng'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      useruuid: data['useruuid'],
    );
  }

  static Future<void> deleteActivity(String uuid)async {
    await activityBox.delete(uuid);
  }

}