import 'package:flutter/material.dart';
import 'exercise_1.dart';
import 'exercise_2.dart';
import 'exercise_3.dart';
import 'exercise_4.dart';
import 'exercise_5.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> exercises = [
    {
      "title": "Ex 1: List View",
      "icon": Icons.contacts,
      "screen": Exercise1Screen(),
      "color": Colors.teal,
    },
    {
      "title": "Ex 2: Grid View",
      "icon": Icons.grid_view,
      "screen": Exercise2Screen(),
      "color": Colors.orange,
    },
    {
      "title": "Ex 3: Shared Prefs",
      "icon": Icons.save,
      "screen": Exercise3Screen(),
      "color": Colors.blue,
    },
    {
      "title": "Ex 4: Async/Await",
      "icon": Icons.timer,
      "screen": Exercise4Screen(),
      "color": Colors.indigo,
    },
    {
      "title": "Ex 5: Isolates",
      "icon": Icons.memory,
      "screen": Exercise5Screen(),
      "color": Colors.deepPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab 4: Flutter Advanced UI"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (ctx, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item['color'],
                child: Icon(item['icon'], color: Colors.white),
              ),
              title: Text(
                item['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text("Tap to view exercise"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['screen']),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
