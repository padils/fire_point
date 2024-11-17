import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/flame_game/helpers/joypad.dart';
import 'package:game_test/flame_game/simple_game.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  static const String backButtonKey = 'back_buttton';
  static const String winDialogKey = 'win_dialog';

  @override
  Widget build(BuildContext context) {
    final game = MyGame(
        context.read<SettingsProvider>(),
        Vector2(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ));
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GameWidget(
            backgroundBuilder: (context) => Opacity(
              opacity: 0.3,
              child: Image.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                Assets.menuBackground,
                fit: BoxFit.fill,
              ),
            ),
            overlayBuilderMap: {
              winDialogKey: (BuildContext context, MyGame game) {
                return Center(
                  child: Card(
                    elevation: 4,
                    child: SizedBox(
                      height: 150,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('WIN!!!'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF7e2322),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: Text('OK'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            },
            game: game,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Joypad(onDirectionChanged: game.onJoyPadDirectionChanged),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  // border: Border.all()
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    game.trowBall();
                  },
                  child: const SizedBox(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
