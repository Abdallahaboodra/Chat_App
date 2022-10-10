import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScolarChat());
}

class ScolarChat extends StatelessWidget {
  const ScolarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LogInPage(),
      routes: {
        RegsterPage.id: (context) {
          return const RegsterPage();
        },
        ChatPage.id: (context) {
          return const ChatPage();
        }
      },
    );
  }
}
