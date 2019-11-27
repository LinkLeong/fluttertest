import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Welcome extends StatefulWidget {
  static final String name = "/";
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool hanInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hanInit) {
      return;
    }
    Future.delayed(Duration(seconds: 2, milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = 200;
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('static/images/welcome.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size,
              height: size,
              child: FlareActor(
                "static/file/flare_flutter_logo_.flr",
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
                animation: "Placeholder",
              ),
            ),
          )
        ],
      ),
    );
  }
}
