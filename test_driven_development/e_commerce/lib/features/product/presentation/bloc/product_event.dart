part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {}

class GetOneProductEvent extends ProductEvent {
  final String id;

  GetOneProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetAllProductsEvent extends ProductEvent {
  GetAllProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProductsEvent extends ProductEvent {
  final String searchQuery;

  FetchAllProductsEvent({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}


class AddProductEvent extends ProductEvent {
  final ProductModel product;
  final File? imageFile;

  AddProductEvent({required this.product, this.imageFile});

  @override
  List<Object?> get props => [product, imageFile];
}

class UpdateProductEvent extends ProductEvent {
  final String id;
  final ProductModel product;
  final File? imageFile;

  UpdateProductEvent({required this.product, required this.id, this.imageFile});

  @override
  List<Object?> get props => [id, product, imageFile];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
