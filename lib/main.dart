import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/network/bloc/connectivity_bloc.dart';
import 'package:test_app/core/route/router.dart';
import 'package:test_app/core/theme/bloc/theme_bloc.dart';
import 'package:test_app/core/theme/bloc/theme_event.dart';
import 'package:test_app/core/theme/bloc/theme_state.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ConnectivityBloc>()),
        BlocProvider(
          create: (_) => serviceLocator<ThemeBloc>()..add(LoadTheme()),
        ),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<CategoryBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProductBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: "T & T",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}

// theme: AppTheme.lightTheme,
// darkTheme: AppTheme.darkTheme,
// themeAnimationCurve: Curves.bounceInOut,
// themeAnimationStyle: AnimationStyle(
//   curve: Curves.bounceInOut,
//   duration: const Duration(seconds: 0),
//   reverseCurve: Curves.bounceInOut,
//   reverseDuration: const Duration(seconds: 0),
// ),
// themeAnimationDuration: const Duration(seconds: 0),
// themeMode: context.read<ThemeBloc>().toFlutterThemeMode(
//   state.themeMode,
// ),
