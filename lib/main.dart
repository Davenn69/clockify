import 'package:clockify_miniproject/Content/Views/activity_screen.dart';
import 'package:clockify_miniproject/Content/Views/content_screen.dart';
import 'package:clockify_miniproject/Detail/Views/detail_screen.dart';
import 'package:clockify_miniproject/Loading/Views/loading_to_content.dart';
import 'package:clockify_miniproject/Password/Views/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Loading/Views/loading_screen.dart';
import 'Login/Views/login_screen.dart';
import 'Register/Views/register_screen.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      initialRoute: "/",
      routes: {
        '/' : (context) => LoadingScreen(),
        '/login' : (context) => LoginScreen(),
        '/password' : (context) => PasswordScreen(),
        '/register' : (context) => RegisterScreen(),
        '/loading_content' : (context) => LoadingContentScreen(),
        '/content' : (context) => ContentScreen(),
        '/activity' : (context) => ActivityScreen(),
        '/detail' : (context) => DetailScreen()
      },
    ),
  ));
}

