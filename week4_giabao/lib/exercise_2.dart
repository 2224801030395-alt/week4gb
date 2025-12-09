import 'package:flutter/material.dart';

class Exercise2Screen extends StatelessWidget {
  // Hàm build chung cho từng Item trong Grid để tái sử dụng code
  Widget _buildGridItem(int index, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15), // Bo góc [cite: 19]
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 40,
            color: Colors.white,
          ), // Icon centered [cite: 20]
          SizedBox(height: 8),
          Text(
            "Item ${index + 1}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ), // Label below [cite: 21]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 2: Grid View Gallery"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        // Để cuộn được cả 2 section
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Fixed Column Grid [cite: 6, 11]
            Text(
              "Fixed Column Grid (Count)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.count(
              shrinkWrap:
                  true, // Quan trọng khi nằm trong SingleChildScrollView
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3, // [cite: 7]
              mainAxisSpacing: 8, // [cite: 8]
              crossAxisSpacing: 8, // [cite: 9]
              childAspectRatio: 1, // [cite: 10]
              children: List.generate(
                6,
                (index) => _buildGridItem(index, Colors.orangeAccent),
              ),
            ),

            SizedBox(height: 30),

            // Section 2: Responsive Grid [cite: 12, 17]
            Text(
              "Responsive Grid (Extent)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.extent(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              maxCrossAxisExtent: 150, // [cite: 13]
              mainAxisSpacing: 10, // [cite: 14]
              crossAxisSpacing: 10, // [cite: 15]
              childAspectRatio: 0.8, // [cite: 16]
              children: List.generate(
                6,
                (index) => _buildGridItem(index, Colors.purpleAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
