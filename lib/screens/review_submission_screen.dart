import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewSubmissionScreen extends StatefulWidget {
  final String paperId;

  ReviewSubmissionScreen({required this.paperId});

  @override
  _ReviewSubmissionScreenState createState() => _ReviewSubmissionScreenState();
}

class _ReviewSubmissionScreenState extends State<ReviewSubmissionScreen> {
  final _commentsController = TextEditingController();
  final _ratingController = TextEditingController();

  Future<void> _submitReview() async {
    await FirebaseFirestore.instance.collection('reviews').add({
      'paperId': widget.paperId,
      'reviewerId': FirebaseAuth.instance.currentUser?.uid,
      'comments': _commentsController.text,
      'rating': _ratingController.text,
      'status': 'submitted',
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review submitted successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Review')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _commentsController, decoration: InputDecoration(hintText: 'Comments')),
            TextField(controller: _ratingController, decoration: InputDecoration(hintText: 'Rating')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _submitReview, child: Text('Submit Review')),
          ],
        ),
      ),
    );
  }
}
