import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:curriculi/screens/course_entry.dart';

//fourth commit

// 5th commit, new branch

class LessonContent extends StatefulWidget {
  final String content;

  const LessonContent({super.key, required this.content});

  @override
  State<LessonContent> createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const CourseEntry()), // Ensure this matches your actual course_entry screen class name
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: navigateToHome,
          )
        ],
        title: const Text(
          'Lesson Content',
          style: TextStyle(color: Color(0xff865DFF)),
        ),
        backgroundColor: const Color(0xff191825),
        iconTheme: const IconThemeData(
          color: Color(0xff865DFF),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Markdown(data: widget.content),
      ),
    );
  }
}
