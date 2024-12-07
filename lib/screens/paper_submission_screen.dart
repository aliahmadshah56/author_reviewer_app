import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaperSubmissionScreen extends StatefulWidget {
  @override
  _PaperSubmissionScreenState createState() => _PaperSubmissionScreenState();
}

class _PaperSubmissionScreenState extends State<PaperSubmissionScreen> {
  final _titleController = TextEditingController();
  final _abstractController = TextEditingController();
  final _keywordsController = TextEditingController();

  Future<void> _submitPaper() async {
    await FirebaseFirestore.instance.collection('papers').add({
      'title': _titleController.text,
      'abstract': _abstractController.text,
      'keywords': _keywordsController.text.split(','),
      'authorId': FirebaseAuth.instance.currentUser?.uid,
      'status': 'submitted',
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paper submitted successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Paper')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(hintText: 'Paper Title')),
            TextField(controller: _abstractController, decoration: InputDecoration(hintText: 'Abstract')),
            TextField(controller: _keywordsController, decoration: InputDecoration(hintText: 'Keywords (comma separated)')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _submitPaper, child: Text('Submit Paper')),
          ],
        ),
      ),
    );
  }
}
