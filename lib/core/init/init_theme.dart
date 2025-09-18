import 'package:test_app/core/theme/bloc/theme_bloc.dart';
import 'package:test_app/core/theme/data/repository/theme_repository_impl.dart';
import 'package:test_app/core/theme/domain/usecase/get_saved_theme_mode.dart';
import 'package:test_app/init_dependencies.dart';

void initTheme() async {
  serviceLocator.registerFactory(
    () => ThemeBloc(
      getSavedThemeModeUseCase: serviceLocator(),
      saveThemeModeUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetSavedThemeModeUseCase(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => SaveThemeModeUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(sharedPreferences: serviceLocator()),
  );
}
