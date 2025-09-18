import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/provider/home_navigator_provider.dart';
import 'package:test_app/features/home/widgets/bottom_navigation_bar_items.dart';

class MobileBottomNavigationWidget extends StatelessWidget {
  final List<Widget> pages;
  const MobileBottomNavigationWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNavigatorProvider(),
      builder: (context, child) {
        return Scaffold(
          body: pages[context.watch<HomeNavigatorProvider>().currentpageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context
                .watch<HomeNavigatorProvider>()
                .currentpageIndex,
            onTap: (value) =>
                context.read<HomeNavigatorProvider>().changePage(value),
            items: [
              BottomNavigationBarItems.bottomNavigationBarItemWidget(
                label: "Post",
                icon: const Icon(Icons.home),
              ),
              BottomNavigationBarItems.bottomNavigationBarItemWidget(
                label: "Chat",
                icon: const Icon(Icons.message),
              ),
              BottomNavigationBarItems.bottomNavigationBarItemWidget(
                label: "Profile",
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        );
      },
    );
  }
}
