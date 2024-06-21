// void main() {
// //
//   String str = "";

//   // Regular expression to match module titles
//   RegExp moduleExp = RegExp(r'\*\*Module \d+: [^\*]+\*\*');
//   // Regular expression to match lesson titles including the title
//   RegExp lessonExp = RegExp(r'\* \*\*Lesson .+?\n');

//   // Find all module and lesson matches
//   Iterable<Match> moduleMatches = moduleExp.allMatches(str);
//   Iterable<Match> lessonMatches = lessonExp.allMatches(str);

//   List<String> modules =
//       moduleMatches.map((match) => match[0] ?? "default value").toList();

//   List<String> cleanModules = [];
//   for (int i = 0; i < modules.length; i++) {
//     cleanModules.add(modules[i].replaceAll('*', ''));
//   }

//   List<String> lessons =
//       lessonMatches.map((match) => match[0] ?? "default value").toList();

//   List<String> cleanLessons = [];
//   for (int i = 0; i < lessons.length; i++) {
//     String cleanedLesson = lessons[i].replaceAll('*', '').replaceAll('\n', '');
//     // Check if the string is not empty to avoid errors
//     if (cleanedLesson.isNotEmpty) {
//       cleanLessons
//           .add(cleanedLesson.substring(1)); // Remove the first character
//     }
//   }

//   print('Module Titles:');
//   for (var title in cleanModules) {
//     print(title); // Now this will print cleaned module titles
//   }

//   print('Lessons:');
//   for (var title in cleanLessons) {
//     print(title);
//   }
// }

// // // import 'package:flutter/material.dart';
// // import 'package:curriculi/models/data.dart';

// // class ContentParser {
// //   static List<Module> parseContent(String content) {
// //     final modulePattern =
// //         RegExp(r"^\*\*Module \d+: (.+?)\*\*", multiLine: true);
// //     final lessonPattern =
// //         RegExp(r"\* \*\*Lesson \d+\.\d+: (.+?)\*\*", multiLine: true);

// //     List<Module> modules = [];

// //     final moduleMatches = modulePattern.allMatches(content);
// //     for (var moduleMatch in moduleMatches) {
// //       String moduleTitle = moduleMatch.group(1)!;
// //       int start = moduleMatch.start;
// //       int end = content.length;

// //       if (moduleMatch != moduleMatches.last) {
// //         end = moduleMatches
// //             .elementAt(moduleMatches.toList().indexOf(moduleMatch) + 1)
// //             .start;
// //       }

// //       String moduleContent = content.substring(start, end);
// //       List<Lesson> lessons = [];

// //       final lessonMatches = lessonPattern.allMatches(moduleContent);
// //       for (var lessonMatch in lessonMatches) {
// //         String lessonTitle = lessonMatch.group(1)!;
// //         lessons.add(Lesson(lessonTitle));
// //       }

// //       modules.add(Module(moduleTitle, lessons));
// //     }

// //     return modules;
// //   }
// // }

// // String str = """**Module 1: Introduction to Flutter and Dart** (4 hours)

// // * **Lesson 1.1:** What is Flutter? (1 hour)
// //     * Summary: Introduction to Flutter, its advantages, and cross-platform development.
// //     * Learning Outcome: Understand the benefits and use cases of Flutter.
// //     * Activity: Install Flutter and set up development environment.
// // * **Lesson 1.2:** Dart Programming Basics (3 hours)
// //     * Summary: Data types, variables, operators, control flow, functions, and classes in Dart.
// //     * Learning Outcome: Write basic Dart programs.
// //     * Activity: Complete a set of coding exercises on Dart fundamentals.

// // **Module 2: Building Layouts and UI in Flutter** (8 hours)

// // * **Lesson 2.1:** Flutter Widgets: Building Blocks of UI (2 hours)
// //     * Summary: Introduction to widgets, types of widgets (Stateless & Stateful), and basic widget properties.
// //     * Learning Outcome: Understand the widget tree concept and create simple UI layouts.
// //     * Activity: Build a basic user profile screen with various widgets.
// // * **Lesson 2.2:** Layout Widgets and Responsive Design (3 hours)
// //     * Summary: Using layout widgets like Row, Column, Stack, Expanded, and Container to create complex UI.
// // """;


// // 480-353-6949