import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphify/core/themes/providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          SwitchListTile(
             title: const Text("Dark Mode"),
            value: ref.watch(themeNotifierProvider) == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}
