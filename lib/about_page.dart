import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore_for_file: prefer_const_constructors

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Color(0xFF0288D1), // 상단 메뉴바 색상
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Color(0xFF1E1E2C), // 페이지 배경색
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ABOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        AssetImage('assets/Image/Kongee.jpg'), // 프로필 이미지 경로
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "I am an undergraduate student who is majoring in mobile system engineering at Dankook University. I am dreaming of becoming a security expert, especially a student who wants to become a digital forensic expert. Even though I am just an ordinary college student now, if I achieve my small goals step by step, I will surely be reborn as a promising talent in the digital forensic field in five years. I am not just studying security for fun. I am studying security with all my heart. In order to achieve my goal, I am constantly running toward my dream at this moment.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '• Birthday: 14 July 2000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '• Nationality: South Korea',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '• City: Changwoo, Hanam',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '• Email: cgumgek8@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'INTERESTS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: const [
                  InterestCard(
                    title: 'Software Development',
                    icon: FontAwesomeIcons.code,
                    color: Colors.blueAccent,
                  ),
                  InterestCard(
                    title: 'Digital Forensic',
                    icon: FontAwesomeIcons.magnifyingGlass,
                    color: Colors.deepPurpleAccent,
                  ),
                  InterestCard(
                    title: 'Signal And System',
                    icon: FontAwesomeIcons.signal,
                    color: Colors.teal,
                  ),
                  InterestCard(
                    title: 'Computer Network',
                    icon: FontAwesomeIcons.networkWired,
                    color: Colors.green,
                  ),
                  InterestCard(
                    title: 'Hacking',
                    icon: FontAwesomeIcons.userSecret,
                    color: Colors.orangeAccent,
                  ),
                  InterestCard(
                    title: 'Cryptology',
                    icon: FontAwesomeIcons.lock,
                    color: Colors.redAccent,
                  ),
                  InterestCard(
                    title: 'Algorithms',
                    icon: FontAwesomeIcons.sortNumericDown,
                    color: Colors.yellow,
                  ),
                  InterestCard(
                    title: 'Problem Solving',
                    icon: FontAwesomeIcons.brain,
                    color: Colors.indigoAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const InterestCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2E2E3A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FaIcon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
