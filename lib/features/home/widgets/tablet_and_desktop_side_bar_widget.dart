import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebar_with_animation/animated_side_bar.dart';
import 'package:test_app/core/provider/home_navigator_provider.dart';

class TabletAndDesktopSideBarWidget extends StatelessWidget {
  final List<Widget> pages;
  const TabletAndDesktopSideBarWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider(
      create: (context) => HomeNavigatorProvider(),
      builder: (context, child) {
        return Scaffold(
          body: Row(
            children: [
              SideBarAnimated(
                widthSwitch: size.width / 5,
                settingsDivider: false,
                mainLogoImage: 'assets/images/content.png',
                onTap: (selectedIndex) {
                  context.read<HomeNavigatorProvider>().changePage(
                    selectedIndex,
                  );
                },

                sidebarItems: [
                  SideBarItem(
                    iconSelected: Icons.home_rounded,
                    iconUnselected: Icons.home_outlined,
                    text: 'Post',
                  ),
                  SideBarItem(
                    iconSelected: Icons.message,
                    iconUnselected: Icons.message_outlined,
                    text: 'Chat',
                  ),
                  SideBarItem(
                    iconSelected: Icons.person,
                    iconUnselected: Icons.person_outline,
                    text: 'Profile',
                  ),
                ],
              ),
              Expanded(
                child:
                    pages[context
                        .watch<HomeNavigatorProvider>()
                        .currentpageIndex],
              ),
            ],
          ),
        );
      },
    );
  }
}
