import 'package:firebase_crud_practice/app.dart';
import 'package:firebase_crud_practice/services/fcm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmService.initialize();
  runApp(FirebaseCrud());
}
