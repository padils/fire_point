import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/constant/assets.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              Assets.menuBackground,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuItem(
                  name: 'Play',
                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                ),
                MenuItem(
                    name: 'Settings',
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    }),
                MenuItem(
                    name: 'Exit',
                    onPressed: () {
                      SystemNavigator.pop();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
//#7e2322
//0xFFF8C967
