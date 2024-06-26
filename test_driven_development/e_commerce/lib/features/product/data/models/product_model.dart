import 'package:e_commerce/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String image,
    required double rating,
    required double price,
    required String title,
    required String category,
    required String description,
  }) : super(
            id: id,
            title: title,
            image: image,
            rating: rating,
            price: price,
            category: category,
            description: description);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
 
    return ProductModel(
      id: json['_id'],
      image: json['image'],
      rating: double.tryParse((json['rating']['rate']).toString()) ?? 0.0,
      price: double.tryParse((json['price']).toString()) ?? 0.0,
      title: json['title'],
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "image": image,
      "rating": {'rate': rating, 'count': 0},
      "price": price,
      "category": category,
      "description": description
    };
  }
}
