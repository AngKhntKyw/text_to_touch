import 'package:test_app/core/theme/data/repository/theme_repository_impl.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';

class GetSavedThemeModeUseCase {
  final ThemeRepository repository;
  GetSavedThemeModeUseCase(this.repository);

  Future<AppThemeMode> call() {
    return repository.getSavedThemeMode();
  }
}

class SaveThemeModeUseCase {
  final ThemeRepository repository;

  SaveThemeModeUseCase(this.repository);

  Future<void> call(AppThemeMode themeMode) {
    return repository.saveThemeMode(themeMode);
  }
}
