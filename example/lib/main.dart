import 'package:flutter/material.dart';
import 'package:glow_bottom_app_bar/glow_bottom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Current Index: $index',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: GlowBottomAppBar(
        height: 60,
        onChange: (value) {
          setState(() {
            index = value;
          });
        },
        // shadowColor: AppColors.white.withOpacity(0.15),
        background: Colors.black54,
        iconSize: 35,
        glowColor: Colors.redAccent,
        selectedChildren: const [
          Icon(Icons.ac_unit, color: Colors.redAccent,),
          Icon(Icons.adb_rounded, color: Colors.redAccent,),
          Icon(Icons.account_circle_rounded, color: Colors.redAccent,),
        ],
        children: const [
          Icon(Icons.ac_unit, color: Colors.white,),
          Icon(Icons.adb_rounded, color: Colors.white,),
          Icon(Icons.account_circle_rounded, color: Colors.white,),
        ],
      ),
    );
  }
}