import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String image;
  const CachedNetworkImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, progress) {
          return LoadingWidget();
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
