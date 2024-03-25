import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String image;
  final double rating;
  final double price;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.image,
    required this.rating,
    required this.price,
    required this.title,
    required this.category,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, image, rating, price, category, description];
}
