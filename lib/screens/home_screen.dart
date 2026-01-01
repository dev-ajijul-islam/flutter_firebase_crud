import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_practice/data/models/match_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text("Firebase crud"),
      ),
      body: StreamBuilder(
        stream: _firestore.collection("football").snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            Center(child: Text(asyncSnapshot.error.toString()));
          }
          if (asyncSnapshot.hasData) {
            return ListView.separated(
              padding: .all(20),
              itemBuilder: (context, index) {
                final match = MatchModel.fromJson(
                  asyncSnapshot.data!.docs[index].data()
                );
                return ListTile(
                  leading: CircleAvatar(
                    radius: 5,
                    backgroundColor: match.isRunning
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text("${match.team1} vs ${match.team2}"),
                  subtitle: Text(
                    (!match.isRunning && match.team1Score > match.team2Score)
                        ? match.team1
                        : match.team2,
                  ),
                  trailing: Text(
                    "${match.team1Score} : ${match.team2Score}",
                    style: TextTheme.of(context).titleMedium,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: asyncSnapshot.data!.docs.length,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
