import 'package:flutter/material.dart';
import 'screens/course_entry.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/registration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'screens/content.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Curriculi',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: CourseEntry.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        CourseEntry.id: (context) => CourseEntry(),
      },
    );
  }
}
