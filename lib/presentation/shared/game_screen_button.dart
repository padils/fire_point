import 'package:flutter/material.dart';

class GSButton extends StatelessWidget {
  const GSButton({super.key, this.onPressed, this.text});

  final void Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF7e2322),
        ),
        onPressed: onPressed,
        child: Center(child: Text(text ?? 'OK')),
      ),
    );
  }
}
