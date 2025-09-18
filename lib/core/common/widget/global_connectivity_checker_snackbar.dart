import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/network/bloc/connectivity_bloc.dart';
import 'package:test_app/core/network/bloc/connectivity_state.dart';
import 'package:test_app/core/utils/show_error_snackbar.dart';
import 'package:test_app/core/utils/show_success_snackbar.dart';

class GlobalConnectivitySnackbarHandler extends StatefulWidget {
  final Widget child;
  const GlobalConnectivitySnackbarHandler({super.key, required this.child});

  @override
  State<GlobalConnectivitySnackbarHandler> createState() =>
      _GlobalConnectivitySnackbarHandlerState();
}

class _GlobalConnectivitySnackbarHandlerState
    extends State<GlobalConnectivitySnackbarHandler> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityDisconnected) {
          showErrorSnackBar(context, "Connection lost.");
        } else if (state is ConnectivityConnected) {
          showSuccessSnackBar(context, "Connected.");
        }
      },
      child: widget.child,
    );
  }
}
