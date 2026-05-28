import 'package:graphify/core/themes/services/theme_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_service_provider.g.dart';

@riverpod
ThemeService themeService(ThemeServiceRef ref) {
  return ThemeService();
}
