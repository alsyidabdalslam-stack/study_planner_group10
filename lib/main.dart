import "package:material_ui/material_ui.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(title: 'My study planner', home: HomeScreen());
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final int value;
  SummaryCard(this.title, this.value);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> goals = [
    {'subject': 'mathematics', 'hours': 5, 'done': false},
    {'subject': 'physics', 'hours': 3, 'done': false},
  ];
  int getTotalHours() {
    int total = 0;
    for (int i = 0; i < goals.length; i++) {
      total = total + (goals[i]['hours'] as int);
    }
    return total;
  }

  int getCompleted() {
    int count = 0;
    for (int i = 0; i < goals.length; i++) {
      if (goals[i]['done'] == true) {
        count = count + 1;
      }
    }
    return count;
  }

  int getRemaining() {
    return goals.length - getCompleted();
  }

  void addSampleGoal() {
    setState(() {
      goals.add({
        'subject': 'New goal' + (goals.length + 1).toString(),
        'hours': 2,
        'done': false,
      });
    });
  }

  void toggleGoal(int index) {
    setState(() {
      if (goals[index]['done'] == true) {
        goals[index]['done'] = false;
      } else {
        goals[index]['done'] = true;
      }
    });
  }

  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    Widget listArea;
    if (goals.isEmpty) {
      listArea = Center(
        child: Text('No goals yet. Tap + to add your first one!'),
      );
    } else {
      listArea = ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Checkbox(
                value: goals[index]['done'],
                onChanged: (value) {
                  toggleGoal(index);
                },
              ),
              title: Text(
                goals[index]['subject'],
                style: TextStyle(
                  decoration: goals[index]['done'] == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(goals[index]['hours'].toString() + 'hours'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteGoal(index);
                },
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('My study planner')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: SummaryCard('Total hours', getTotalHours())),
              Expanded(child: SummaryCard('Completed', getCompleted())),
              Expanded(child: SummaryCard('Remaining', getRemaining())),
            ],
          ),
          Expanded(child: listArea),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSampleGoal,
        child: Icon(Icons.add),
      ),
    );
  }
}
