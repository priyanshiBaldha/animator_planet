import 'package:flutter/material.dart';

class detail_page extends StatefulWidget {
  const detail_page({Key? key}) : super(key: key);

  @override
  State<detail_page> createState() => _detail_pageState();
}

late AnimationController animationController;
late AnimationController nameanimationController;
late Animation nameAnimation;

class _detail_pageState extends State<detail_page>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 4000))
          ..repeat();
    nameanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
          ..forward();

    nameAnimation = Tween<double>(begin: 0, end: 6).animate(CurvedAnimation(
        parent: nameanimationController, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text("${res.name}",
              style: const TextStyle(color: Colors.yellow, fontSize: 35)),
          centerTitle: true,
          backgroundColor: const Color(0xff090e21)),
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Hubble_ultra_deep_field.jpg"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _height * 0.4,
                width: _width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.grey.withOpacity(0.4)
                  ]),
                ),
                child: RotationTransition(
                  turns: animationController,
                  alignment: Alignment.center,
                  child: Image.asset("${res.image}"),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: _height * 0.15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.grey.withOpacity(0.4)
                  ]),
                ),
                child: AnimatedBuilder(
                  animation: nameAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: nameAnimation.value,
                      child: Text(
                        "${res.name}",
                        style: TextStyle(
                            color: Colors.yellow.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: _height * 0.3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.grey.withOpacity(0.4)
                  ]),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  "velocity :${res.velocity}\ndistance : ${res.distance}",
                  style: TextStyle(
                      color: Colors.yellow.shade800,
                      fontSize: 40,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.grey.withOpacity(0.4)
                  ]),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "DESCRIPTION :",
                      style: TextStyle(
                          color: Colors.yellow.shade800,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        textAlign: TextAlign.justify,
                        "${res.description}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
