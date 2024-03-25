import 'dart:convert';

import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tProductModel = ProductModel(
      id:'25131570-9733-4d42-8ff1-56bd8d2a8e9a',
      title: 'title',
      image: '',
      rating: 0.0,
      price: 0.0,
      category: 'category',
      description: 'description');

  test('should be a subclass of ProductModel', () async {
    expect(tProductModel, isA<ProductModel>());
  });

  group('fromJson', () {
    test('should return a valid the model', () async {
      // arange
      final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));
      //  act

      final result = ProductModel.fromJson(jsonMap);

      // assert
      expect(result, tProductModel);
    });
  });

  group('toJson', () {
    test('should return a valid the json', () async {
      //  act

      final result = tProductModel.toJson();

      // assert
      final expectedMap = {
        "_id":"25131570-9733-4d42-8ff1-56bd8d2a8e9a",
        "title": "title",
        "image": "",
        "rating":  {'rate': 0, 'count': 0},
        "price": "0.0",
        "category": "category",
        "description": "description"
      };
      expect(result, expectedMap);
    });
  });
}
