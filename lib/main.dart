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
      drawer: const CategoriesScreen(), 
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
            onTap: email['sender'] == 'GitLab'
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EmailDetailScreen(email: email)),
              );
            }
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Это письмо пока не реализовано')),
              );
            },
          );
        },
      ),
    );
  }
}

class EmailDetailScreen extends StatelessWidget {
  final Map<String, String> email;
  const EmailDetailScreen({super.key, required this.email});

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(title, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email['title']!),
        actions: const [Icon(Icons.delete_outline), SizedBox(width: 12), Icon(Icons.mail_outline), SizedBox(width: 12)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(radius: 24, child: Icon(Icons.person)),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GitLab", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("to me", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  infoRow("Hostname", "gitlab.com"),
                  infoRow("User", "Ivan Ivanov"),
                  infoRow("IP Address", "88.216.214.163"),
                  infoRow("Location", "Stockholm, Sweden"),
                  infoRow("Time", "2026-04-10 12:20:53 UTC"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("If you recently signed in...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("Ответить"))),
            const SizedBox(width: 10),
            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Переслать"))),
          ],
        ),
      ),
    );
  }
}
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( // Оборачиваем в Drawer для корректного отображения
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(child: Text("Gmail", style: TextStyle(fontSize: 20))),
          ListTile(title: Text("Несортированные")),
          ListTile(title: Text("Промоакции")),
          ListTile(title: Text("Соцсети")),
          ListTile(title: Text("Оповещения")),
          Divider(),
          ListTile(title: Text("Спам")),
          ListTile(title: Text("Корзина")),
        ],
      ),
    );
  }
}