import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق الوادي',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('الوادي للخدمات الزراعية'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'تطبيق إدارة الحضور والإنتاجية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
