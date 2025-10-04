import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/domain/usecases/add_new_product.dart';
import 'package:test_app/features/product/domain/usecases/delete_product.dart';
import 'package:test_app/features/product/domain/usecases/get_products.dart';
import 'package:test_app/features/product/domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts _getProducts;
  final AddNewProduct _addNewProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  List<ProductModel> _products = [];

  ProductBloc({
    required GetProducts getProducts,
    required AddNewProduct addNewProduct,
    required UpdateProduct updateProduct,
    required DeleteProduct deleteProduct,
  }) : _getProducts = getProducts,
       _addNewProduct = addNewProduct,
       _updateProduct = updateProduct,
       _deleteProduct = deleteProduct,
       super(ProductInitial()) {
    on<ProductEvent>((_, emit) => emit(ProductLoading()));
    on<GetProductsEvent>(onGetProductsEvent);
    on<AddNewProductEvent>(onAddNewProductEvent);
    on<UpdateProductEvent>(onUpdateProductEvent);
    on<DeleteProductEvent>(onDeleteProductEvent);
  }

  void onGetProductsEvent(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final response = await _getProducts.call(
      GetProductsParams(categoryId: event.categoryId),
    );
    response.fold((failure) => emit(ProductFailure(failure: failure)), (
      products,
    ) {
      _products = products;
      emit(ProductLoaded(products: _products));
    });
  }

  void onAddNewProductEvent(
    AddNewProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    final response = await _addNewProduct.call(
      AddNewProductParams(
        categoryId: event.categoryId,
        product: event.productModel,
        image: event.image,
      ),
    );

    response.fold((failure) => emit(ProductFailure(failure: failure)), (
      product,
    ) {
      _products = [..._products, product];
      emit(ProductAdded(product: product, products: _products));
    });
  }

  void onUpdateProductEvent(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    final response = await _updateProduct.call(
      UpdateProductParams(
        categoryId: event.categoryId,
        product: event.productModel,
        image: event.image,
      ),
    );

    response.fold((failure) => emit(ProductFailure(failure: failure)), (
      product,
    ) {
      _products = _products
          .map((c) => c.id == product.id ? product : c)
          .toList();
      emit(ProductUpdated(product: product, products: _products));
    });
  }

  void onDeleteProductEvent(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    final response = await _deleteProduct.call(
      DeleteProductParams(
        categoryId: event.categoryId,
        productId: event.productId,
      ),
    );

    response.fold((failure) => emit(ProductFailure(failure: failure)), (
      product,
    ) {
      _products.removeWhere((c) => c.id == event.productId);
      emit(ProductDeleted(products: _products));
    });
  }
}
