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

  final pages = [
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
  int streak = 5;

  final TextEditingController controller = TextEditingController();

  final List<Map<String, dynamic>> aufgaben = [
    {"titel": "2h lernen", "done": false},
    {"titel": "Fitness", "done": false},
    {"titel": "Buch lesen", "done": false},
  ];

  void toggleAufgabe(int index, bool? value) {
    setState(() {
      aufgaben[index]["done"] = value;
      punkte = aufgaben.where((a) => a["done"] == true).length * 25;
    });
  }

  void aufgabeHinzufuegen() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      aufgaben.add({
        "titel": controller.text,
        "done": false,
      });
    });

    controller.clear();
  }

  void aufgabeLoeschen(int index) {
    setState(() {
      aufgaben.removeAt(index);
      punkte = aufgaben.where((a) => a["done"] == true).length * 25;
    });
  }

  int get level {
    return (punkte ~/ 100) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serio"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Willkommen Yunus 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Level $level",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  Text(
                    "🔥 Streak: $streak Tage",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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

                    const SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: (punkte % 100) / 100,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: "Neue Aufgabe",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: aufgabeHinzufuegen,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: aufgaben.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: aufgaben[index]["done"],
                        onChanged: (value) {
                          toggleAufgabe(index, value);
                        },
                      ),
                      title: Text(
                        aufgaben[index]["titel"],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          aufgabeLoeschen(index);
                        },
                      ),
                    ),
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
        title: const Text("🏆 Ranking"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text("1")),
            title: Text("Max"),
            trailing: Text("1240"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("2")),
            title: Text("Yunus"),
            trailing: Text("980"),
          ),
          ListTile(
            leading: CircleAvatar(child: Text("3")),
            title: Text("Tim"),
            trailing: Text("820"),
          ),
        ],
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
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Yunus",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("Level 3"),
            Text("Zuverlässigkeit: 92%"),
            Text("Freunde: 12"),
            Text("Streak: 5 Tage"),
          ],
        ),
      ),
    );
  }
}