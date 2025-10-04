import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/common/widget/text_from_fields.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';

class AddCategoryPage extends StatefulWidget {
  static const routeName = "/add-category-page";
  final CategoryModel? category;
  const AddCategoryPage({super.key, this.category});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category!.name;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (formKey.currentState!.validate()) {
      if (widget.category != null) {
        context.read<CategoryBloc>().add(
          UpdateCategoryEvent(
            categoryModel: CategoryModel(
              id: widget.category!.id,
              name: nameController.text,
            ),
          ),
        );
      } else {
        context.read<CategoryBloc>().add(
          AddNewCategoryEvent(name: nameController.text),
        );
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.category != null ? "Update Category" : "Add New Category",
            ),
            actions: [
              TextButton.icon(
                onPressed: _saveCategory,
                icon: const Icon(Icons.save),
                label: Text(widget.category != null ? "Update" : "Save"),
              ),
            ],
          ),
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const LoadingWidget();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFromFields(
                        hintText: 'category name',
                        controller: nameController,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
