import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/common/widget/loading_widget.dart';
import 'package:test_app/core/common/widget/responsive_builder.dart';
import 'package:test_app/core/common/widget/text_from_fields.dart';
import 'package:test_app/core/utils/fetch_image_from_url.dart';
import 'package:test_app/core/utils/pick_image.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';

class AddProductInCategoryPage extends StatefulWidget {
  static const routeName = "/add-product-page";
  final ProductModel? product;
  final String categoryId;
  const AddProductInCategoryPage({
    super.key,
    this.product,
    required this.categoryId,
  });

  @override
  State<AddProductInCategoryPage> createState() =>
      _AddProductInCategoryPageState();
}

class _AddProductInCategoryPageState extends State<AddProductInCategoryPage> {
  final formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final nameController = TextEditingController();
  final countController = TextEditingController();
  final priceController = TextEditingController();
  final barCodeController = TextEditingController();
  Uint8List? image;
  bool initializing = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      initializing = true;
      nameController.text = widget.product!.name;
      countController.text = widget.product!.count.toString();
      priceController.text = widget.product!.price.toString();
      barCodeController.text = widget.product!.barCode;

      fetchImageFromUrl(widget.product!.image).then((value) {
        setState(() {
          image = value;
          initializing = false;
        });
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    countController.dispose();
    priceController.dispose();
    barCodeController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (formKey.currentState!.validate()) {
      if (widget.product != null) {
        context.read<ProductBloc>().add(
          UpdateProductEvent(
            categoryId: widget.categoryId,
            productModel: ProductModel(
              id: widget.product!.id,
              name: nameController.text,
              price: int.parse(priceController.text),
              count: int.parse(countController.text),
              barCode: barCodeController.text,
              image: '',
              categoryId: widget.categoryId,
            ),
            image: image!,
          ),
        );
      } else {
        context.read<ProductBloc>().add(
          AddNewProductEvent(
            categoryId: widget.categoryId,
            productModel: ProductModel(
              id: "",
              name: nameController.text,
              price: int.parse(priceController.text),
              count: int.parse(countController.text),
              barCode: barCodeController.text,
              image: '',
              categoryId: widget.categoryId,
            ),
            image: image!,
          ),
        );
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    ///
    return ResponsiveBuilder(
      mobileBuilder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.product != null ? "Update Product" : "Add New Product",
            ),
            actions: [
              TextButton.icon(
                onPressed: _saveProduct,
                icon: const Icon(Icons.save),
                label: Text(widget.product != null ? "Update" : "Save"),
              ),
            ],
          ),
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const LoadingWidget();
              }
              return BarcodeKeyboardListener(
                bufferDuration: Duration(milliseconds: 200),
                onBarcodeScanned: (barcode) {
                  setState(() {
                    barCodeController.text = barcode;
                  });
                },
                useKeyDownEvent: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: selectImage,
                            child: Container(
                              height: size.height / 4,
                              width: size.height / 4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: initializing
                                  ? const LoadingWidget()
                                  : image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.folder),
                                        Text("Select Image"),
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFromFields(
                            hintText: 'product name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 16),
                          TextFromFields(
                            hintText: 'product count',
                            controller: countController,
                          ),
                          const SizedBox(height: 16),
                          TextFromFields(
                            hintText: 'product price',
                            controller: priceController,
                          ),
                          const SizedBox(height: 16),
                          TextFromFields(
                            hintText: 'bar code',
                            controller: barCodeController,
                          ),
                        ],
                      ),
                    ),
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
