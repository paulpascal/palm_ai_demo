import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_ai_demo/core/core.dart';

import 'src/chat/presentation/presentation.dart';

class PalmAiDemoApp extends StatelessWidget {
  const PalmAiDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palm API 🤝 Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => sl<ChatBloc>(),
        child: const ChatPage(),
      ),
    );
  }
}
