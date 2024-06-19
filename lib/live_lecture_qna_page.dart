// live_lecture_qna_page.dart

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; 
import 'dart:typed_data'; 
import 'package:flutter_pdfview/flutter_pdfview.dart'; 
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:html' as html; 
import 'answers_page.dart'; 
import 'question.dart'; 

class LiveLectureQnAPage extends StatefulWidget {
  const LiveLectureQnAPage({super.key});

  @override
  _LiveLectureQnAPageState createState() => _LiveLectureQnAPageState();
}

class _LiveLectureQnAPageState extends State<LiveLectureQnAPage> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _lectureWeekController = TextEditingController();
  final TextEditingController _questionController = TextEditingController(); 
  String? _filePath;
  Uint8List? _fileBytes; // 웹에서 사용할 파일 데이터
  List<Question> _questions = []; // 질문과 답변을 저장하는 리스트

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'ppt', 'pptx'],
      withData: kIsWeb, 
    );
    if (result != null) {
      if (kIsWeb) {
        setState(() {
          _fileBytes = result.files.single.bytes;
        });
      } else {
        setState(() {
          _filePath = result.files.single.path;
        });
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentViewerPage(
            filePath: _filePath,
            fileBytes: _fileBytes,
          ),
        ),
      );
    }
  }

  void _showMessageDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

  void _sendQuestion() {
    String questionText = _questionController.text;
    if (questionText.isNotEmpty) {
      Question question = Question(questionText: questionText);
      setState(() {
        _questions.add(question);
      });
      _questionController.clear();
      _showConfirmationDialog(context, question);
    } else {
      _showMessageDialog(context, 'Error', 'Please enter a question.');
    }
  }

  void _showConfirmationDialog(BuildContext context, Question question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Question Submitted'),
          content: Text('Your question has been submitted. Do you want to view the answers page?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswersPage(
                      question: question,
                    ),
                  ),
                ).then((returnedQuestion) {
                  if (returnedQuestion is Question) {
                    setState(() {
                      int index = _questions.indexOf(returnedQuestion);
                      if (index != -1) {
                        _questions[index] = returnedQuestion;
                      }
                    });
                  }
                });
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
        title: Text('Live Lecture QnA'),
        backgroundColor: Color(0xFF0288D1),
      ),
      backgroundColor: Color(0xFF1E1E2C), // 페이지 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _courseNameController,
              decoration: InputDecoration(
                labelText: 'Course Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lectureWeekController,
              decoration: InputDecoration(
                labelText: 'Lecture Week',
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
              onPressed: _pickFile,
              child: Text('Upload Lecture Material'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1), // 버튼 배경색 설정
              ),
            ),
            if (_filePath != null) ...[
              const SizedBox(height: 20),
              Text('Uploaded File: $_filePath',
                  style: TextStyle(color: Colors.white)),
            ],
            const SizedBox(height: 20),
            TextField(
              controller: _questionController, 
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Enter your question here...',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendQuestion,
              child: Text('Send Question'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1), // 버튼 배경색 설정
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(_questions[index].questionText),
                      subtitle: _questions[index].answer != null
                          ? Text('Answer: ${_questions[index].answer}')
                          : Text('Awaiting answer...'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // 강의 종료 시 어플 종료
              },
              child: Text('End Lecture'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // 버튼 배경색 설정
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentViewerPage extends StatelessWidget {
  final String? filePath;
  final Uint8List? fileBytes;

  const DocumentViewerPage({super.key, this.filePath, this.fileBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Material'),
        backgroundColor: Color(0xFF0288D1), // 메뉴바 색상 설정
      ),
      backgroundColor: Color(0xFF1E1E2C), // 페이지 배경색 설정
      body: Center(
        child: kIsWeb
            ? fileBytes != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PDF viewing in web is not supported directly. Please download the file.',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final base64 = base64Encode(fileBytes!);
                          final url = 'data:application/pdf;base64,$base64';
                          html.AnchorElement(href: url)
                            ..setAttribute('download', 'lecture_material.pdf')
                            ..click();
                        },
                        child: Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0288D1),
                        ),
                      ),
                    ],
                  )
                : Text(
                    'No file selected.',
                    style: TextStyle(color: Colors.white),
                  )
            : filePath != null
                ? PDFView(filePath: filePath!) // 모바일 및 데스크톱의 PDF 파일 보기
                : Text(
                    'No file selected.',
                    style: TextStyle(color: Colors.white),
                  ),
      ),
    );
  }
}
