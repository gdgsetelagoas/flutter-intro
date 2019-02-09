import 'package:flutter/material.dart';

class GDGTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Olá",
              style: TextStyle(fontSize: 25),
            ),
            Image.asset("lib/img/gdgsetelagoas.webp"),
          ],
        ),
      ),
    );
  }
}
