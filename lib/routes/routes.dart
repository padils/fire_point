import 'package:game_test/game/game_screen.dart';
import 'package:game_test/presentation/main_menu/main_menu.dart';
import 'package:game_test/presentation/settings/settings.dart';

final routes = {
  '/': (context) => const Menu(),
  '/game': (context) => const GameScreen(),
  '/settings': (context) => const Settings(),
};
