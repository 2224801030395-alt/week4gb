import 'package:flutter/foundation.dart'; // Để dùng compute
import 'package:flutter/material.dart';

// Hàm tính toán nặng phải để ở top-level hoặc static
BigInt calculateFactorial(int n) {
  BigInt result = BigInt.from(1);
  for (int i = 1; i <= n; i++) {
    result = result * BigInt.from(i);
  }
  return result;
}

class Exercise5Screen extends StatefulWidget {
  @override
  _Exercise5ScreenState createState() => _Exercise5ScreenState();
}

class _Exercise5ScreenState extends State<Exercise5Screen> {
  String _result = "";
  bool _isCalculating = false;

  Future<void> _runHeavyTask() async {
    setState(() {
      _isCalculating = true;
      _result = "Calculating 30,000! ..."; // [cite: 47]
    });

    // Sử dụng isolate (compute) cho tính toán nặng [cite: 46]
    // Lưu ý: 30,000! rất lớn, việc chuyển chuỗi kết quả về main UI cũng tốn thời gian.
    // Ở đây mình tính 5000! để demo mượt mà hơn, hoặc bạn giữ 30000 nếu máy khỏe.
    BigInt result = await compute(calculateFactorial, 5000);

    setState(() {
      _isCalculating = false;
      // Chỉ hiển thị độ dài của số vì số quá dài để hiển thị hết
      _result =
          "Calculated! Result has ${result.toString().length} digits.\n\nFirst 50 digits:\n${result.toString().substring(0, 50)}..."; // [cite: 48]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài 5: Isolates"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Heavy Calculation (Factorial)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (_isCalculating) CircularProgressIndicator(),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(_result, textAlign: TextAlign.center),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isCalculating ? null : _runHeavyTask,
                icon: Icon(Icons.bolt),
                label: Text("Compute Factorial"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
