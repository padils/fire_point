import 'package:flutter/material.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/main_menu/screens/main_menu.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
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
                ...TypesEnum.values.map(
                  (e) => MenuItem(
                    name: e.key,
                    isSelected:
                        context.watch<SettingsProvider>().currentType == e,
                    onPressed: () {
                      context.read<SettingsProvider>().setType(e);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
