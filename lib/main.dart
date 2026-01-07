import 'package:flutter/material.dart';
import 'dart:js' as js; // Thư viện giao tiếp JS

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Hàm gọi xuống Super App (Native)
  void callNativePayment(String phone, int price) {
    // Kiểm tra xem có đang chạy trong môi trường WebView có Bridge không
    if (js.context.hasProperty('AndroidBridge')) {
      // Gọi hàm 'requestPayment' bên Android
      js.context['AndroidBridge'].callMethod('requestPayment', [phone, price]);
    } else {
      print("Đang chạy trên web thường, không phải Super App");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Kho SIM Umoney")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SIM VIP: 098.888.8888", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => callNativePayment("0988888888", 500000),
                child: const Text("Mua ngay với giá - 500k"),
              )
            ],
          ),
        ),
      ),
    );
  }
}