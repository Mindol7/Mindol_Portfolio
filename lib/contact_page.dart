import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore_for_file: prefer_const_constructors

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Me'),
        backgroundColor: Color(0xFF0288D1), // 상단 메뉴바 색상 변경
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF1E1E2C), // 페이지 배경색 변경
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/Image/Minhyuk_selfie.jpg',
                      fit: BoxFit.contain,
                      height: 400,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Reach out to me!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'I am available on almost every social media platform.\nYou want to discuss a project or just want to say hi? My Inbox is always open for you.',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.github,
                        size: 50, color: Colors.white), // 아이콘 색상 변경
                    onPressed: () {
                      _launchURL('https://github.com/Mindol7');
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram,
                        size: 50, color: Colors.pink),
                    onPressed: () {
                      _launchURL('https://www.instagram.com/jo_mmin/');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                color: Color(0xFF3E4E5E), // 컨테이너 배경색 변경
                child: Column(
                  children: [
                    const Text(
                      "Let's connect and build something together!",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text('Say Hello 👋'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0288D1), // 버튼 배경색 변경
                        foregroundColor: Colors.white, // 버튼 텍스트 색상 변경
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/Image/connection.svg',
                fit: BoxFit.cover,
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
