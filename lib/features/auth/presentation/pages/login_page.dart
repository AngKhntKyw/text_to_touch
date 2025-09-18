import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/home/pages/bottom_navigation.dart';
import 'package:test_app/core/common/widget/elevated_buttons.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/common/widget/text_from_fields.dart';
import 'package:test_app/core/route/router.dart';
import 'package:test_app/core/utils/show_error_snackbar.dart';
import 'package:test_app/core/utils/show_success_snackbar.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/pages/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login-page";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.sizeOf(context);

    void login() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(
          AuthLogIn(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
      }
    }

    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showErrorSnackBar(context, state.message);
              } else if (state is AuthLoading) {
              } else {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  BottomNavigation.routeName,
                  (route) => false,
                );
                showSuccessSnackBar(context, "Login success.");
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return LoadingWidget();
              }
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: size.width / 10),
                      SizedBox(height: size.height / 30),
                      Text("Login."),
                      SizedBox(height: size.height / 30),
                      TextFromFields(
                        hintText: 'email',
                        controller: emailController,
                      ),
                      SizedBox(height: size.height / 30),
                      TextFromFields(
                        hintText: 'password',
                        controller: passwordController,
                      ),
                      SizedBox(height: size.height / 30),
                      ElevatedButtons(buttonName: "Login", onPressed: login),
                      SizedBox(height: size.height / 30),
                      TextButton(
                        onPressed: () => navigatorKey.currentState!.pushNamed(
                          SignUpPage.routeName,
                        ),
                        child: Text("You don't have an account? Sign Up."),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      tabletBuilder: (context) {
        return Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showErrorSnackBar(context, state.message);
              } else if (state is AuthLoading) {
              } else {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  BottomNavigation.routeName,
                  (route) => false,
                );
                showSuccessSnackBar(context, "Login success.");
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return LoadingWidget();
              }
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.lock, size: size.width / 10)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login."),
                            SizedBox(height: size.height / 30),
                            TextFromFields(
                              hintText: 'email',
                              controller: emailController,
                            ),
                            SizedBox(height: size.height / 30),
                            TextFromFields(
                              hintText: 'password',
                              controller: passwordController,
                            ),
                            SizedBox(height: size.height / 30),
                            ElevatedButtons(
                              buttonName: "Login",
                              onPressed: login,
                            ),
                            SizedBox(height: size.height / 30),
                            TextButton(
                              onPressed: () => navigatorKey.currentState!
                                  .pushNamed(SignUpPage.routeName),
                              child: Text(
                                "You don't have an account? Sign Up.",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      desktopBuilder: (context) {
        return Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showErrorSnackBar(context, state.message);
              } else if (state is AuthLoading) {
              } else {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  BottomNavigation.routeName,
                  (route) => false,
                );
                showSuccessSnackBar(context, "Login success.");
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return LoadingWidget();
              }
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Icon(Icons.lock, size: size.width / 10),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login."),
                            SizedBox(height: size.height / 30),
                            TextFromFields(
                              hintText: 'email',
                              controller: emailController,
                            ),
                            SizedBox(height: size.height / 30),
                            TextFromFields(
                              hintText: 'password',
                              controller: passwordController,
                            ),
                            SizedBox(height: size.height / 30),
                            ElevatedButtons(
                              buttonName: "Login",
                              onPressed: login,
                            ),
                            SizedBox(height: size.height / 30),
                            TextButton(
                              onPressed: () => navigatorKey.currentState!
                                  .pushNamed(SignUpPage.routeName),
                              child: Text(
                                "You don't have an account? Sign Up.",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
