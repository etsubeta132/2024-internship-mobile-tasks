import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:e_commerce/features/product/presentation/widgets/curved_rec_button.dart';
import 'package:e_commerce/features/product/presentation/widgets/loading.dart';
import 'package:e_commerce/features/product/presentation/widgets/message_display.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_item.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM d,yyyy').format(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
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
      
      body:BlocConsumer<ProductBloc, ProductState>(
        listener: (BuildContext context, ProductState state) {
          if (state is ProductActionFailer) {
            const MessageDisplay(
              message: "bad state",
            );
          }
        },
        builder: (context, state) {
          if (state is ProductActionInProgress) {
            return const Center(
              child: Loading(),
            );
          } else if (state is AllProductsFetched) {
            return Container(
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
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                          Product product = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).goNamed(
                                'productDetail',
                                pathParameters:{'id':product.id}
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: ProductItem(product: product),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No products available'),
            );
          }
        },
      ),
     floatingActionButton: FloatingActionButton(
          backgroundColor:  Color.fromRGBO(63, 81, 243, 1),
          shape: const CircleBorder(),
          onPressed: () {
            GoRouter.of(context).pushNamed('addProduct');
          },
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}





