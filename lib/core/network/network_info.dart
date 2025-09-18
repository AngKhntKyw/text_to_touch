import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkInfo {
  Stream<bool> get onConnectivityChanged;
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> isConnected() async {
    return await connectionChecker.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return connectionChecker.onStatusChange.map((status) {
      return status == InternetStatus.connected;
    });
  }
}
