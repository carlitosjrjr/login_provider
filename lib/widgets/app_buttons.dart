import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;

  MyButtons({this.color, this.textColor, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: const EdgeInsets.all(8),
        color: color,
        child: Center(

          child: Text(  
            buttonText,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
