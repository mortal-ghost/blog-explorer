import 'package:blog_explorer/screens/home.dart';
import 'package:blog_explorer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataBase(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog Explorer",
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

