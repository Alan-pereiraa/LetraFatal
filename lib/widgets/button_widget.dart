import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, required this.onPressed, this.color, this.textColor});

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: SizedBox(
          height: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Colors.grey[300],
              foregroundColor: textColor ?? Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}