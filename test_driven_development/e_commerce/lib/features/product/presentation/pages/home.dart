import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:e_commerce/features/product/presentation/widgets/curved_rec_button.dart';
import 'package:e_commerce/features/product/presentation/widgets/filter_card.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _category = '';
  double _productValue = 0.0;

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
      body: BlocConsumer<ProductBloc, ProductState>(
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                        
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward_outlined),
                        onPressed: () {
                          final String searchValue = _searchController.text;
                          GoRouter.of(context)
                              .goNamed('searchResults', queryParameters: {
                            'searchQuery': searchValue,
                          });
                        },
                      ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 10
                              )
                            )
                          ),
                      
                        ),
                      ),
            
                     IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FilterCard(
                                  onFilter: (category, productValue) {
                                    _category = category;
                                    _productValue = productValue;
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.filter_alt),
                        ),
                    ],
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
                              GoRouter.of(context).goNamed('productDetail',
                                  pathParameters: {'id': product.id});
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
          backgroundColor: Color.fromRGBO(63, 81, 243, 1),
          shape: const CircleBorder(),
          onPressed: () {
            GoRouter.of(context).goNamed('addProduct');
          },
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}
