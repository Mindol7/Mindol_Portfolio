import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: prefer_const_constructors

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
        backgroundColor: Color(0xFF0288D1), // 상단 메뉴바 색상 설정
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 이전 페이지로 돌아가기
            },
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Color(0xFF1E1E2C), // 페이지 배경색 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              SvgPicture.asset('assets/Image/Programming.svg', height: 250),
              const SizedBox(height: 20),
              _buildExperienceSection(),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Certifications',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white, 
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildCertifications(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Experiences',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.white, 
          ),
        ),
        SizedBox(height: 10),
        ExperienceCard(
          title: 'Dankook University, Jukjeon',
          period: '2020 - Present',
          degree: 'Mobile System Engineering, MSE',
          description:
              'I have studied engineering subjects like Data Struct, Computer Architecture, SW Security, System and Signal, Computer Network, etc.',
          gpa: '4.24/4.5',
          url: 'http://www.dankook.ac.kr/',
        ),
        ExperienceCard(
          title: 'Undergraduate Research Student, CSOS Lab',
          period: '2024.03 - Present',
          degree: 'Advisor Professor, Cho-Sung-Jae',
          description:
              'I have researched Digital Forensic, and been writing a thesis.',
          progress: '60%',
          url: 'http://securesw.dankook.ac.kr/',
        ),
        ExperienceCard(
          title: '66th Division Korean Army Sgt. Maturity',
          period: '2021.08.02 - 2023.02.01',
          description: 'Network Operations/Maintenance soldier',
          progress: '100%',
        ),
        ExperienceCard(
          title: 'Coding Volunteer, Taesung-Highschool',
          period: '2021.04',
          description:
              'I conducted coding education volunteer for 2nd graders of high school.',
          progress: '100%',
        ),
      ],
    );
  }

  Widget _buildCertifications() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        CertificationCard(
          title: 'Craftsman Information Processing',
          subtitle: '- HREK',
          imagePath: 'assets/Image/info_pro.png',
          url:
              'https://www.q-net.or.kr/crf005.do?id=crf00505&gSite=Q&gId=&jmCd=6921&examInstiCd=1',
        ),
        CertificationCard(
          title: 'Linux Master 2nd Grade Certified',
          subtitle: '- by KAIT',
          imagePath: 'assets/Image/linux_master.png',
          url: 'https://www.ihd.or.kr/introducesubject1.do',
        ),
      ],
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final String title;
  final String period;
  final String? degree;
  final String description;
  final String? gpa;
  final String? progress;
  final String? url;

  const ExperienceCard({
    super.key,
    required this.title,
    required this.period,
    this.degree,
    required this.description,
    this.gpa,
    this.progress,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2A2E43), // 카드 배경색 설정
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, size: 24, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white, // 제목 색상을 흰색으로 설정
                  ),
                ),
              ],
            ),
            Text(
              period,
              style: const TextStyle(color: Colors.grey),
            ),
            if (degree != null)
              Text(
                degree!,
                style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(color: Colors.white), // 설명 텍스트 색상 설정
            ),
            if (gpa != null)
              Text(
                'GPA: $gpa',
                style: const TextStyle(color: Colors.white), // GPA 텍스트 색상 설정
              ),
            if (progress != null)
              Text(
                'Progress: $progress',
                style: const TextStyle(color: Colors.white), // 진행률 텍스트 색상 설정
              ),
            if (url != null)
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse(url!));
                },
                child: const Text('Website'),
              ),
          ],
        ),
      ),
    );
  }
}

class CertificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String url;

  const CertificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Card(
        color: Color(0xFF2A2E43), 
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Image.asset(imagePath, height: 100, width: 100, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.white, 
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
