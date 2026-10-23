import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/routes/routes.dart';
import 'package:provider/provider.dart';

import 'provider/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SettingsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpriteAnime',
        routes: routes,
        initialRoute: '/',
      ),
    ),
  );
}
