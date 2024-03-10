import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String data;
  final double? fontSize;
  const TextWidget({
    super.key,
    required this.data,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}
