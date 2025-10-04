import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/features/category/presentation/pages/add_category_page.dart';
import 'package:test_app/features/product/presentation/pages/products_in_category_page.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final int index;
  const CategoryWidget({
    super.key,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(ProductInCategoryPage.routeName, extra: category);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text("${index + 1}")),
          Expanded(child: Text(category.name)),
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.goNamed(AddCategoryPage.routeName, extra: category);
                  },
                  icon: Icon(Icons.edit_note),
                ),
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete Category"),
                          content: Text(
                            "Are you sure you want to delete ${category.name}?",
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
                                context.read<CategoryBloc>().add(
                                  DeleteCategoryEvent(categoryId: category.id),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
