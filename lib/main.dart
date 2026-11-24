import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'My Study Planner', home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: AppBar with the app title
      appBar: AppBar(title: const Text('My Study Planner')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // STATIC: heading above the list
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'My Goals',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // STATIC: hard-coded goal cards
          Card(
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text('Mathematics'),
              subtitle: Text('5 hours'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text('Physics'),
              subtitle: Text('3 hours'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text('English'),
              subtitle: Text('2 hours'),
            ),
          ),
        ],
      ),
      // STATIC: floating action button (does nothing yet)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
