import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/errors_widget.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:test_app/features/product/presentation/pages/add_product_page.dart';
import 'package:test_app/features/product/presentation/widgets/product_widget.dart';

class ProductPage extends StatefulWidget {
  static const routeName = "/product-page";
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoriesEvent());
  }

  void _fetchProducts(String categoryId) {
    context.read<ProductBloc>().add(GetProductsEvent(categoryId: categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryLoading) {
          return const LoadingWidget();
        }

        List<CategoryModel> categories = [];
        if (categoryState is CategoryLoaded) {
          categories = categoryState.categories;

          if (_selectedCategory == null && categories.isNotEmpty) {
            _selectedCategory = categories.first;
            _fetchProducts(_selectedCategory!.id);
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
            actions: [
              TextButton(
                onPressed: () {
                  context.goNamed(
                    AddProductInCategoryPage.routeName,
                    extra: {'categoryId': _selectedCategory!.id},
                  );
                  if (_selectedCategory != null) {
                    context.read<ProductBloc>().add(
                      GetProductsEvent(categoryId: _selectedCategory!.id),
                    );
                  }
                },
                child: Row(children: [Icon(Icons.add), Text("Add Product")]),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategoryDropdown(categories),
              Expanded(child: _buildProductsList()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryDropdown(List<CategoryModel> categories) {
    final size = MediaQuery.sizeOf(context);
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<CategoryModel>(
            decoration: InputDecoration(
              labelText: 'Filter by Category',
              constraints: BoxConstraints(maxWidth: size.width / 2),
            ),
            value: _selectedCategory,
            items: categories.map((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (CategoryModel? newCategory) {
              if (newCategory != null) {
                setState(() {
                  _selectedCategory = newCategory;
                });
                _fetchProducts(newCategory.id);
              }
            },
          ),
        );
      },
      tabletBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<CategoryModel>(
            decoration: InputDecoration(
              labelText: 'Filter by Category',
              constraints: BoxConstraints(maxWidth: size.width / 4),
            ),
            value: _selectedCategory,
            items: categories.map((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (CategoryModel? newCategory) {
              if (newCategory != null) {
                setState(() {
                  _selectedCategory = newCategory;
                });
                _fetchProducts(newCategory.id);
              }
            },
          ),
        );
      },
      desktopBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<CategoryModel>(
            decoration: InputDecoration(
              labelText: 'Filter by Category',
              constraints: BoxConstraints(maxWidth: size.width / 6),
            ),
            value: _selectedCategory,
            items: categories.map((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (CategoryModel? newCategory) {
              if (newCategory != null) {
                setState(() {
                  _selectedCategory = newCategory;
                });
                _fetchProducts(newCategory.id);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildProductsList() {
    final size = MediaQuery.sizeOf(context);

    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const LoadingWidget();
            }

            List<ProductModel> products = [];

            if (productState is ProductLoaded) {
              products = productState.products;
            } else if (productState is ProductAdded) {
              products = productState.products;
            } else if (productState is ProductUpdated) {
              products = productState.products;
            } else if (productState is ProductDeleted) {
              products = productState.products;
            }

            if (products.isEmpty) {
              return ErrorsWidget(failure: Failure(500, "No Products Found."));
            }

            if (products.isEmpty) {
              return const Center(
                child: Text('No products found for this category.'),
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
                    categoryId: _selectedCategory!.id,
                  );
                },
              ),
            );
          },
        );
      },
      tabletBuilder: (context) {
        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const LoadingWidget();
            }

            List<ProductModel> products = [];

            if (productState is ProductLoaded) {
              products = productState.products;
            } else if (productState is ProductAdded) {
              products = productState.products;
            } else if (productState is ProductUpdated) {
              products = productState.products;
            } else if (productState is ProductDeleted) {
              products = productState.products;
            }

            if (products.isEmpty) {
              return ErrorsWidget(failure: Failure(500, "No Products Found."));
            }

            if (products.isEmpty) {
              return const Center(
                child: Text('No products found for this category.'),
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
                    categoryId: _selectedCategory!.id,
                  );
                },
              ),
            );
          },
        );
      },
      desktopBuilder: (context) {
        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const LoadingWidget();
            }

            List<ProductModel> products = [];

            if (productState is ProductLoaded) {
              products = productState.products;
            } else if (productState is ProductAdded) {
              products = productState.products;
            } else if (productState is ProductUpdated) {
              products = productState.products;
            } else if (productState is ProductDeleted) {
              products = productState.products;
            }

            if (products.isEmpty) {
              return ErrorsWidget(failure: Failure(500, "No Products Found."));
            }

            if (products.isEmpty) {
              return const Center(
                child: Text('No products found for this category.'),
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
                    categoryId: _selectedCategory!.id,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
