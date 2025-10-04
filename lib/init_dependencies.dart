import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/init/init_auth.dart';
import 'package:test_app/core/init/init_category.dart';
import 'package:test_app/core/init/init_firebase.dart';
import 'package:test_app/core/init/init_network.dart';
import 'package:test_app/core/init/init_product.dart';
import 'package:test_app/core/init/init_theme.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  initTheme();
  initNetwork();
  initFirebase();
  initAuth();
  initCategory();
  initProduct();
}
