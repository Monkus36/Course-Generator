import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:curriculi/screens/lesson_content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:curriculi/screens/course_entry.dart';

class Curriculum extends StatefulWidget {
  final String content;
  final String courseTitle;

  const Curriculum(
      {super.key, required this.content, required this.courseTitle});

  @override
  State<Curriculum> createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  List<String> cleanModules = [];
  List<String> cleanLessons = [];

  @override
  void initState() {
    super.initState();
    extractContent();
  }

  void extractContent() {
    RegExp moduleExp = RegExp(r'\*\*Module \d+: [^\*]+\*\*');
    RegExp lessonExp = RegExp(r'\* \*\*Lesson .+?\n');

    // Find all module and lesson matches
    Iterable<Match> moduleMatches = moduleExp.allMatches(widget.content);
    Iterable<Match> lessonMatches = lessonExp.allMatches(widget.content);

    List<String> modules =
        moduleMatches.map((match) => match[0] ?? "default value").toList();

    for (int i = 0; i < modules.length; i++) {
      cleanModules.add(modules[i].replaceAll('*', ''));
    }

    List<String> lessons =
        lessonMatches.map((match) => match[0] ?? "default value").toList();

    for (int i = 0; i < lessons.length; i++) {
      String cleanedLesson =
          lessons[i].replaceAll('*', '').replaceAll('\n', '');
      // Check if the string is not empty to avoid errors
      if (cleanedLesson.isNotEmpty) {
        cleanLessons
            .add(cleanedLesson.substring(1)); // Remove the first character
      }
    }
  }

  void printContent() {
    print(cleanModules);
    print(cleanLessons);
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const CourseEntry()), // Ensure this matches your actual course_entry screen class name
    );
  }

  void navigateToLessonScreen(BuildContext context, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonContent(content: content),
      ),
    );
  }

  Future<String?> generateLessonContent(
      String lessonName, String courseTitle, String title) async {
    final apiKey = dotenv.env['GEMINI_KEY']!;
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
          "Generate $lessonName for the $courseTitle online course in $title")
    ];
    final response = await model.generateContent(content);
    return response.text;
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
        iconTheme: const IconThemeData(
          color: Color(0xff865DFF),
        ),
        title: const Text(
          'Curriculum',
          style: TextStyle(color: Color(0xff865DFF)),
        ),
        backgroundColor: const Color(0xff191825),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff191825),
              ),
              child: Text(
                widget.courseTitle,
                style: const TextStyle(
                  color: Color(0xff865DFF),
                  fontSize: 30,
                ),
              ),
            ),
            for (int i = 0; i < cleanModules.length; i++)
              ModuleTile(
                modNum: i,
                title: cleanModules[i],
                lessons: cleanLessons,
                courseTitle: widget.courseTitle,
                onLessonTap: (content) {
                  navigateToLessonScreen(context, content);
                },
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Markdown(data: widget.content),
      ),
    );
  }
}

class ModuleTile extends StatelessWidget {
  final int modNum;
  final String title;
  final List<String> lessons;
  final String courseTitle;
  final Function(String) onLessonTap;

  const ModuleTile({
    super.key,
    required this.modNum,
    required this.title,
    required this.lessons,
    required this.courseTitle,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> lessonTiles = lessons.where((lesson) {
      return int.parse(lesson[7]) == modNum + 1;
    }).map((lesson) {
      return LessonTile(
        lessonName: lesson,
        title: title,
        courseTitle: courseTitle,
        onLessonTap: onLessonTap,
      );
    }).toList();

    return ExpansionTile(
      title: Text(title),
      children: lessonTiles,
    );
  }
}

class LessonTile extends StatefulWidget {
  final String lessonName;
  final String title;
  final String courseTitle;
  final Function(String) onLessonTap;

  const LessonTile({
    super.key,
    required this.lessonName,
    required this.title,
    required this.courseTitle,
    required this.onLessonTap,
  });

  @override
  State<LessonTile> createState() => _LessonTileState();
}

class _LessonTileState extends State<LessonTile> {
  bool _isLoading = false;
  String? lessonContent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.lessonName),
      trailing: _isLoading ? const CircularProgressIndicator() : null,
      onTap: () async {
        setState(() {
          _isLoading = true;
        });

        lessonContent = await generateLessonContent(
          widget.lessonName,
          widget.courseTitle,
          widget.title,
        );

        setState(() {
          _isLoading = false;
        });

        if (lessonContent != null) {
          widget.onLessonTap(lessonContent!);
        } else {
          print("No content received");
        }
      },
    );
  }

  Future<String?> generateLessonContent(
      String lessonName, String courseTitle, String title) async {
    final apiKey = dotenv.env['GEMINI_KEY']!;
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
          "Generate $lessonName for the $courseTitle online course in $title")
    ];
    final response = await model.generateContent(content);
    return response.text;
  }
}
