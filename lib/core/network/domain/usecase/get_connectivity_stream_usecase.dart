import 'package:test_app/core/network/network_info.dart';

class GetConnectivityStreamUseCase {
  final NetworkInfo networkInfo;
  GetConnectivityStreamUseCase(this.networkInfo);

  Stream<bool> call() {
    return networkInfo.onConnectivityChanged;
  }
}
