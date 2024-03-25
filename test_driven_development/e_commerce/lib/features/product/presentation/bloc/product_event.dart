part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class GetOneProduct extends ProductEvent {
  late final String id;

  GetOneProduct(this.id);
}

class GetProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel productModel;

  AddProduct(this.productModel);
}

class UpdateProduct extends ProductEvent {
  late final String id;

  UpdateProduct(this.id);
}

class DeleteProduct extends ProductEvent {
  late final String id;

  DeleteProduct(this.id);
}
