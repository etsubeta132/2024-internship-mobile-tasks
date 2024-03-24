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
            'https://s3-alpha-sig.figma.com/img/005f/a4d5/e74cfc63b04b98f4bd9fd3c66b91c014?Expires=1711324800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lNXsWS5tmHBRRiHa5owwbmPDZ8itM9sxsHd0rQpEjYqjEoOddPR2sPUhNDfnzDMCHpVUJmZ4zhr8V0YP9NYi3aKgVhtvydwCfB1zkUvIP4row~OFLcH1FSMVe6cO4jRkkDThtIEpKn2KrW0MGbwKtMB7j9Wwwr291SMR64gHb4Lg-6~rmaGCnENhBHsMrlTQ8r6DTmb~bDDA4qqVz5wJtFD3-KsGX91VFhFNO3-wVP4pQUjZsKwtq0FO~y8eMn9qDnEdJTzlR5P-Pyg82-fqOehtcKYqWFUsqI9jy7txwcQP5fXvpkQHi3XzpRqkfL5~CqrDibHUIiltkAFP7Synvg__',
        price: 100,
        rating: 4.5,
        name: 'Product 1',
        category: "men's shoes",
        description:
            "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance,making them suitable for both formal and casual occasions.",
      ),
      const Product(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/005f/a4d5/e74cfc63b04b98f4bd9fd3c66b91c014?Expires=1711324800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lNXsWS5tmHBRRiHa5owwbmPDZ8itM9sxsHd0rQpEjYqjEoOddPR2sPUhNDfnzDMCHpVUJmZ4zhr8V0YP9NYi3aKgVhtvydwCfB1zkUvIP4row~OFLcH1FSMVe6cO4jRkkDThtIEpKn2KrW0MGbwKtMB7j9Wwwr291SMR64gHb4Lg-6~rmaGCnENhBHsMrlTQ8r6DTmb~bDDA4qqVz5wJtFD3-KsGX91VFhFNO3-wVP4pQUjZsKwtq0FO~y8eMn9qDnEdJTzlR5P-Pyg82-fqOehtcKYqWFUsqI9jy7txwcQP5fXvpkQHi3XzpRqkfL5~CqrDibHUIiltkAFP7Synvg__',
        price: 29.99,
        rating: 4.3,
        name: 'Product2',
        category: "men's shoes",
        description:
            "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance,making them suitable for both formal and casual occasions.",
      ),
      const Product(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/005f/a4d5/e74cfc63b04b98f4bd9fd3c66b91c014?Expires=1711324800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lNXsWS5tmHBRRiHa5owwbmPDZ8itM9sxsHd0rQpEjYqjEoOddPR2sPUhNDfnzDMCHpVUJmZ4zhr8V0YP9NYi3aKgVhtvydwCfB1zkUvIP4row~OFLcH1FSMVe6cO4jRkkDThtIEpKn2KrW0MGbwKtMB7j9Wwwr291SMR64gHb4Lg-6~rmaGCnENhBHsMrlTQ8r6DTmb~bDDA4qqVz5wJtFD3-KsGX91VFhFNO3-wVP4pQUjZsKwtq0FO~y8eMn9qDnEdJTzlR5P-Pyg82-fqOehtcKYqWFUsqI9jy7txwcQP5fXvpkQHi3XzpRqkfL5~CqrDibHUIiltkAFP7Synvg__',
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
          child: const Icon(Icons.add)),
    );
  }
}
