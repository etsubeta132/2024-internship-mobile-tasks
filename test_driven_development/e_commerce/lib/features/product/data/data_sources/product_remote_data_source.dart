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
    final Uri url = Uri.parse('${BASE_URL}');
    final response = await client.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()));
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body)['product']);
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<ProductModel> addProduct(ProductModel product, File? imageFile) async {
  //   var url = Uri.parse(BASE_URL);
  //   var request = http.MultipartRequest('POST', url);
  //   request.fields["title"] = product.title;
  //   request.fields["description"] = product.description;
  //   request.fields["category"] = product.category;
  //   request.fields["price"] = product.price.toString();
  //   if (imageFile != null) {
  //       var multipartImage = http.MultipartFile.fromBytes(
  //         contentType: MediaType('image', imageFile.path.split(".").last),
  //         "images",
  //         imageFile.readAsBytesSync(), // Read bytes directly from file
  //         filename: imageFile.path,
  //       );
  //       request.files.add(multipartImage);
  // }
  //   var imageByteLength = request.contentLength;
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   request.headers.addAll(headers);
  //   final response = await request.send();
  //   var res = await http.Response.fromStream(response);
  //   print(res.body);
  //   print(res.statusCode);
  //   if (res.statusCode == 201) {
  //     return ProductModel.fromJson(json.decode(res.body)["product"]);
  //   } else {
  //     throw ServerException();
  //   }
  // }
  // @override
  // Future<ProductModel> addProduct(ProductModel product, File? imageFile) async {
  //   final Uri url = Uri.parse(BASE_URL);
  //   final request = http.MultipartRequest('POST', url);

  //   // Set headers (if needed)
  //   request.headers['Content-Type'] = 'multipart/form-data';

  //   // Add product data as fields (if needed)

  //   request.fields['title'] = product.title;
  //   // request.fields['rating'] = product.rating.toString();
  //   request.fields['price'] = product.price.toString();
  //   request.fields['category'] = product.category;

  //   // Add image file
  //   if (imageFile != null) {
  //     final imageStream =
  //         http.ByteStream(Stream.castFrom(imageFile.openRead()));
  //     final imageLength = await imageFile.length();
  //     final imageUpload = http.MultipartFile(
  //       'image', // Field name on the server
  //       imageStream,
  //       imageLength,
  //       filename: 'product_image.jpg', // Specify a filename for the image
  //     );
  //     request.files.add(imageUpload);
  //   }

  //   final response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 201) {
  //     final responseBody = await response.stream.bytesToString();
  //     return ProductModel.fromJson(json.decode(responseBody)['product']);
  //   } else {
  //     throw ServerException();
  //   }
  // }

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
    final Uri url = Uri.parse('${BASE_URL}/$id');

    final response = await client.patch(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responceBody = json.decode(response.body);
      return ProductModel.fromJson(responceBody['product']);
    } else {
      throw ServerException();
    }
  }
}
