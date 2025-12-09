import 'package:flutter/material.dart';

class Exercise1Screen extends StatelessWidget {
  // Tạo dữ liệu giả lập cho danh sách
  final List<String> contacts = List.generate(
    20,
    (index) => "Contact Name ${index + 1}",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 1: List View - Contacts"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ), // Tạo khoảng cách đẹp
            elevation: 3, // Đổ bóng nhẹ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade100,
                child: Icon(
                  Icons.person,
                  color: Colors.teal,
                ), // Placeholder avatar
              ),
              title: Text(
                contacts[index],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Phone: 0909 123 45$index"),
              trailing: Icon(Icons.phone, color: Colors.green),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
