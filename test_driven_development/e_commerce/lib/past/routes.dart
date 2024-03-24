import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:e_commerce/past/Widgets/product_form.dart';
import 'package:e_commerce/past/Screens/product_detail.dart';
import 'package:e_commerce/past/Screens/product_list.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
        name: 'productList',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProductList());
        }),
    GoRoute(
        name: 'addProduct',
        path: '/new',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProductForm());
        }),
    GoRoute(
        name: 'updateProduct',
        path: '/update',
       pageBuilder: (context, state) {
          final Map<String, dynamic> params = state.uri.queryParameters;
          // final String imageUrl = params['imageUrl'];
          // final double rating = double.tryParse(params['rating']) ?? 0.0;
          final double price = double.tryParse(params['price']) ?? 0;
          final String name = params['name'];
          final String category = params['category'];
          final String description = params['description'];
          return MaterialPage(
            child: ProductForm(
                  initialName: name,
                  initialCategory: category,
                  initialPrice: price,
                  initialDescription:description,
                  // initialImagePath:imageUrl,
        )
          );
        }),
    GoRoute(
        name: 'productDetail',
        path: '/detail',
        pageBuilder: (context, state) {
          final Map<String, dynamic> params = state.uri.queryParameters;
          final String imageUrl = params['imageUrl'];
          final double rating = double.tryParse(params['rating']) ?? 0.0;
          final double price = double.tryParse(params['price']) ?? 0;
          final String name = params['name'];
          final String category = params['category'];
          final String description = params['description'];

          return MaterialPage(
            child: ProductDetail(
              imageUrl: imageUrl,
              rating: rating,
              price: price,
              name: name,
              category: category,
              description: description,
            ),
          );
        }),
  ],
);
