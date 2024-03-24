import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final double price;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.name,
    required this.category,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, rating, price, category, description];
}
