import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/game/helpers/joypad.dart';
import 'package:game_test/game/components/world.dart';
import 'package:game_test/presentation/shared/game_screen_button.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static const String pauseKey = 'pause';
  static const String winDialogKey = 'win_dialog';
  static const String timeLeftKey = 'time_left';
  static const String leftBottomController = 'left_bottom_controller';
  static const String rightBottomController = 'right_bottom_controller';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Key myWorldKey = UniqueKey();
  late MyWorld myWorld;

  @override
  Widget build(BuildContext context) {
    myWorld = MyWorld(context.read<SettingsProvider>());
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GameWidget(
            key: myWorldKey,
            backgroundBuilder: (context) => Opacity(
              opacity: 0.3,
              child: Image.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                Assets.menuBackground,
                fit: BoxFit.fill,
              ),
            ),
            overlayBuilderMap: overlayBuilderMap,
            game: myWorld,
          ),
        ],
      ),
    );
  }

  Map<String, Widget Function(BuildContext, MyWorld)> get overlayBuilderMap => {
    GameScreen.winDialogKey: (BuildContext context, _) => Center(
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: 130,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'You\'ve won.\nChoose the next level',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GSButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/settings');
                  _reloadGame();
                },
              ),
            ],
          ),
        ),
      ),
    ),
    GameScreen.timeLeftKey: (BuildContext context, _) => Center(
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: 100,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Time\'s up. Try again!')),
              ),
              GSButton(onPressed: _reloadGame, text: 'GO!'),
            ],
          ),
        ),
      ),
    ),
    GameScreen.pauseKey: (BuildContext context, MyWorld myWorld) => Positioned(
      top: 20,
      right: 10,
      child: IconButton(
        onPressed: () {
          myWorld.paused = true;

          showDialog(
            context: context,
            builder: (c) => Center(
              child: Card(
                elevation: 4,
                child: SizedBox(
                  height: 100,
                  width: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('What\'s wrong ?')),
                      ),
                      Row(
                        children: [
                          GSButton(
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, '/'),
                            text: 'Menu!',
                          ),
                          GSButton(
                            onPressed: () {
                              myWorld.paused = false;
                              Navigator.pop(context);
                            },
                            text: 'resume!',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.pause, size: 30, color: Colors.white),
      ),
    ),
    GameScreen.leftBottomController: (BuildContext context, _) => Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Joypad(onDirectionChanged: myWorld.onJoyPadDirectionChanged),
      ),
    ),
    GameScreen.rightBottomController: (BuildContext context, _) => Align(
      alignment: Alignment.bottomRight,
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: myWorld.trowBall,
            child: const SizedBox.shrink(),
          ),
        ),
      ),
    ),
  };

  void _reloadGame() {
    setState(() {
      myWorldKey = UniqueKey();
    });
  }
}
