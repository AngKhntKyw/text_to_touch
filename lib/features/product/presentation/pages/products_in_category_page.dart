import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/errors_widget.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/utils/show_error_snackbar.dart';
import 'package:test_app/core/utils/show_success_snackbar.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:test_app/features/product/presentation/pages/add_product_page.dart';
import 'package:test_app/features/product/presentation/widgets/product_widget.dart';

class ProductInCategoryPage extends StatefulWidget {
  static const routeName = "/products-in-category-page";
  final CategoryModel category;
  const ProductInCategoryPage({super.key, required this.category});

  @override
  State<ProductInCategoryPage> createState() => _ProductInCategoryPageState();
}

class _ProductInCategoryPageState extends State<ProductInCategoryPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(
      GetProductsEvent(categoryId: widget.category.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    ///
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            actions: [
              TextButton(
                onPressed: () => context.goNamed(
                  AddProductInCategoryPage.routeName,
                  extra: {'categoryId': widget.category.id},
                ),
                child: Row(children: [Icon(Icons.add), Text("Add Product")]),
              ),
            ],
          ),
          body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductFailure) {
                showErrorSnackBar(context, state.failure.message);
              }
              if (state is ProductAdded) {
                showSuccessSnackBar(context, "New Product Added Successfully.");
              }
              if (state is ProductUpdated) {
                showSuccessSnackBar(context, "Product Updated Successfully.");
              }
              if (state is ProductDeleted) {
                showSuccessSnackBar(context, "Product Deleted Successfully.");
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return const LoadingWidget();
              }
              if (state is ProductFailure) {
                return ErrorsWidget(failure: state.failure);
              }

              List<ProductModel> products = [];

              if (state is ProductLoaded) {
                products = state.products;
              } else if (state is ProductAdded) {
                products = state.products;
              } else if (state is ProductUpdated) {
                products = state.products;
              } else if (state is ProductDeleted) {
                products = state.products;
              }

              if (products.isEmpty) {
                return ErrorsWidget(
                  failure: Failure(500, "No Products Found."),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: size.width / 20,
                    crossAxisSpacing: size.width / 20,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductWidget(
                      product: product,
                      categoryId: widget.category.id,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      tabletBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            actions: [
              TextButton(
                onPressed: () => context.goNamed(
                  AddProductInCategoryPage.routeName,
                  extra: {'categoryId': widget.category.id},
                ),
                child: Row(children: [Icon(Icons.add), Text("Add Product")]),
              ),
            ],
          ),
          body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductFailure) {
                showErrorSnackBar(context, state.failure.message);
              }
              if (state is ProductAdded) {
                showSuccessSnackBar(context, "New Product Added Successfully.");
              }
              if (state is ProductUpdated) {
                showSuccessSnackBar(context, "Product Updated Successfully.");
              }
              if (state is ProductDeleted) {
                showSuccessSnackBar(context, "Product Deleted Successfully.");
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return const LoadingWidget();
              }
              if (state is ProductFailure) {
                return ErrorsWidget(failure: state.failure);
              }

              List<ProductModel> products = [];

              if (state is ProductLoaded) {
                products = state.products;
              } else if (state is ProductAdded) {
                products = state.products;
              } else if (state is ProductUpdated) {
                products = state.products;
              } else if (state is ProductDeleted) {
                products = state.products;
              }

              if (products.isEmpty) {
                return ErrorsWidget(
                  failure: Failure(500, "No Products Found."),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: size.width / 20,
                    crossAxisSpacing: size.width / 20,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductWidget(
                      product: product,
                      categoryId: widget.category.id,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
      desktopBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            actions: [
              TextButton(
                onPressed: () => context.goNamed(
                  AddProductInCategoryPage.routeName,
                  extra: {'categoryId': widget.category.id},
                ),
                child: Row(children: [Icon(Icons.add), Text("Add Product")]),
              ),
            ],
          ),
          body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductFailure) {
                showErrorSnackBar(context, state.failure.message);
              }
              if (state is ProductAdded) {
                showSuccessSnackBar(context, "New Product Added Successfully.");
              }
              if (state is ProductUpdated) {
                showSuccessSnackBar(context, "Product Updated Successfully.");
              }
              if (state is ProductDeleted) {
                showSuccessSnackBar(context, "Product Deleted Successfully.");
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return const LoadingWidget();
              }
              if (state is ProductFailure) {
                return ErrorsWidget(failure: state.failure);
              }

              List<ProductModel> products = [];

              if (state is ProductLoaded) {
                products = state.products;
              } else if (state is ProductAdded) {
                products = state.products;
              } else if (state is ProductUpdated) {
                products = state.products;
              } else if (state is ProductDeleted) {
                products = state.products;
              }

              if (products.isEmpty) {
                return ErrorsWidget(
                  failure: Failure(500, "No Products Found."),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: size.width / 20,
                    crossAxisSpacing: size.width / 20,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductWidget(
                      product: product,
                      categoryId: widget.category.id,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
