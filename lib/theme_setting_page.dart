import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/common/widget/theme_revel_animation.dart';
import 'package:test_app/core/theme/bloc/theme_bloc.dart';
import 'package:test_app/core/theme/bloc/theme_event.dart';
import 'package:test_app/core/theme/bloc/theme_state.dart';
import 'package:test_app/core/theme/domain/entity/app_theme.dart';

class ThemeSettingsPage extends StatefulWidget {
  static const routeName = "/theme-setting-page";
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  OverlayEntry? _overlayEntry;

  void _showThemeChangeAnimation(
    BuildContext context,
    Offset tapPosition,
    AppThemeMode newThemeMode,
  ) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return ThemeRevealAnimation(
          startPosition: tapPosition,
          onAnimationComplete: (bool finished) {
            if (finished) {
              context.read<ThemeBloc>().add(ChangeTheme(newThemeMode));
            }
          },
          child: Container(
            color: newThemeMode == AppThemeMode.dark
                ? Colors.black
                : Colors.white,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (_overlayEntry != null && _overlayEntry!.mounted) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ListView(
            children: AppThemeMode.values.map((mode) {
              return GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final Offset tapPosition = details.globalPosition;
                  if (mode != state.themeMode) {
                    _showThemeChangeAnimation(context, tapPosition, mode);
                  }
                },
                child: AbsorbPointer(
                  child: RadioListTile<AppThemeMode>(
                    title: Text(mode.name.toUpperCase()),
                    value: mode,
                    groupValue: state.themeMode,
                    onChanged: (AppThemeMode? newValue) {},
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
