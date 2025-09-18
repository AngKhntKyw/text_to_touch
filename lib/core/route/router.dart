import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test_app/auth_gate.dart';
import 'package:test_app/features/chat/presentation/pages/chat_page.dart';
import 'package:test_app/features/home/pages/bottom_navigation.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';
import 'package:test_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:test_app/features/post/presentation/pages/post_page.dart';
import 'package:test_app/features/profile/presentation/pages/profile_page.dart';
import 'package:test_app/theme_setting_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

PageTransition goToPage(Widget page) {
  return PageTransition(
    child: page,
    type: PageTransitionType.rightToLeft,
    fullscreenDialog: true,
    duration: const Duration(milliseconds: 300),
  );
}

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Auth Gate
    case AuthGate.routeName:
      return goToPage(AuthGate());

    // Login Page
    case LoginPage.routeName:
      return goToPage(LoginPage());

    // Sign up Page
    case SignUpPage.routeName:
      return goToPage(SignUpPage());

    // Bottom Navigation Bar
    case BottomNavigation.routeName:
      return goToPage(BottomNavigation());

    // ----------------------------------------------------------------------------------------------------------------------

    // Profile
    case PostPage.routeName:
      return goToPage(const PostPage());

    case ChatPage.routeName:
      return goToPage(const ChatPage());

    case ProfilePage.routeName:
      return goToPage(const ProfilePage());
    // Theme Setting Page
    case ThemeSettingsPage.routeName:
      return goToPage(ThemeSettingsPage());

    // ----------------------------------------------------------------------------------------------------------------------

    // Defaut Screen
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(body: Text("Not Existed")),
      );
  }
}
