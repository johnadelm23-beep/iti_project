import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iti_training/core/di/service_locator.dart';
import 'package:iti_training/firebase_options.dart';
import 'package:iti_training/my_app.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: '.env');
    setupServiceLocator();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}
