import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore_for_file: prefer_const_constructors

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        backgroundColor: Color(0xFF0288D1), 
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF1E1E2C), // 페이지 배경색 설정
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/Image/Skills.svg',
                      fit: BoxFit.contain,
                      height: 250,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Proficiency',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white), 
                          ),
                          SizedBox(height: 20),
                          SkillBar(
                            iconData: 'logos:c-plusplus',
                            skillName: 'C++',
                            proficiency: 0.85,
                          ),
                          SizedBox(height: 10),
                          SkillBar(
                            iconData: 'logos:c',
                            skillName: 'C',
                            proficiency: 0.80,
                          ),
                          SizedBox(height: 10),
                          SkillBar(
                            iconData: 'logos:python',
                            skillName: 'Python',
                            proficiency: 0.75, 
                          ),
                          SizedBox(height: 10),
                          SkillBar(
                            iconData: 'logos:assembla',
                            skillName: 'Assembly',
                            proficiency: 0.70,
                          ),
                          SizedBox(height: 10),
                          SkillBar(
                            iconData: 'logos:git',
                            skillName: 'Git',
                            proficiency: 0.75,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Made with ❤️ by Minhyuk Cho',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillBar extends StatelessWidget {
  final String iconData;
  final String skillName;
  final double proficiency;

  const SkillBar({
    super.key,
    required this.iconData,
    required this.skillName,
    required this.proficiency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Iconify로 아이콘 표시
        Iconify(
          iconData,
          size: 40,
        ),
        const SizedBox(width: 10),
        Text(
          skillName,
          style: const TextStyle(fontSize: 18, color: Colors.white), 
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 20,
                  color: Colors.grey[300],
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: proficiency),
                  duration: Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * value,
                      color: Colors.deepPurple,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '${(value * 100).toInt()}%',
                            style: TextStyle(color: Colors.white), 
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 아이콘을 표시하기 위한 위젯
class Iconify extends StatelessWidget {
  final String iconData;
  final double size;

  const Iconify(this.iconData, {this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      'https://api.iconify.design/$iconData.svg',
      height: size,
      width: size,
    );
  }
}
