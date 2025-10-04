import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/errors_widget.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/utils/show_error_snackbar.dart';
import 'package:test_app/core/utils/show_success_snackbar.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/features/category/presentation/pages/add_category_page.dart';
import 'package:test_app/features/category/presentation/widgets/category_widget.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = "/category-page";

  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Category"),
            actions: [
              TextButton(
                onPressed: () => context.goNamed(AddCategoryPage.routeName),
                child: Row(children: [Icon(Icons.add), Text("Add Category")]),
              ),
            ],
          ),
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryFailure) {
                showErrorSnackBar(context, state.failure.message);
              }
              if (state is CategoryAdded) {
                showSuccessSnackBar(
                  context,
                  "New Category Added Successfully.",
                );
              }
              if (state is CategoryUpdated) {
                showSuccessSnackBar(context, "Category Updated Successfully.");
              }
              if (state is CategoryDeleted) {
                showSuccessSnackBar(context, "Category Deleted Successfully.");
              }
            },
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const LoadingWidget();
              } else if (state is CategoryFailure) {
                return ErrorsWidget(failure: state.failure);
              }

              List<CategoryModel> categories = [];

              if (state is CategoryLoaded) {
                categories = state.categories;
              } else if (state is CategoryAdded) {
                categories = state.categories;
              } else if (state is CategoryUpdated) {
                categories = state.categories;
              } else if (state is CategoryDeleted) {
                categories = state.categories;
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("No")),
                        Expanded(child: Text("Name")),
                        Expanded(child: Text("Actions")),
                      ],
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryWidget(category: category, index: index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
