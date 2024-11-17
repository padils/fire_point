import 'package:game_test/flame_game/screens/game_screen.dart';
import 'package:game_test/main_menu/screens/main_menu.dart';
import 'package:game_test/settings/screens/settings.dart';

final routes = {
  '/': (context) => const Menu(),
  '/game': (context) => const GameScreen(),
  '/settings': (context) => const Settings(),
};
