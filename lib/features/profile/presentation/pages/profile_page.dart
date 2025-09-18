import 'package:flutter/material.dart';
import 'package:test_app/theme_setting_page.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile-page";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(ThemeSettingsPage.routeName),
            leading: Icon(Icons.color_lens),
            title: Text("Theme"),
          ),
        ],
      ),
    );
  }
}
