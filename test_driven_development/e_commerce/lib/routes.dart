import 'package:e_commerce/features/product/presentation/pages/home.dart';
import 'package:e_commerce/features/product/presentation/pages/product_detail.dart';
import 'package:e_commerce/features/product/presentation/pages/product_add.dart';
import 'package:e_commerce/features/product/presentation/pages/product_edit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


GoRouter router = GoRouter(
  routes: [
    GoRoute(
        name: 'productList',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        }),
    GoRoute(
        name: 'addProduct',
        path: '/products/new',
        pageBuilder: (context, state) {
          return MaterialPage(child: ProductAdd());
        }),
    GoRoute(
        name: 'updateProduct',
        path: '/products/update/:id',
       pageBuilder: (context, state) {
          final String id = state.pathParameters['id']!;
          final Map<String, dynamic> params = state.uri.queryParameters;
          
          
          final double price = double.tryParse(params['price']) ?? 0;
          final String title = params['title'];
          final String category = params['category'];
          final String description = params['description'];
          final String image = params['image'];

          return MaterialPage(
            child: ProductEdit(
                  productId:id,
                  image: image,
                  initialTitle: title,
                  initialCategory: category,
                  initialPrice: price,
                  initialDescription:description,
        )
          );
        }),
    GoRoute(
        name: 'productDetail',
        path: '/products/:id',
        pageBuilder: (context, state) {
          final Map<String, dynamic> params = state.pathParameters;
          return MaterialPage(
            child: ProductDetail(
              productId: params['id'],
            ),
          );
        }),
  ],
);
