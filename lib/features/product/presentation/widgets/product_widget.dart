import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/cached_network_image_widget.dart';
import 'package:test_app/core/theme/app_palette.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:test_app/features/product/presentation/pages/add_product_page.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final String categoryId;
  const ProductWidget({
    super.key,
    required this.product,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: CachedNetworkImageWidget(image: product.image),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(product.name), Text(product.price.toString())],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.greyColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: () => context.goNamed(
                    AddProductInCategoryPage.routeName,
                    extra: {'product': product, 'categoryId': categoryId},
                  ),
                  icon: Icon(Icons.edit_note),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.greyColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete Product"),
                          content: Text(
                            "Are you sure you want to delete ${product.name}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                                context.read<ProductBloc>().add(
                                  DeleteProductEvent(
                                    categoryId: categoryId,
                                    productId: product.id,
                                  ),
                                );
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
