import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';
import 'package:test_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/presentation/pages/add_category_page.dart';
import 'package:test_app/features/category/presentation/pages/category_page.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/presentation/pages/add_product_page.dart';
import 'package:test_app/features/product/presentation/pages/product_page.dart';
import 'package:test_app/features/product/presentation/pages/products_in_category_page.dart';
import 'package:test_app/features/home/pages/main_shell.dart';
import 'package:test_app/features/profile/presentation/pages/profile_page.dart';
import 'package:test_app/features/sale/presentation/pages/sale_page.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: ProductPage.routeName,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: LoginPage.routeName,
        name: LoginPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: SignUpPage.routeName,
        name: SignUpPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),

      // After Logging in
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainShell(child: child);
        },

        routes: <RouteBase>[
          GoRoute(
            path: ProductPage.routeName,
            name: ProductPage.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductPage();
            },
            routes: [
              GoRoute(
                path: AddProductInCategoryPage.routeName,
                name: AddProductInCategoryPage.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  final extras = state.extra as Map<String, dynamic>;
                  final product = extras['product'] as ProductModel?;
                  final categoryId = extras['categoryId'] as String;
                  return AddProductInCategoryPage(
                    product: product,
                    categoryId: categoryId,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: CategoryPage.routeName,
            name: CategoryPage.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const CategoryPage();
            },
            routes: [
              GoRoute(
                path: AddCategoryPage.routeName,
                name: AddCategoryPage.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  final category = state.extra as CategoryModel?;
                  return AddCategoryPage(category: category);
                },
              ),
              GoRoute(
                path: ProductInCategoryPage.routeName,
                name: ProductInCategoryPage.routeName,
                builder: (BuildContext context, GoRouterState state) {
                  final category = state.extra as CategoryModel;
                  return ProductInCategoryPage(category: category);
                },
              ),
            ],
          ),

          GoRoute(
            path: ProfilePage.routeName,
            name: ProfilePage.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),

          GoRoute(
            path: SalePage.routeName,
            name: SalePage.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return const SalePage();
            },
          ),
        ],
      ),
    ],

    //
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),

    //
    redirect: (context, state) {
      final fireAuth = FirebaseAuth.instance;
      final bool isLoggedIn = fireAuth.currentUser != null;
      final bool isLoggingIn = state.matchedLocation == LoginPage.routeName;
      final bool isSigningUp = state.matchedLocation == SignUpPage.routeName;

      if (!isLoggedIn && (isLoggingIn || isSigningUp)) {
        return null;
      }

      if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
        return LoginPage.routeName;
      }

      return null;
    },
  );
}

GoRoute createSimpleGoRoute({required String routeName, required Widget page}) {
  return GoRoute(
    path: routeName,
    name: routeName,
    builder: (BuildContext context, GoRouterState state) {
      return page;
    },
  );
}
