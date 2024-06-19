// answers_page.dart

import 'package:flutter/material.dart';
import 'question.dart';

class AnswersPage extends StatefulWidget {
  final Question question;

  const AnswersPage({super.key, required this.question});

  @override
  _AnswersPageState createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.question.answer != null) {
      _answerController.text = widget.question.answer!;
    }
  }

  void _submitAnswer() {
    setState(() {
      widget.question.answer = _answerController.text;
    });
    Navigator.of(context).pop(widget.question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answers Page'),
        backgroundColor: Color(0xFF0288D1),
      ),
      backgroundColor: Color(0xFF1E1E2C),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Question:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              widget.question.questionText,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Professor\'s Answer',
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
              onPressed: _submitAnswer,
              child: Text('Submit Answer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
