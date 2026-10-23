import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('$_count', key: const Key('count'))),
        floatingActionButton: FloatingActionButton(
          key: const Key('increment'),
          onPressed: () => setState(() => _count++),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
