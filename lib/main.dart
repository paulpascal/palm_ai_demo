import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:palm_ai_demo/app.dart';

import 'package:palm_ai_demo/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencyInjection();
  runApp(const PalmAiDemoApp());
}
