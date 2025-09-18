import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_app/core/network/bloc/connectivity_bloc.dart';
import 'package:test_app/core/network/domain/usecase/get_connectivity_stream_usecase.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/init_dependencies.dart' show serviceLocator;

void initNetwork() {
  serviceLocator.registerLazySingleton(() => InternetConnection());
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetConnectivityStreamUseCase(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ConnectivityBloc(getConnectivityStreamUseCase: serviceLocator()),
  );
}
