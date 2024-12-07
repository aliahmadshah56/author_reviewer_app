import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewerDashboardScreen extends StatefulWidget {
  @override
  _ReviewerDashboardScreenState createState() => _ReviewerDashboardScreenState();
}

class _ReviewerDashboardScreenState extends State<ReviewerDashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // To store data from Firestore
  List<dynamic> reviewers = [];

  @override
  void initState() {
    super.initState();
    _fetchReviewersData();
  }

  // Fetch reviewers data from Firestore
  Future<void> _fetchReviewersData() async {
    try {
      // Query Firestore to get the list of reviewers
      QuerySnapshot querySnapshot = await _firestore.collection('reviewers').get();

      // Check if the query snapshot contains documents
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          reviewers = querySnapshot.docs.map((doc) => doc.data()).toList();
        });
      } else {
        setState(() {
          reviewers = [];
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle error if necessary
      setState(() {
        reviewers = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviewer Dashboard')),
      body: reviewers.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator
          : ListView.builder(
        itemCount: reviewers.length,
        itemBuilder: (context, index) {
          var reviewer = reviewers[index];
          return ListTile(
            title: Text(reviewer['name'] ?? 'No Name'),
            subtitle: Text(reviewer['specialization'] ?? 'No Specialization'),
          );
        },
      ),
    );
  }
}
