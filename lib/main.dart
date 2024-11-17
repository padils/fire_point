import 'package:flutter/material.dart';
import 'package:game_test/routes/routes.dart';
import 'package:provider/provider.dart';
import 'provider/settings_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpriteAnime',
        routes: routes,
        initialRoute: '/',
      ),
    ),
  );
}
