import 'package:flutter/material.dart';
import 'screens/course_entry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'screens/content.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curriculi',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const CourseEntry(),
    );
  }
}
