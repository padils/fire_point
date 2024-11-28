import 'package:game_test/presentation/flame_game/screens/game_screen.dart';
import 'package:game_test/presentation/main_menu/screens/main_menu.dart';
import 'package:game_test/presentation/settings/screens/settings.dart';

final routes = {
  '/': (context) => const Menu(),
  '/game': (context) => const GameScreen(),
  '/settings': (context) => const Settings(),
};
