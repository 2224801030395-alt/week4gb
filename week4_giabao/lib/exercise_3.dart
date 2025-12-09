import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Để format ngày tháng

class Exercise3Screen extends StatefulWidget {
  @override
  _Exercise3ScreenState createState() => _Exercise3ScreenState();
}

class _Exercise3ScreenState extends State<Exercise3Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(); // Bonus [cite: 34]

  String _displayInfo = "No data saved"; // [cite: 31]
  String _lastSavedTime = "";

  // Hàm Lưu dữ liệu
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _nameController.text);
    await prefs.setString('email', _emailController.text);

    // Bonus: Save timestamp [cite: 35]
    String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await prefs.setString('timestamp', timestamp);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Data Saved!")));
  }

  // Hàm Hiển thị dữ liệu
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');
    String? email = prefs.getString('email');
    String? time = prefs.getString('timestamp');

    setState(() {
      if (name != null && name.isNotEmpty) {
        _displayInfo = "Name: $name\nEmail: ${email ?? 'N/A'}";
        _lastSavedTime = "Last Saved: $time";
      } else {
        _displayInfo = "No data found!";
      }
    });
  }

  // Bonus: Hàm Xóa dữ liệu [cite: 33]
  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _displayInfo = "Data Cleared";
      _lastSavedTime = "";
      _nameController.clear();
      _emailController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 3: Shared Preferences"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Input Fields
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ), // [cite: 28]
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Enter Email (Bonus)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveData,
                  icon: Icon(Icons.save),
                  label: Text("Save"),
                ), // [cite: 29]
                ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: Icon(Icons.visibility),
                  label: Text("Show"),
                ), // [cite: 30]
                ElevatedButton.icon(
                  onPressed: _clearData,
                  icon: Icon(Icons.delete),
                  label: Text("Clear"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                ), // Bonus [cite: 33]
              ],
            ),

            SizedBox(height: 30),
            Divider(),

            // Display Area
            Text(
              "Stored Data:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    _displayInfo,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  if (_lastSavedTime.isNotEmpty) ...[
                    SizedBox(height: 10),
                    Text(
                      _lastSavedTime,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
