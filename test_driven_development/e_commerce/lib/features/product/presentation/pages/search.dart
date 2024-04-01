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

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({super.key, required this.searchQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

   @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchAllProductsEvent(searchQuery: widget.searchQuery));
  }

  @override
  Widget build(BuildContext context) {
    
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM d,yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              GoRouter.of(context).goNamed('productList');
            },
          ),
          title: const Text('Search Result'),
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
    );
  }
  
}





