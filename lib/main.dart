import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1C1B1F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C1B1F),
          elevation: 0,
        ),
      ),
      home: const InboxScreen(),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  final List<Map<String, String>> emails = const [
    {"sender": "GitLab", "title": "gitlab.com sign-in from new location", "time": "10:14"},
    {"sender": "LinkedIn", "title": "Security notification", "time": "9 Apr"},
    {"sender": "App Store", "title": "Your build has issues", "time": "00:22"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Почта")),
      // Drawer (боковое меню) пока закомментирован, так как класс еще не создан
      // drawer: const CategoriesScreen(), 
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: emails.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final email = emails[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[800],
              child: Text(email['sender']![0], style: const TextStyle(color: Colors.white)),
            ),
            title: Text(email['sender']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(email['title']!, style: const TextStyle(color: Colors.grey)),
            trailing: Text(email['time']!, style: const TextStyle(color: Colors.grey)),
          );
        },
      ),
    );
  }
}