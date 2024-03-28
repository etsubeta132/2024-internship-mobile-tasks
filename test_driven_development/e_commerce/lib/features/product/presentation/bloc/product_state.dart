part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {}



final class ProductInitial extends ProductState {
   
  @override
  List<Object?> get props =>[];

}

class ProductActionInProgress extends ProductState{

  @override
  List<Object?> get props =>[];
  
}

class ProductActionSuccess extends ProductState{
  final String message;
    
    ProductActionSuccess({required this.message});

  @override
  List<Object?> get props => [message];

}

class ProductActionFailer extends ProductState{
  final String message;
    
    ProductActionFailer({required this.message});
    
  @override
  List<Object?> get props => [message];

}


class AllProductsFetched extends ProductState{
  final List<ProductModel> products;

  AllProductsFetched({required this.products});

  @override
  List<Object> get props => [products];

}


class SpecficProductFetched extends ProductState{
  final ProductModel product;

  SpecficProductFetched({required this.product});

  @override
  List<Object> get props => [product];

}