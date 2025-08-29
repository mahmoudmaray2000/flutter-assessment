import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/popular_people_view.dart';
import 'package:flutter_assessment/injection.dart';

import 'features/popular_people/popular_people_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  PopularPeopleModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopularPeoplePage(),
    );
  }
}
