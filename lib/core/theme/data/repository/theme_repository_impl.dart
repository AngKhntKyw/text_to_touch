import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';

abstract interface class ThemeRepository {
  Future<AppThemeMode> getSavedThemeMode();
  Future<void> saveThemeMode(AppThemeMode themeMode);
}

class ThemeRepositoryImpl implements ThemeRepository {
  final SharedPreferences sharedPreferences;
  static const String _themeModeKey = 'app_theme_mode';

  ThemeRepositoryImpl({required this.sharedPreferences});

  @override
  Future<AppThemeMode> getSavedThemeMode() async {
    final String? themeModeString = sharedPreferences.getString(_themeModeKey);
    if (themeModeString != null) {
      try {
        return AppThemeMode.values.firstWhere(
          (e) => e.name == themeModeString,
          orElse: () => AppThemeMode.system,
        );
      } catch (e) {
        return AppThemeMode.system;
      }
    }
    return AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode themeMode) async {
    await sharedPreferences.setString(_themeModeKey, themeMode.name);
  }
}
