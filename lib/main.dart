import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Models/global.dart';
import 'Views/Screens/Detail_page.dart';
import 'Views/Screens/splase_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const home(),
        'splash_screen': (context) => const splash_screen(),
        'detail_page': (context) => const detail_page(),
      },
    ),
  );
}

data() async {
  String res = await rootBundle.loadString("assets/json/data.json");
  List decodeData = jsonDecode(res);
  galaxy = decodeData.map((e) => planet.fromMap(data: e)).toList();
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

late AnimationController animationController;

List<planet> galaxy = [];

class _homeState extends State<home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    data();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Galaxy Planets",
          style: TextStyle(color: Colors.yellow, fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff090e21),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/screen-1.jpg"),
              fit: BoxFit.fill),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
          itemCount: galaxy.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .pushNamed('detail_page', arguments: galaxy[index]);
                });
              },
              child: Container(
                height: _height * 0.4,
                width: _width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.grey.withOpacity(0.5)
                  ]),
                  border: Border.all(
                      color: Colors.black,
                      width: 8,
                      strokeAlign: StrokeAlign.center),
                ),
                child: Column(
                  children: [
                    Text(
                      "${galaxy[index].name}",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Colors.black,
                    ),
                    RotationTransition(
                      alignment: Alignment.center,
                      turns: animationController,
                      child: Image.asset("${galaxy[index].image}",
                          fit: BoxFit.fill, height: 280),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
