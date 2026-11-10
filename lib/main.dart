import 'package:flutter/material.dart';

void main() {
  runApp(const SerioApp());
}

class SerioApp extends StatelessWidget {
  const SerioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Serio',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const RankingPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: "Ranking",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int punkte = 0;

  final List<Map<String, dynamic>> aufgaben = [
    {"titel": "2h Lernen", "done": false},
    {"titel": "Fitness", "done": false},
    {"titel": "Buch lesen", "done": false},
  ];

  void toggleAufgabe(int index, bool? value) {
    setState(() {
      aufgaben[index]["done"] = value;
      punkte = aufgaben.where((a) => a["done"]).length * 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serio"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            aufgaben.add({
              "titel": "Neue Aufgabe",
              "done": false,
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "$punkte",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Punkte"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: aufgaben.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(aufgaben[index]["titel"]),
                    value: aufgaben[index]["done"],
                    onChanged: (value) {
                      toggleAufgabe(index, value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.looks_one),
              title: Text("Max"),
              trailing: Text("260"),
            ),
            ListTile(
              leading: Icon(Icons.looks_two),
              title: Text("Yunus"),
              trailing: Text("220"),
            ),
            ListTile(
              leading: Icon(Icons.looks_3),
              title: Text("Tim"),
              trailing: Text("180"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(height: 20),
            Text(
              "Yunus",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("Zuverlässigkeit: 100%"),
            Text("Streak: 0 Tage"),
          ],
        ),
      ),
    );
  }
}