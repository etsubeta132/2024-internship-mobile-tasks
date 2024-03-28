import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';

import 'package:e_commerce/features/product/domain/usecases/get_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// import 'get_products.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  // group("get all product", () {
  //   test('returns all product', () async {
  //     final getproducts = MockGetProducts();
  //     final expected = [
  //       Product(
  //         id:'25131570-9733-4d42-8ff1-56bd8d2a8e9a',
  //         imageUrl: "",
  //         rating: 0,
  //         price: 0,
  //         name: "",
  //         category: "",
  //         description: "",
  //       ),
      
  //     ];

  //     //  arange
  //     when(getproducts.call(NoParams()))
  //         .thenAnswer((_) async => Right(expected));

  //     // act
  //     final result = await getproducts.call(NoParams());

  //     //  assert
  //     expect(result, Right(expected));
  //   });
  // });
}
