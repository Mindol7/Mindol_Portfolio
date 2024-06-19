import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class GPACalculatorPage extends StatefulWidget {
  const GPACalculatorPage({super.key});

  @override
  _GPACalculatorPageState createState() => _GPACalculatorPageState();
}

class _GPACalculatorPageState extends State<GPACalculatorPage> {
  final List<Course> _courses = [];
  double _targetGPA = 0.0;
  int _courseCount = 0;
  bool _showCourseFields = false;

  final TextEditingController _courseCountController = TextEditingController();

  void _initializeCourses() {
    setState(() {
      _courses.clear();
      for (int i = 0; i < _courseCount; i++) {
        _courses.add(Course());
      }
      _showCourseFields = true;
    });
  }

  double _calculateTotalCredits() {
    return _courses.fold(0.0, (total, course) => total + course.credits);
  }

  double _calculateGPA() {
    double totalCredits = _calculateTotalCredits();
    if (_courses.isEmpty || totalCredits == 0.0) return 0.0;
    double totalQualityPoints =
        _courses.fold(0.0, (total, course) => total + (course.gpa * course.credits));
    return totalQualityPoints / totalCredits;
  }

  void _showResults() {
    double calculatedGPA = _calculateGPA();
    String message;
    String imagePath;

    if (calculatedGPA >= _targetGPA) {
      message = 'Congratulations! You have achieved your goal grade. Keep up the good work and achieve all your goals!';
      imagePath = 'assets/Image/congratulations.png';
    } else {
      message = 'Next time, let\'s cheer up and work harder so that you can achieve your goals!';
      imagePath = 'assets/Image/encouragement.png';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GPA Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                height: 150, 
                child: Image.asset(imagePath),
              ),
              const SizedBox(height: 20),
              Text(message),
              const SizedBox(height: 20),
              Text(
                'Calculated GPA: ${calculatedGPA.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator'),
        backgroundColor: Color(0xFF0288D1), // 메뉴바 색상 설정
      ),
      backgroundColor: Color(0xFF1E1E2C), // 페이지 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_showCourseFields) ...[
              TextField(
                controller: _courseCountController,
                decoration: InputDecoration(
                  labelText: 'Enter number of courses',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _courseCount = int.tryParse(_courseCountController.text) ?? 0;
                    if (_courseCount > 0) {
                      _initializeCourses();
                    }
                  });
                },
                child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0288D1), // 버튼 배경색 설정
                ),
              ),
            ] else ...[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Target GPA',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _targetGPA = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: Colors.white,
                      child: ListTile(
                        title: TextField(
                          decoration: InputDecoration(hintText: 'Course Name'),
                          onChanged: (value) {
                            setState(() {
                              _courses[index].name = value;
                            });
                          },
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(hintText: 'Credits'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        _courses[index].credits = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(hintText: 'GPA'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        _courses[index].gpa = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showResults,
                child: Text('Calculate GPA'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0288D1),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Course {
  String name = '';
  double credits = 0.0;
  double gpa = 0.0;
}
