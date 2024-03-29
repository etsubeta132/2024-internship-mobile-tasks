// import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/presentation/bloc/bloc.dart';
import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:e_commerce/features/product/presentation/widgets/loading.dart';
import 'package:e_commerce/features/product/presentation/widgets/message_display.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({super.key, required this.productId});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetOneProductEvent(widget.productId));
  }

  void deleteProduct(BuildContext context, pId) {
    context.read<ProductBloc>().add(DeleteProductEvent(id: pId));
  }

  int currentNumber = 32;
  int selectedIndex = 0;

  void tapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductActionFailer) {
          const MessageDisplay(message: "Failed to Fetch");
        }
      },
      builder: (BuildContext context, ProductState state) {
        if (state is ProductActionInProgress) {
          return const Center(
            child: Loading(),
          );
        } else if (state is SpecficProductFetched) {
          return _buildProductDetail(context, state.product);
        } else {
          return const MessageDisplay(message: 'No product available');
        }
      },
    );
  }

  Widget _buildProductDetail(BuildContext context, Product product) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ProductItem(product: product),
              Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      color: Colors.blue,
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        GoRouter.of(context).goNamed('productList');
                      },
                    ),
                  )),
            ],
          ),
          const Text(
            "Size: ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  bool isSelected = (index == selectedIndex);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => tapped(index),
                      child: Container(
                        width: 50,
                        height: 70,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(4.0, 4.0),
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                                color: Color.fromARGB(255, 236, 234, 234)),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? const Color.fromRGBO(63, 81, 243, 1)
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              (index + currentNumber).toString(),
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  color:
                                      isSelected ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
                height: 60,
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  // ! product description
                  product.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      decoration: TextDecoration.none),
                )),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.red))),
                  onPressed: () {
                    deleteProduct(context, product.id);
                    GoRouter.of(context).goNamed('productList');
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  onPressed: () {
                    GoRouter.of(context).goNamed(
                      'updateProduct',
                      pathParameters: {"id": widget.productId},
                      queryParameters: {
                        'image': product.image,
                        'rating': product.rating.toString(),
                        'price': product.price.toString(),
                        'title': product.title,
                        'category': product.category,
                        'description': product.description,
                      },
                    );
                  },
                  child: const Text('UPDATE'),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
