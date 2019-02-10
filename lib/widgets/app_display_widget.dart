import 'package:flutter/material.dart';

class AppDisplay extends StatelessWidget {
  final String text;

  const AppDisplay({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(),
            Text(text ?? "",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 55,
                    fontFamily: "Digital",
                    shadows: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1.50,
                          offset: Offset(-1, 2.5))
                    ])),
          ],
        ),
      ),
    );
  }
}
