import 'dart:convert';

import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e_commerce/features/product/data/data_sources/product_local_data_source.dart';
import '../../../../fixtures/fixture_reader.dart';
// import 'product_local_data_source_test.mocks.dart';
import 'package:e_commerce/core/error/exceptions.dart';

import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  ProductLocalDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  mockSharedPreferences = MockSharedPreferences();
  dataSource =
      ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  group('getLocalProducts', (){
    test('should return a list of ProductModel from SharedPreferences',
        () async {
      final jsonString = fixture('cathed_product.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();

      // arrange
      when(mockSharedPreferences.getString('CACHED_PRODUCT'))
          .thenReturn(jsonString);

      //   act
      final result = await dataSource.getLocalProducts();

      // assert
      expect(result, products);
    });

    test('should throw cache exception if there is no cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //   act
      final call = dataSource.getLocalProducts;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group(
    "cachedProduct",
    () {
      final productList = [
        ProductModel(
          id: '25131570-9733-4d42-8ff1-56bd8d2a8e9a',
          title: "",
          image: "",
          rating: 0,
          price: 0,
          category: "",
          description: "",
        ),
      ];
      test(
        "should call sharedpreferences to  cache the data ",
        () async {
          // arrange
          final jsonString =
              json.encode(productList.map((product) => product.toJson()).toList());
          when(mockSharedPreferences.setString('CACHED_PRODUCT', jsonString))
              .thenAnswer((_) async => true);

          // act
          dataSource.cacheLocalProducts(productList);



          verify(mockSharedPreferences.setString('CACHED_PRODUCT', jsonString));
        },
      );
    },
  );
}
