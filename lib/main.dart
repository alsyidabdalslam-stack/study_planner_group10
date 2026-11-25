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
            Text(value.toString(), style: TextStyle(fontSize: 24)),
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
    for (var goal in goals) {
      total = total + (goal['hours'] as int);
    }
    return total;
  }

  int getCompleted() {
    int count = 0;
    for (var goal in goals) {
      if (goal['done'] == true) count = count + 1;
    }
    return count;
  }

  int getRemaining() {
    return goals.length - getCompleted();
  }

  void openAddGoalScreen() async {
    final newGoal = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGoalScreen()),
    );

    if (newGoal != null) {
      setState(() {
        goals.add(newGoal);
      });
    }
  }

  void toggleGoal(int index) {
    setState(() {
      goals[index]['done'] = !goals[index]['done'];
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
                onChanged: (value) => toggleGoal(index),
              ),
              title: Text(
                goals[index]['subject'],
                style: TextStyle(
                  decoration: goals[index]['done']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text('${goals[index]['hours']} hours'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteGoal(index),
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
        onPressed: openAddGoalScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddGoalScreen extends StatefulWidget {
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  String? subjectError;
  String? hoursError;
  void dispose() {
    subjectController.dispose();
    hoursController.dispose();
    super.dispose();
  }

  void saveGoal() {
    String subject = subjectController.text.trim();
    int? hours = int.tryParse(hoursController.text.trim());

    setState(() {
      subjectError = subject.isEmpty ? 'Enter a subject' : null;
      hoursError = (hours == null || hours <= 0) ? 'Enter hours above 0' : null;
    });

    if (subjectError == null && hoursError == null) {
      Navigator.pop(context, {
        'subject': subject,
        'hours': hours,
        'done': false,
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add goal')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                errorText: subjectError,
              ),
            ),
            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hours',
                errorText: hoursError,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveGoal, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
