import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: prefer_const_constructors

import 'education_page.dart';
import 'skills_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';
import 'about_page.dart';
import 'gpa_calculator_page.dart'; 
import 'live_lecture_qna_page.dart';
import 'answers_page.dart';
import 'question.dart';

void main() {
  runApp(const MyIntroApp());
}

class MyIntroApp extends StatelessWidget {
  const MyIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhyuk Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
          bodyMedium: TextStyle(fontFamily: 'Montserrat'),
          headlineLarge: TextStyle(fontFamily: 'Arizonia', fontSize: 48),
          headlineSmall: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/about': (context) => const AboutPage(),
        '/education': (context) => const EducationPage(),
        '/skills': (context) => const SkillsPage(),
        '/projects': (context) => const ProjectsPage(),
        '/contact': (context) => const ContactPage(),
        '/gpa_calculator': (context) =>
            const GPACalculatorPage(),
        '/live_lecture_qna': (context) => const LiveLectureQnAPage(),
      },
    );
  }
}

// 홈 페이지 위젯
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2C),
      appBar: AppBar(
        title: Text('Minhyuk Cho',
            style: TextStyle(
                color: Colors.white, fontFamily: "Lovely Home", fontSize: 40)),
        backgroundColor: Color(0xFF0288D1), 
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            child: const Text('About',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/education');
            },
            child: const Text('Education',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/skills');
            },
            child: const Text('Skills',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/projects');
            },
            child: const Text('Projects',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
            child: const Text('Contact Me',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              _showGPAConfirmationDialog(
                  context); 
            },
            child: const Text('GPA Calculator',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              _showQnAConfirmationDialog(
                  context); 
            },
            child: const Text('Live Lecture QnA',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: const [
              // 프로필 섹션
              ProfileSection(),
              // What I Do 섹션
              WhatIDoSection(),
              // 푸터 섹션
              Footer(),
            ],
          ),
        ),
      ),
    );
  }

  void _showGPAConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GPA Calculator'),
          content: Text('Do you want to run the GPA Calculator app?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                    context, '/gpa_calculator'); 
              },
            ),
          ],
        );
      },
    );
  }

  void _showQnAConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Live Lecture QnA'),
          content: Text('Do you want to run the Live Lecture QnA app?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.pushNamed(
                    context, '/live_lecture_qna'); 
              },
            ),
          ],
        );
      },
    );
  }
}

// 프로필 섹션 위젯
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/Image/Minhyuk.jpg'),
          ),
          const SizedBox(height: 20),
          Text(
            "Hello I'm Cho Minhyuk",
            style: TextStyle(
                fontFamily: 'Raleway', fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            "I am a college student who wants to become a security expert",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Raleway', fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram,
                    color: Colors.pinkAccent),
                onPressed: () {
                  _launchURL('https://www.instagram.com/jo_mmin/');
                },
              ),
              IconButton(
                icon:
                    const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                onPressed: () {
                  _launchURL('https://github.com/Mindol7');
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.google,
                    color: Colors.blueAccent),
                onPressed: () {
                  _launchURL('mailto:cgumgek8@gmail.com');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// What I Do 섹션 위젯
class WhatIDoSection extends StatelessWidget {
  const WhatIDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Color(0xFF1E1E2C), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What I Do ?',
            style: TextStyle(
                fontFamily: 'Raleway', fontSize: 40, color: Colors.white),
          ),
          const SizedBox(height: 20),
          FeatureCard(
            title: 'Reverse Engineering',
            description:
                'Reverse Engineering is the process of analyzing a software or hardware system to understand its design or components, and to restore the original design specification or source code.',
            imagePath: 'assets/Image/rev.png',
            icons: const [
              'assets/Image/ollydbg.png',
              'assets/Image/x64dbg.png'
            ],
          ),
          FeatureCard(
            title: 'Digital Forensic',
            description:
                'Digital forensics is the process of backtracking to collect evidence of crime on the Internet. There are various types of digital forensics, such as mobile forensics, memory forensics, network forensics, and window forensics.',
            imagePath: 'assets/Image/forensic.png',
            icons: const [
              'assets/Image/ftk.png',
              'assets/Image/auto.png',
              'assets/Image/encase.png'
            ],
          ),
          FeatureCard(
            title: 'System Hacking',
            description:
                'System hacking is the process of taking over a program\'s root authority by taking over the root authority. I\'m studying buffer overflow, stack overflow, format string attack, etc.',
            imagePath: 'assets/Image/sys_hack.png',
            icons: const [],
          ),
        ],
      ),
    );
  }
}

// Feature 카드 위젯
class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final List<String> icons;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5, 
      color: Color(0xFF2E2E3A), // 카드 배경색
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(imagePath, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.white, // 텍스트 색상
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16, color: Colors.white), // 텍스트 색상
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: icons
                  .map((iconPath) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(iconPath, width: 40, height: 40),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// 푸터 섹션 위젯
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Color(0xFF0288D1), // 푸터 배경색 설정
      child: const Center(
        child: Text(
          'Made with ❤️ by MinHyuk Cho',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
