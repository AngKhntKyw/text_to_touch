import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/auth/domain/usecases/log_out.dart';
import 'package:test_app/features/auth/domain/usecases/login.dart';
import 'package:test_app/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUpWithEmailAndPassword;
  final Login _logInWithEmailAndPassword;
  final LogOut _logOut;

  AuthBloc({
    required SignUp signUpWithEmailAndPassword,
    required Login logInWithEmailAndPassword,
    required LogOut logOut,
  }) : _signUpWithEmailAndPassword = signUpWithEmailAndPassword,
       _logInWithEmailAndPassword = logInWithEmailAndPassword,
       _logOut = logOut,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(onAuthSignUp);
    on<AuthLogIn>(onAuthLogIn);
    on<AuthLogOut>(onAuthLogOut);
  }

  //
  void onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _signUpWithEmailAndPassword(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    final response = await _logInWithEmailAndPassword(
      LoginParams(email: event.email, password: event.password),
    );
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    final response = await _logOut.call(NoParams());
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (message) => emit(AuthLogOutSuccess(message)),
    );
  }
}
