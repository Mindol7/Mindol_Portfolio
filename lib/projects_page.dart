import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore_for_file: prefer_const_constructors

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Color(0xFF0288D1), 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF1E1E2C), // 페이지 배경색 설정
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SvgPicture.asset(
                      'assets/Image/Project.svg',
                      height: 250, 
                      width: 250, 
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Projects',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white), 
                          ),
                          SizedBox(height: 10),
                          Text(
                            'My project mainly included projects that I conducted during the course of the lecture.',
                            style: TextStyle(fontSize: 16, color: Colors.white70), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ProjectCard(
                title: 'Computer Architecture',
                description:
                    'This project is a computer architecture lecture, and I implemented the entire computer structure. This project has four projects: Calculator, Single-Cycle, Pipeline-MIPS, and Cache.',
                icon: FontAwesomeIcons.c,
                url: 'https://github.com/Mindol7/Computer_Architecture',
              ),
              ProjectCard(
                title: 'C++ Study Project',
                description:
                    'This project covered all the study courses when I first studied C++ Programming. In the final study, I finished studying c++ by implementing the bank account service project.',
                icon: FontAwesomeIcons.cuttlefish,
                url: 'https://github.com/Mindol7/Cplusplus_Programming',
              ),
              ProjectCard(
                title: 'Car Sharing Accident Analyzing Program',
                description:
                    'This project is a program that determines whether or not to rent a vehicle through a score allocation system based on accident analysis on shared vehicle services. It was implemented through pandas and python.',
                icon: FontAwesomeIcons.python,
                url: 'https://github.com/Mindol7/CarSharingAccidentAnalysisProgram',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String url;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.url,
  });

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
    return Card(
      color: Color(0xFF2E2E3C), 
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: FaIcon(icon, size: 40, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), 
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.white70), 
        ),
        onTap: () {
          _launchURL(url);
        },
      ),
    );
  }
}
