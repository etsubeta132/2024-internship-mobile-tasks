import 'package:e_commerce/core/network/network_info.dart';
import 'package:e_commerce/features/product/data/data_sources/product_local_data_source.dart';
import 'package:e_commerce/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/product/domain/usecases/add_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_one_product_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/get_products_usecase.dart';
import 'package:e_commerce/features/product/domain/usecases/update_product_usecase.dart';
import 'package:e_commerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  sl.registerFactory(() => ProductBloc(
      getOneProductUsecase: sl(),
      addProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl(),
      getproductsUsecase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetOneProductUseCase(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));

  //  Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSorce: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  await GetIt.instance.isReady<SharedPreferences>();
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
