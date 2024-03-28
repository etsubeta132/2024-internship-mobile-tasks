import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:e_commerce/routes.dart';
import 'injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';



void main() async {
 await  di.init();
  runApp(const Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});
  

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (context) => ProductBloc(
          getOneProductUsecase: sl(), 
          addProductUsecase: sl(),
         updateProductUsecase: sl(), 
         deleteProductUsecase: sl(), 
         getproductsUsecase: sl()),

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //       fontFamily: 'Poppins',
  //     ),
  //    home:BlocProvider(
  //       create: (context) => ProductBloc(
  //         // Inject dependencies into the ProductBloc constructor
  //         getOneProductUsecase: sl(),
  //         addProductUsecase: sl(),
  //         updateProductUsecase: sl(),
  //         deleteProductUsecase: sl(),
  //         getproductsUsecase: sl(),
  //       ),
  //       child: ProductList(),
  //   ));
  // }
}
