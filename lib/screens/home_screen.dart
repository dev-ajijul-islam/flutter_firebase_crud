import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_practice/app.dart';
import 'package:firebase_crud_practice/data/models/match_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final TextEditingController _team1ScoreController = TextEditingController();
  final TextEditingController _team2ScoreController = TextEditingController();

  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).primary,
        foregroundColor: Colors.white,
        title: Text("Firebase crud"),
        actions: [
          Switch(
            value: FirebaseCrud.isLight,
            onChanged: (value) {
              FirebaseCrud.isLight = value;
              setState(() {});
              widget.onThemeChanged();
            },
            activeTrackColor: Colors.grey.shade900,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _createMatchDialog,
        child: Icon(Icons.add),
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
                  asyncSnapshot.data!.docs[index].data(),
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

  void _createMatchDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          Future<void> createMatch() async {
            isCreating = true;
            setState(() {});
            final match = MatchModel(
              team2: _team2Controller.text,
              team1Score: int.parse(_team1ScoreController.text),
              team2Score: int.parse(_team2ScoreController.text),
              isRunning: true,
              winner: "",
              team1: _team1Controller.text,
            );
            try {
              await _firestore.collection("football").doc().set(match.toJson());
              debugPrint("Match created successfully");
            } catch (e) {
              debugPrint("Create match failed");
            } finally {
              isCreating = false;
              setState(() {});
            }
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Create match"),

            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  mainAxisSize: .min,
                  children: [
                    TextFormField(
                      controller: _team1Controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Team 1 name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Team 1 name"),
                    ),
                    TextFormField(
                      controller: _team2Controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Team 2 name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Team 2 name"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _team1ScoreController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Team 1 score';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Team 1 score"),
                    ),
                    TextFormField(
                      controller: _team2ScoreController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Team 2 score';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Team 2 score"),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(10),
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createMatch();
                          }
                        },
                        child: isCreating
                            ? Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text("Create Match"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
