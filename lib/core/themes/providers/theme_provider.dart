import 'package:flutter/material.dart';
import 'package:graphify/core/themes/providers/theme_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.light;
  }

  Future<void> _loadTheme() async {
    final service = ref.read(themeServiceProvider);
    final savedTheme = await service.loadTheme();
    state = savedTheme;
  }

  Future<void> toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;

    final service = ref.read(themeServiceProvider);
    await service.saveTheme(isDark);
  }
}
