import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const BASE_URL = 'https://products-api-5a5n.onrender.com/api/v1/products';

abstract class ProductRemoteDataSource {
  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProducts();

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> getOneProduct(String id);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> addProduct(ProductModel product, File? imageFile);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> updateProduct(
      ProductModel product, String id, File? imageFile);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> deleteProduct(String id);

 Future<List<ProductModel>> fetchProducts(String searchQuery);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getOneProduct(String id) async {
    final Uri url = Uri.parse('${BASE_URL}/$id');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return ProductModel.fromJson(result['product']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final Uri url = Uri.parse('${BASE_URL}');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsJson = responseData['products'];
      final res =
          productsJson.map((json) => ProductModel.fromJson(json)).toList();
      return res;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product, File? imageFile) async {
    final Uri url = Uri.parse(BASE_URL);
    final request = http.MultipartRequest('POST', url);

    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['title'] = product.title;
    // request.fields['rating'] = product.rating.toString();
    request.fields['price'] = product.price.toString();
    request.fields['category'] = product.category;
    request.fields['description'] = product.description;

    // Add image file
    if (imageFile != null) {
      final imageStream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final imageLength = await imageFile.length();
      final imageUpload = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: 'product_image.jpg',
      );
      request.files.add(imageUpload);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseBody)['product']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final Uri url = Uri.parse('${BASE_URL}/$id');
    final response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(
      ProductModel product, String id, File? imageFile) async {
    final Uri url = Uri.parse('$BASE_URL/$id');
    final request = http.MultipartRequest('PATCH', url);

    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['title'] = product.title;
    // request.fields['rating'] = product.rating.toString();
    request.fields['price'] = product.price.toString();
    request.fields['category'] = product.category;
    request.fields['description'] = product.description;

    // Add image file
    if (imageFile != null) {
      final imageStream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final imageLength = await imageFile.length();
      final imageUpload = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: 'product_image.jpg',
      );
      request.files.add(imageUpload);
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseBody)['product']);
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<List<ProductModel>> fetchProducts(String searchQuery) async {
    Uri url = Uri.parse('${BASE_URL}');
    Map<String, dynamic> queryParams = {};

    // Add search query parameter if available
    if (searchQuery.isNotEmpty) {
      queryParams['title'] = searchQuery;
    }
    url = url.replace(queryParameters: queryParams);
    print(url);
    print(url);
    print(url);

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsJson = responseData['products'];
      final res =
          productsJson.map((json) => ProductModel.fromJson(json)).toList();
      return res;
    } else {
      throw ServerException();
    }
  }
}
