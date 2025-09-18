import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  static const routeName = "/post-page";
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Post")));
  }
}
