// States
import 'package:equatable/equatable.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';

abstract class ThemeState extends Equatable {
  final AppThemeMode themeMode;
  const ThemeState(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(AppThemeMode.system);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded(super.themeMode);
}
