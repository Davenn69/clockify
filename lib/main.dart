import 'package:clockify_miniproject/Content/Views/activity_screen.dart';
import 'package:clockify_miniproject/Content/Views/content_screen.dart';
import 'package:clockify_miniproject/Detail/Views/detail_screen.dart';
import 'package:clockify_miniproject/Loading/Views/loading_to_content.dart';
import 'package:clockify_miniproject/Password/Views/password_screen.dart';
import 'package:clockify_miniproject/data/Activity.dart';
import 'package:clockify_miniproject/services/HiveService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'Loading/Views/loading_screen.dart';
import 'Login/Views/login_screen.dart';
import 'Register/Views/register_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'data/ActivityHive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  Hive.registerAdapter(ActivityHiveAdapter());

  final collection = await BoxCollection.open(
    'MyAppCollection',
    {'activityBox', 'sessionBox'},
    path: appDir.path
  );
  final activityBox = await collection.openBox<Map>('activityBox');
  HiveService.init(activityBox);
  runApp(ProviderScope(
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        '/' : (context) => LoadingScreen(),
        '/login' : (context) => LoginScreen(),
        '/password' : (context) => PasswordScreen(email: '',),
        '/register' : (context) => RegisterScreen(),
        '/loading_content' : (context) => LoadingContentScreen(),
        '/content' : (context) => ContentScreen(),
        '/activity' : (context) => ActivityScreen(),
        '/detail' : (context) => DetailScreen(activity: Activity(uuid: '', description: '', start_time: DateTime.now(), end_time: DateTime.now()
            , location_lat: 0, location_lng: 0, created_at: DateTime.now(), updated_at: DateTime.now(), useruuid: ""),)
      },
    ),
  ));
}

