import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

//third commit

// 5th commit, new branch

class LessonContent extends StatelessWidget {
  final String content;

  // Corrected constructor name and initialization
  const LessonContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Markdown(data: content),
      ),
    );
  }
}
