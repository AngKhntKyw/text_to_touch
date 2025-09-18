// Events
import 'package:equatable/equatable.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final AppThemeMode themeMode;
  const ChangeTheme(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}
