import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calc/nova_tela.dart';
import 'package:flutter_calc/widgets/app_button_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'GDG SLA - Flutter Intro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _display = "";
  int primeiroValor = 0;
  int segundoValor = 0;
  var _displayRegex = RegExp(r"(\d{0,}) (\-|\+) (\d{0,})");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
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
                          Text(_display,
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
                  ),
                ),
                Row(
                  children: <Widget>[
                    buildButton(7),
                    buildButton(8),
                    buildButton(9),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton(4),
                    buildButton(5),
                    buildButton(6),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton(1),
                    buildButton(2),
                    buildButton(3),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        text: "-",
                        backgroundColor: Colors.redAccent,
                        shadowColor: Colors.red.shade900,
                        onPressed: _subtrair,
                      ),
                    ),
                    buildButton(0),
                    Expanded(
                      child: AppButton(
                        text: "+",
                        backgroundColor: Colors.blue,
                        shadowColor: Colors.blue.shade800,
                        onPressed: _somar,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        text: "=",
                        onPressed: _igual,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        text: "C",
                        onPressed: _limpar,
                        backgroundColor: Colors.redAccent,
                        shadowColor: Colors.red.shade900,
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        text: "DEL",
                        onPressed: _remover,
                        backgroundColor: Colors.orange,
                        shadowColor: Colors.deepOrange,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _somar() {
    if (_display.isEmpty) return;
    if (_display.contains(RegExp(r"\+"))) return;
    setState(() {
      if (_display.contains(RegExp(r"\-"))) {
        _display.replaceAll(RegExp(r"\-"), "+");
        return;
      }
      _display = "$_display + ";
    });
  }

  void _subtrair() {
    if (_display.isEmpty) return;
    if (_display.contains(RegExp(r"\-"))) return;
    setState(() {
      if (_display.contains(RegExp(r"\+"))) {
        _display.replaceAll(RegExp(r"\+"), "-");
        return;
      }
      _display = "$_display - ";
    });
  }

  Widget buildButton(int num) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppButton(
          text: "$num",
          fontSize: 22,
          onPressed: () {
            _addNum(num);
          },
        ),
      ),
    );
  }

  _limpar() {
    setState(() {
      _display = "";
    });
  }

  _igual() {
    setState(() {
      if (!_displayRegex.hasMatch(_display)) return;
      var items = _displayRegex.firstMatch(_display).groups([1, 2, 3]);
      print(items);
      var res = _calc(items[0], items[1], items[2]);
      _display = "$_display = $res";
      Future.delayed(Duration(milliseconds: 1500), () {
        if (res == "666") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => GDGTela()));
        }
      });
    });
  }

  String _calc(String primeiro, String operador, String segundo) {
    if (operador == "+") {
      return (int.parse(primeiro) + int.parse(segundo)).toString();
    } else {
      return (int.parse(primeiro) - int.parse(segundo)).toString();
    }
  }

  void _addNum(int i) {
    setState(() {
      _display = "$_display$i";
    });
  }

  void _remover() {
    if (_display.isEmpty) return;
    if (RegExp(r"\d$").hasMatch(_display)) {
      setState(() {
        _display = _display.substring(0, _display.length - 1);
      });
    } else {
      setState(() {
        _display = _display.trim();
        _display = _display.substring(0, _display.length - 1).trim();
      });
    }
  }
}
