import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.name,
    this.onPressed,
    this.isSelected = false,
  });

  final String name;
  final bool isSelected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7e2322).withOpacity(
            isSelected ? 1 : 0.8,
          ),
          foregroundColor: const Color(0xFF7e2322),
          elevation: 0,
        ),
        onPressed: onPressed ?? () {},
        child: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width / 3,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ),
    );
  }
}