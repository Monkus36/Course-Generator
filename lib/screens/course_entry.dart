// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:curriculi/screens/content.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CourseEntry extends StatefulWidget {
  const CourseEntry({super.key});

  @override
  State<CourseEntry> createState() => _CourseEntryState();
}

class _CourseEntryState extends State<CourseEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool showSpinner = false;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   ContentScreen(),
  //   RandomWordScreen(),
  //   SearchScreen(),
  //   SavedScreen(),
  // ];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      upperBound: 1.0,
    );

    animation = ColorTween(begin: Colors.white, end: const Color(0xff191825))
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).viewInsets;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        // // body: _widgetOptions.elementAt(_selectedIndex),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.calendar_today),
        //       label: 'Word of the Day',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shuffle),
        //       label: 'Random Word',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.search),
        //       label: 'Search',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.save),
        //       label: 'Saved Words', // This is your new navigation item
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: const Color(0xffff00d0),
        //   unselectedItemColor: Colors.white,
        //   onTap: _onItemTapped,
        //   backgroundColor: const Color(0xff3C0753),
        // ),

        // backgroundColor: const Color(0xff191825),
        backgroundColor: animation.value,

        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: padding.bottom),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 75.0, left: 5.0, bottom: 20.0),
                child: AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText(
                    'Course Generator',
                    textStyle: GoogleFonts.oswald(
                      color: Color(0xff865DFF),
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                    ),
                    cursor: "|",
                    speed: const Duration(
                        milliseconds:
                            75), // Larger values slow down the animation
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Center(
                  child: Image.asset(
                    'images/newSphere2.png',
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: const Color(0xff865DFF),
                  style: const TextStyle(color: Color(0xff865DFF)),
                  decoration: const InputDecoration(
                    labelText: 'What do you want to learn about?',
                    labelStyle: TextStyle(color: Color(0xff865DFF)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff865DFF)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff865DFF)),
                    ),
                  ),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) async {
                    setState(() {
                      showSpinner = true;
                    });

                    // const apiKey = "AIzaSyANtTEQ_VAiH9kmwwW3u0OlC19VT7fzvkA";
                    final apiKey = dotenv.env['GEMINI_KEY']!;
                    final model = GenerativeModel(
                        model: 'gemini-1.5-pro', apiKey: apiKey);
                    final content = [
                      Content.text(
                          """Generate a comprehensive curriculum for a course about $value. Partition the course into modules and lessons.
                          Do not provide a 'note' section at the end. You can provide a learning outcome section.
                          Each module should have at least 3-5 lessons.
                          
                          Ensure that the modules and lessons portion of your response is in the following format, 
                          considering markdown. It's very important to maintain the format in this example:
                          
                          **Module 2: Building Layouts and UI in Flutter**

                          * **Lesson 2.1:** Flutter Widgets: Building Blocks of UI
                          * Introduction to widgets, types of widgets (Stateless & Stateful), and basic widget properties.
                          * potentially additional descriptive points about the lesson.""")
                    ];
                    final response = await model.generateContent(content);

                    if (response.text != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentScreen(
                                content: response.text!, courseTitle: value),
                          ));
                    } else {
                      print("No content received");
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
