import 'package:flutter/material.dart';
import '../../main.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    cal();
    data();
  }

  cal() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff090e21),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Galaxy Planets",
                style: TextStyle(fontSize: 40, color: Colors.yellow),
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
