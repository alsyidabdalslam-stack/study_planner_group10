import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'My Study Planner', home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // LOGIC: data (list of maps: subject, hours, done)
  final List<Map<String, dynamic>> goals = [
    {'subject': 'Mathematics', 'hours': 5, 'done': false},
    {'subject': 'Physics', 'hours': 3, 'done': false},
  ];

  // LOGIC: add a sample goal
  void addSampleGoal() {
    setState(() {
      goals.add({
        'subject': 'New goal ${goals.length + 1}',
        'hours': 2,
        'done': false,
      });
    });
  }

  // LOGIC: toggle done / not done
  void toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !(goals[index]['done'] as bool);
    });
  }

  // LOGIC: delete a goal
  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: AppBar
      appBar: AppBar(title: const Text('My Study Planner')),
      // STATIC: list container
      body: ListView.builder(
        // CONNECTION 1: UI reads the LOGIC data
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          final done = goal['done'] as bool;
          return Card(
            child: ListTile(
              leading: Checkbox(
                value: done,
                // CONNECTION 2: UI calls the LOGIC functions
                onChanged: (_) => toggleGoal(index),
              ),
              title: Text(
                goal['subject'],
                style: TextStyle(
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? Colors.grey : null,
                ),
              ),
              subtitle: Text('${goal['hours']} hours'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteGoal(index),
              ),
              onTap: () => toggleGoal(index),
            ),
          );
        },
      ),
      // STATIC: floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: addSampleGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
