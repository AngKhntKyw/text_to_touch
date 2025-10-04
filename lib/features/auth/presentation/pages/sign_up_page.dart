import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/elevated_buttons.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/common/widget/text_from_fields.dart';
import 'package:test_app/core/utils/show_error_snackbar.dart';
import 'package:test_app/core/utils/show_success_snackbar.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/product/presentation/pages/product_page.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = "/sign-up-page";
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final size = MediaQuery.sizeOf(context);
    void signUp() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(
          AuthSignUp(
            name: nameController.text,
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
                context.goNamed(ProductPage.routeName);
                showSuccessSnackBar(context, "Sign up success.");
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return LoadingWidget();
              }
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: size.width / 10),
                      SizedBox(height: size.height / 30),
                      Text("Sign Up."),
                      SizedBox(height: size.height / 30),
                      TextFromFields(
                        hintText: 'name',
                        controller: nameController,
                      ),
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
                      ElevatedButtons(buttonName: "Sign Up", onPressed: signUp),
                      SizedBox(height: size.height / 30),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text("Already have an account? Login."),
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
