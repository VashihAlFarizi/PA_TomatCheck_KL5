import 'package:flutter/material.dart';
import 'package:TomatCheck/controller/controller.dart';
import 'package:TomatCheck/pages/intro1_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PredictionProvider())],
      child: const TomatCheckApp(),
    ),
  );
}

class TomatCheckApp extends StatelessWidget {
  const TomatCheckApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TomatCheck',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF9F5ED),
      ),
      debugShowCheckedModeBanner: false,
      home: const Page1(),
    );
  }
}
