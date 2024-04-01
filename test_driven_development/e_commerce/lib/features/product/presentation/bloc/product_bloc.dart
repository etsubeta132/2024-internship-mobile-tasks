import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/usecases/add_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_one_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_products_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/search_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/update_product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getproductsUsecase;
  final GetOneProductUseCase getOneProductUsecase;
  final AddProductUseCase addProductUsecase;
  final UpdateProductUseCase updateProductUsecase;
  final DeleteProductUseCase deleteProductUsecase;
  final FetchProductsUseCase fetchProductsUseCase;

  ProductBloc(
      {required this.getOneProductUsecase,
      required this.addProductUsecase,
      required this.updateProductUsecase,
      required this.deleteProductUsecase,
      required this.getproductsUsecase,
      required this.fetchProductsUseCase
      })
      : super(ProductInitial()) {
    on<GetAllProductsEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await getproductsUsecase(NoParams());
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: "failed to fetch"));
        },
        (products) {
          emit(
            AllProductsFetched(products: products),
          );
        },
      );
    });

     on<FetchAllProductsEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await fetchProductsUseCase(SearchParams(searchQuery: event.searchQuery));
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: "failed to fetch"));
        },
        (products) {
          emit(
            AllProductsFetched(products: products),
          );
        },
      );
    });

    on<GetOneProductEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await getOneProductUsecase(GetParams(id: event.id));
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: "failed to fetch"));
        },
        (product) {
          emit(
            SpecficProductFetched(product: product),
          );
        },
      );
    });

    on<AddProductEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await addProductUsecase(
          AddParams(product: event.product, imageFile: event.imageFile));
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: failure.toString()));
        },
        (product) {
          emit(
            ProductActionSuccess(message: "Product Added Successfuly"),
          );
        },
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await updateProductUsecase(UpdateParams(
          product: event.product, id: event.id, imageFile: event.imageFile));
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: failure.toString()));
        },
        (product) {
          emit(
            ProductActionSuccess(message: "Product updated Successfuly"),
          );
        },
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(
        ProductActionInProgress(),
      );
      final responce = await deleteProductUsecase(DeleteParams(id: event.id));
      responce.fold(
        (failure) {
          emit(ProductActionFailer(message: failure.toString()));
        },
        (product) {
          emit(
            ProductActionSuccess(message: "Product deleted Successfuly"),
          );
        },
      );
    });
  }

  
}
