import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/presentation/flame_game/helpers/joypad.dart';
import 'package:game_test/presentation/flame_game/simple_game.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static const String pauseKey = 'pause';
  static const String winDialogKey = 'win_dialog';
  static const String timeLeftKey = 'time_left';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Key gameKey = UniqueKey();
  late MyGame game;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    game = MyGame(
      context.read<SettingsProvider>(),
      Vector2(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
    );
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GameWidget(
            key: UniqueKey(),
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
              GameScreen.winDialogKey: (BuildContext context, MyGame game) {
                return Center(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF7e2322),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/settings');
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
              GameScreen.timeLeftKey: (BuildContext context, MyGame game) {
                return Center(
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
                            child: Center(
                              child: Text('Time\'s up. Try again!'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF7e2322),
                              ),
                              onPressed: () {
                                _reloadGame();
                              },
                              child: const Center(
                                child: Text('GO!'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              GameScreen.pauseKey: (BuildContext context, MyGame game) {
                return Positioned(
                  top: 20,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      game.paused = true;
                      showDialog(
                        context: context,
                        builder: (c) => Center(
                          child: Card(
                            elevation: 4,
                            child: SizedBox(
                              height: 100,
                              width: 220,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('Wat\'s wrong ?'),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFF7e2322),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/',
                                            );
                                          },
                                          child: const Center(
                                            child: Text('Menu'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFF7e2322),
                                          ),
                                          onPressed: () {
                                            game.paused = false;
                                            Navigator.pop(context);
                                          },
                                          child: const Center(
                                            child: Text('resume'),
                                          ),
                                        ),
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
                    icon: const Icon(
                      Icons.pause,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                );
                // return Center(
                //   child: Card(
                //     elevation: 4,
                //     child: SizedBox(
                //       height: 100,
                //       width: 200,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Center(
                //               child: Text('Wat\'s wrong ?'),
                //             ),
                //           ),
                //           Row(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //                     foregroundColor: const Color(0xFF7e2322),
                //                   ),
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                   },
                //                   child: const Center(
                //                     child: Text('Menu'),
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: ElevatedButton(
                //                   style: ElevatedButton.styleFrom(
                //                     foregroundColor: const Color(0xFF7e2322),
                //                   ),
                //                   onPressed: () {
                //                     game.paused = false;
                //                   },
                //                   child: const Center(
                //                     child: Text('resume'),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // );
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

  void _reloadGame() {
    setState(() {
      gameKey = UniqueKey();
      game = MyGame(
        context.read<SettingsProvider>(),
        Vector2(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      );
    });
  }
}
