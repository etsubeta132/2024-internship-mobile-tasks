
import 'package:flutter/material.dart';

import 'package:e_commerce/Components/curved_rec_button.dart';
import 'package:e_commerce/Components/product.dart';


class ProductDetail extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final double price;
  final String title;
  final String description;

  const ProductDetail({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Product(
                imageUrl: imageUrl,
                rating: rating,
                price: price,
                title: title,
                description: description,
              ),
              Positioned(
                top: 16,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                  color: Colors.blue,
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                )
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.none
                ),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CurvedRecButton(text: '39',color: Colors.white,),
                      CurvedRecButton(text: '40',color: Colors.white,),
                      CurvedRecButton(text: '41',color: Colors.white,),
                      CurvedRecButton(text: '42',color: Colors.blue,),
                      CurvedRecButton(text: '43',color: Colors.white,),
                      CurvedRecButton(text: '44',color: Colors.white,),
                      CurvedRecButton(text: '39',color: Colors.white,),
                      CurvedRecButton(text: '40',color: Colors.white,),
                      CurvedRecButton(text: '41',color: Colors.white,),
                      CurvedRecButton(text: '42',color: Colors.white,),
                      CurvedRecButton(text: '43',color: Colors.white,),
                      CurvedRecButton(text: '44',color: Colors.white,),
                    ],
                  )),
            ],
          ),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    '''A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance,making them suitable for both formal and casual occasions.''',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      decoration: TextDecoration.none

                    ),
                  )),
            ),
          ),
          Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side:const BorderSide(color: Colors.red))
              ),
              onPressed: () {},
              child: const Text('Delete',
                  style: TextStyle(color: Colors.red),),
            ),
            const SizedBox(width: 48),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  )
              ),
              onPressed: () {},
              child: const Text('Update'),
            ),
            const SizedBox(height: 8)
            ],
        ),
          )
          
        ],
      ),
    );
  }
}
