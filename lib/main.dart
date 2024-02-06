import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(MyApp());
}


Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Hive.openBox("accounts");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: Login(),
    );
  }
}
