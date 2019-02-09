import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String text;
  final Widget child;
  final VoidCallback onPressed;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final Color shadowColor;

  AppButton(
      {this.text,
        this.onPressed,
        this.textColor,
        this.backgroundColor,
        this.shadowColor,
        this.fontSize = 14,
        this.child}) {
    assert((child == null && text != null) || (child != null && text == null));
  }

  @override
  _AppButtonState createState() {
    return new _AppButtonState();
  }
}

class _AppButtonState extends State<AppButton> {
  var _shadow = 5.0;
  var _paddingTop = 0.0;
  var _paddingBottom = 5.0;
  var _colorPressed = Colors.transparent;

  @override
  void initState() {
    if (widget.onPressed == null) _pressButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDetails) {
        if (widget.onPressed != null) _pressButton();
      },
      onTapUp: (TapUpDetails tapDetails) {
        if (widget.onPressed != null) {
          _releaseButton();
          widget.onPressed();
        }
      },
      onHorizontalDragCancel: () {},
      onVerticalDragCancel: () {},
      onPanCancel: () {
        if (widget.onPressed != null) _releaseButton();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        margin: EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.backgroundColor ?? Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                  color:
                  widget.shadowColor ?? Theme.of(context).primaryColorDark,
                  offset: Offset(0, _shadow))
            ]),
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: _colorPressed),
        child: widget.text != null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                  color:
                  widget.textColor ?? Theme.of(context).buttonColor,
                  fontSize: widget.fontSize),
            )
          ],
        )
            : widget.child,
      ),
    );
  }

  void _pressButton() {
    setState(() {
      _paddingTop = 5.0;
      _paddingBottom = 0.0;
      _colorPressed = Colors.black12;
      _shadow = 0.0;
    });
  }

  void _releaseButton() {
    setState(() {
      _paddingTop = 0.0;
      _paddingBottom = 5.0;
      _colorPressed = Colors.transparent;
      _shadow = 5.0;
    });
  }
}