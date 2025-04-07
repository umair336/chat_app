import 'package:chat_app/TencentUiKit_controller.dart';
import 'package:chat_app/login.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Access the singleton instance of TIMUIKITService
  final timeservices = TIMUIKITService();

  //initialize the sdk
  timeservices.initTIMUIKIT();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login()
    );
  }
}

