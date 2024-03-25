part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  const GetProductState();
}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState{

  @override
  List<Object?> get props =>[];
  
}

class ProductSuccess extends ProductState{
  
}
