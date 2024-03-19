import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final double price;
  final String title;
  final String description;

  const Product({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: Image.network(
              imageUrl,
              height: 150, 
              width:double.infinity, 
              fit: BoxFit.cover, 
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(description),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.star,color: Colors.yellow,),
                        Text('($rating)'),
                      ],
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
            ),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
