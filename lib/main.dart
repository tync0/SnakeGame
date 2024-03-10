import 'package:flutter/material.dart';

import 'view/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snake',
      theme: ThemeData(
        dialogBackgroundColor: Colors.grey[800],
      ),
      home: const MainView(),
    );
  }
}
