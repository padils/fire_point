import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/presentation/shared/menu_item_button.dart';

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
            child: Image.asset(Assets.menuBackground, fit: BoxFit.fill),
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
                  },
                ),
                MenuItem(
                  name: 'Exit',
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
