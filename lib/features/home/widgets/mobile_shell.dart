import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/features/category/presentation/pages/category_page.dart';
import 'package:test_app/features/product/presentation/pages/product_page.dart';
import 'package:test_app/features/profile/presentation/pages/profile_page.dart';
import 'package:test_app/features/sale/presentation/pages/sale_page.dart';

class MobileShell extends StatelessWidget {
  final Widget child;
  const MobileShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();
    final int selectedIndex = _getSelectedIndex(currentLocation);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          _onDestinationSelected(index, context);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_outlined),
            activeIcon: Icon(Icons.poll),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Sale',
          ),
        ],
      ),
    );
  }
}

int _getSelectedIndex(String currentLocation) {
  if (currentLocation.startsWith(ProductPage.routeName)) return 0;
  if (currentLocation.startsWith(CategoryPage.routeName)) return 1;
  if (currentLocation.startsWith(ProfilePage.routeName)) return 2;
  if (currentLocation.startsWith(SalePage.routeName)) return 3;
  return 0;
}

void _onDestinationSelected(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go(ProductPage.routeName);
      break;
    case 1:
      context.go(CategoryPage.routeName);
      break;
    case 2:
      context.go(ProfilePage.routeName);
      break;
    case 3:
      context.go(SalePage.routeName);
      break;
  }
}
