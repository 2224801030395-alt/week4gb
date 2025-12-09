import 'package:flutter/material.dart';

class Exercise4Screen extends StatefulWidget {
  @override
  _Exercise4ScreenState createState() => _Exercise4ScreenState();
}

class _Exercise4ScreenState extends State<Exercise4Screen> {
  String _status = "Press button to load user";
  bool _isLoading = false;

  void _loadUser() async {
    setState(() {
      _isLoading = true;
      _status = "Loading user..."; // [cite: 39]
    });

    // Wait for 3 seconds
    await Future.delayed(Duration(seconds: 3)); // [cite: 40]

    setState(() {
      _isLoading = false;
      _status = "User loaded successfully!"; // [cite: 41]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 4: Async Demo"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              _status,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _isLoading ? Colors.grey : Colors.green,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _loadUser,
              child: Text("Start Loading"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
