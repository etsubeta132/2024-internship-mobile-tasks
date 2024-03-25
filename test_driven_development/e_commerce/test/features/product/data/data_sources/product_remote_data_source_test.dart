import 'dart:convert';

import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  ProductRemoteDataSourceImpl dataSource;
  MockClient mockHttpClient;

  mockHttpClient = MockClient();
  dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('product.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getProduct', () {
    const tid = '25131570-9733-4d42-8ff1-56bd8d2a8e9a';

    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    test(
      'should preform a GET request on a URL with id being the endpoint and with application/json header',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSource.getOneProduct(tid);

        // assert
        final Uri url = Uri.parse(
            'https://products-api-5a5n.onrender.com/api/v1/products/$tid');
        verify(mockHttpClient.get(
          url,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Product when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSource.getOneProduct(tid);

        // assert
        expect(result, equals(tProductModel));
      },
    );

    test(
      'should throw a Server Exception when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();

        // act
        final call = dataSource.getOneProduct;

        // assert
        expect(() => call(tid), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

 group('getProducts', () {
    final mockProducts = [
      ProductModel(
        id: '65f015b8067e341298b2aa56',
        title: 'Product 2',
        image: 'https://via.placeholder.com/500x500.png?text=Product+Image',
        rating: 0,
        price: 300,
        category: 'Products',
        description: 'This is the description for product 2',
      ),
  
    ];

    test('should return a list of ProductModel when the http call is successful', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(json.encode({
                'products': mockProducts.map((product) => product.toJson()).toList(),
                'currentPage': 1,
                'totalPages': 1,
                'totalCount': 4,
                'pageSize': 4,
              }), 200));

      // Act
      final result = await dataSource.getProducts();

      // Assert
      expect(result, mockProducts);
    });

    test('should throw a ServerException when the http call is unsuccessful', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error occurred', 404));

      // Act
      final call = dataSource.getProducts;

      // Assert
      expect(call(), throwsA(isA<ServerException>()));
    });
  });
}
