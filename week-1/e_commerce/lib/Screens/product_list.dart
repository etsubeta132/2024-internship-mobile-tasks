import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'package:e_commerce/Widgets/curved_rec_button.dart';
import 'package:e_commerce/Widgets/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM d,yyyy').format(date);
    List<Product> products = [
      const Product(
        imageUrl:
        'https://media.istockphoto.com/id/1136422297/photo/face-cream-serum-lotion-moisturizer-and-sea-salt-among-bamboo-leaves.jpg?s=612x612&w=0&k=20&c=mwzWVrDvJTkHlVf-8RL49Hs5xjuv1TrYcBW4DnWVt-0=',
        price: 100,
        rating: 4.5,
        name: 'Product 1',
        category: "hair care",
        description:
            "this hair care product deeply hydrates and strengthens hair, leaving it soft, silky, and irresistibly smooth.",
      ),
      const Product(
        imageUrl:
            'https://media.istockphoto.com/id/1394988455/photo/laptop-with-a-blank-screen-on-a-white-background.jpg?s=612x612&w=0&k=20&c=BXNMs3xZNXP__d22aVkeyfvgJ5T18r6HuUTEESYf_tE=',
        price: 29.99,
        rating: 4.3,
        name: 'Product2',
        category: "laptop computer",
        description:
            "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance,making them suitable for both formal and casual occasions.",
      ),
      const Product(
        imageUrl:
        'https://media.istockphoto.com/id/1198863709/photo/skin-and-hair-care-beauty-product-mock-up-lotion-bottle-oil-cream-isolated-on-white-3d-render.jpg?s=612x612&w=0&k=20&c=_0-9dLUohaQrThH0669Ygx3Ar17rX0cRkXy0cEexfQw=',
        price: 29.99,
        rating: 4.8,
        name: 'Product3',
        category: "men's shoes",
        description:
            "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance,making them suitable for both formal and casual occasions.",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // custom widget curved rectangle
                      const CurvedRecButton(
                        text: 'P',
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 8,
                        height: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formattedDate),
                          const Text('Hello, Etsubdink')
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.notification_add_rounded,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
            ),
            const SizedBox(
              child: Text(
                "Available Products",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 8,
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product product = products[index];
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed(
                          'productDetail',
                          queryParameters: {
                            'imageUrl': product.imageUrl,
                            'rating': product.rating.toString(),
                            'price': product.price.toString(),
                            'name': product.name,
                            'category': product.category,
                            'description': product.description,
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: product,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          onPressed: () {
            GoRouter.of(context).goNamed('addProduct');
          },
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
