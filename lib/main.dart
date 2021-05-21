import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incident_report/Wrapper.dart';
import 'package:incident_report/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: 'Flutter Demo',
      home: Wrapper(),
    );
  }
}
