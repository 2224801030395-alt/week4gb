import 'dart:async';
import 'dart:isolate';
import 'dart:math';

// [cite: 50] Console Application
void main() async {
  print("Main Isolate started.");

  // Setup ReceivePort cho main isolate
  final mainReceivePort = ReceivePort();

  // Spawn background isolate [cite: 51]
  await Isolate.spawn(workerIsolate, mainReceivePort.sendPort);

  // Lắng nghe port
  await for (var message in mainReceivePort) {
    if (message is SendPort) {
      // Nhận cổng gửi từ worker để gửi số ngẫu nhiên
      SendPort workerSendPort = message;

      // Gửi số ngẫu nhiên mỗi giây [cite: 52]
      Timer.periodic(Duration(seconds: 1), (timer) {
        final randomNum = Random().nextInt(20);
        print("Main: Sending $randomNum");
        workerSendPort.send(randomNum);
      });
    } else if (message == "STOP") {
      print("Main: Received STOP command. Exiting."); // [cite: 54]
      break; // Thoát vòng lặp
    }
  }
  print("Application finished.");
  // exit(0);
}

// Worker Isolate
void workerIsolate(SendPort mainSendPort) {
  final workerReceivePort = ReceivePort();

  // Gửi cổng nhận của worker về cho main
  mainSendPort.send(workerReceivePort.sendPort);

  int sum = 0;

  workerReceivePort.listen((message) {
    if (message is int) {
      sum += message; // [cite: 53]
      print("Worker: Current sum = $sum");

      if (sum > 100) {
        mainSendPort.send("STOP"); // [cite: 54]
        print("Worker: Sum exceeded 100. Exiting.");
        Isolate.exit(); // [cite: 55]
      }
    }
  });
}
