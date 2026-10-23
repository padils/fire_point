import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_test/constant/assets.dart';
import 'package:game_test/presentation/shared/menu_item_button.dart';
import 'package:game_test/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _syncControllers(context.read<SettingsProvider>());
      _initialized = true;
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(Assets.menuBackground, fit: BoxFit.fill),
          ),
          Positioned(
            left: 15,
            top: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(72, 20, 72, 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    children: [
                      const Text(
                        'Difficulty',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        children: TypesEnum.values
                            .map(
                              (type) => SizedBox(
                                width: 190,
                                child: MenuItem(
                                  name: type.key,
                                  width: 170,
                                  isSelected: settings.currentType == type,
                                  onPressed: () {
                                    settings.setType(type);
                                    _syncControllers(settings);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Custom values',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 4.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 16,
                        children: [
                          _numberField(
                            'Goal',
                            _controllers[0],
                            (value) => settings.updateCustom(goal: value),
                          ),
                          _numberField(
                            'Ball speed',
                            _controllers[1],
                            (value) => settings.updateCustom(speed: value),
                          ),
                          _numberField(
                            'Point lifetime (s)',
                            _controllers[2],
                            (value) => settings.updateCustom(lifetime: value),
                          ),
                          _numberField(
                            'Timer (s)',
                            _controllers[3],
                            (value) =>
                                settings.updateCustom(timerSeconds: value),
                          ),
                          _numberField(
                            'Field width',
                            _controllers[4],
                            (value) =>
                                settings.updateCustom(width: value.toDouble()),
                          ),
                          _numberField(
                            'Field height',
                            _controllers[5],
                            (value) =>
                                settings.updateCustom(height: value.toDouble()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          settings.reset();
                          _syncControllers(settings);
                        },
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset to defaults'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberField(
    String label,
    TextEditingController controller,
    ValueChanged<int> onChanged,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (text) {
        final value = int.tryParse(text);
        if (value != null) {
          onChanged(value);
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _syncControllers(SettingsProvider settings) {
    final values = [
      settings.goalForWin,
      settings.ballSpeed,
      settings.pointLiveTime,
      settings.timer.inSeconds,
      settings.worldSize.x.round(),
      settings.worldSize.y.round(),
    ];
    for (var index = 0; index < _controllers.length; index++) {
      _controllers[index].text = values[index].toString();
    }
  }
}
