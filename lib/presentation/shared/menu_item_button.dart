import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.name,
    this.onPressed,
    this.isSelected = false,
    this.width,
  });

  final String name;
  final bool isSelected;
  final void Function()? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7e2322)
              .withValues(alpha: isSelected ? 1 : 0.8),
          foregroundColor: const Color(0xFF7e2322),
          elevation: 0,
        ),
        onPressed: onPressed ?? () {},
        child: SizedBox(
          height: 80,
          width: width ?? MediaQuery.of(context).size.width / 3,
          child: Center(
            child: Text(name, style: const TextStyle(color: Colors.amber)),
          ),
        ),
      ),
    );
  }
}
