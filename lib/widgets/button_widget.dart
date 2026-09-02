import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, required this.onPressed, this.color, this.textColor, this.borderColor});

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: SizedBox(
          height: 70,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: borderColor ?? Colors.grey[300]!, width: 2),
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