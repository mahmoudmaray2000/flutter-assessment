import 'package:flutter/material.dart';
import 'package:flutter_assessment/injection.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(),
    );
  }
}
