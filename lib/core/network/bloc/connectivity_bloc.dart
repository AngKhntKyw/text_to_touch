import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/network/bloc/connectivity_event.dart';
import 'package:test_app/core/network/bloc/connectivity_state.dart';
import 'package:test_app/core/network/domain/usecase/get_connectivity_stream_usecase.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final GetConnectivityStreamUseCase _getConnectivityStreamUseCase;
  StreamSubscription? _connectivitySubscription;

  ConnectivityBloc({
    required GetConnectivityStreamUseCase getConnectivityStreamUseCase,
  }) : _getConnectivityStreamUseCase = getConnectivityStreamUseCase,
       super(ConnectivityInitial()) {
    on<CheckInitialConnectivity>(_onCheckInitialConnectivity);
    on<ConnectivityStatusChanged>(_onConnectivityStatusChanged);
    _listenToConnectivityChanges();
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = _getConnectivityStreamUseCase().listen((
      isConnected,
    ) {
      add(ConnectivityStatusChanged(isConnected));
    });
  }

  Future<void> _onCheckInitialConnectivity(
    CheckInitialConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await _getConnectivityStreamUseCase.networkInfo
        .isConnected();
    emit(isConnected ? ConnectivityConnected() : ConnectivityDisconnected());
  }

  void _onConnectivityStatusChanged(
    ConnectivityStatusChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(
      event.isConnected ? ConnectivityConnected() : ConnectivityDisconnected(),
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
