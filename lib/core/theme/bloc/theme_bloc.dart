import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/bloc/theme_event.dart';
import 'package:test_app/core/theme/bloc/theme_state.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';
import 'package:test_app/core/theme/domain/usecase/get_saved_theme_mode.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetSavedThemeModeUseCase _getSavedThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;

  ThemeBloc({
    required GetSavedThemeModeUseCase getSavedThemeModeUseCase,
    required SaveThemeModeUseCase saveThemeModeUseCase,
  }) : _getSavedThemeModeUseCase = getSavedThemeModeUseCase,
       _saveThemeModeUseCase = saveThemeModeUseCase,
       super(const ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final themeMode = await _getSavedThemeModeUseCase();
    emit(ThemeLoaded(themeMode));
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await _saveThemeModeUseCase(event.themeMode);
    emit(ThemeLoaded(event.themeMode));
  }

  // Helper to convert AppThemeMode to Flutter's ThemeMode for MaterialApp
  ThemeMode toFlutterThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
