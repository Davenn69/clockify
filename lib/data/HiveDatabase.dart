// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'ActivityHive.dart';
//
// class HiveDatabase{
//   static late final BoxCollection collection;
//   static late final CollectionBox<ActivityHive> activityBox;
//
//   static Future<void> init() async{
//     final appDir = await getApplicationDocumentsDirectory();
//     collection = await BoxCollection.open('ClockifyDatabase', {'activities', 'sessionBox'}, path: appDir.path);
//
//     activityBox = await collection.openBox<ActivityHive>(
//       'activities',
//       adapter:ActivityHiveAdapter(),
//     );
//   }
// }