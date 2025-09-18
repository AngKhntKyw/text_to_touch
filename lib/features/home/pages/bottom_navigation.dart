import 'package:flutter/material.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/features/chat/presentation/pages/chat_page.dart';
import 'package:test_app/features/home/widgets/mobile_bottom_navigation_widget.dart';
import 'package:test_app/features/home/widgets/tablet_and_desktop_side_bar_widget.dart';
import 'package:test_app/features/post/presentation/pages/post_page.dart';
import 'package:test_app/features/profile/presentation/pages/profile_page.dart';

class BottomNavigation extends StatelessWidget {
  static const routeName = "/bottom-navigation";
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [const PostPage(), const ChatPage(), const ProfilePage()];

    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return MobileBottomNavigationWidget(pages: pages);
      },
      tabletBuilder: (context) {
        return TabletAndDesktopSideBarWidget(pages: pages);
      },
      desktopBuilder: (context) {
        return TabletAndDesktopSideBarWidget(pages: pages);
      },
    );
  }
}
