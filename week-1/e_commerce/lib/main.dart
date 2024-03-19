
import 'package:e_commerce/Screens/product_list.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const EcommercePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class EcommercePage extends StatefulWidget {
  const EcommercePage({super.key, required this.title});

  final String title;

  @override
  State<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductList()
     
    );
  }
}
