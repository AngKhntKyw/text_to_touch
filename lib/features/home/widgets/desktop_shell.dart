import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/features/category/presentation/pages/category_page.dart';
import 'package:test_app/features/product/presentation/pages/product_page.dart';
import 'package:test_app/features/profile/presentation/pages/profile_page.dart';
import 'package:test_app/features/sale/presentation/pages/sale_page.dart';

class DesktopShell extends StatelessWidget {
  final Widget child;
  const DesktopShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.toString();

    return NavigationRail(
      selectedIndex: _getSelectedIndex(currentLocation),
      onDestinationSelected: (int index) {
        _onDestinationSelected(index, context);
      },
      labelType: NavigationRailLabelType.all,
      extended: false,
      minExtendedWidth: 400,
      trailing: Icon(Icons.maximize),

      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.poll_outlined),
          selectedIcon: Icon(Icons.poll),
          label: Text('Product'),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: Text('Category'),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Profile'),
        ),

        NavigationRailDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          selectedIcon: Icon(Icons.shopping_bag),
          label: Text('Sale'),
        ),
      ],
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
