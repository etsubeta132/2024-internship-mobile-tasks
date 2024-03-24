import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/network/network_info.dart';
import 'package:e_commerce/features/product/data/data_sources/product_local_data_source.dart';
import 'package:e_commerce/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource])
@GenerateMocks([ProductLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  final mockRemoteDataSource = MockProductRemoteDataSource();
  final mockLocalDataSource = MockProductLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();

  final repositoryImpl = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSorce: mockLocalDataSource,
      networkInfo: mockNetworkInfo);

  void runTestOnline(Function body) {
    group("getProducts ", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group("getProducts ", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("getProducts", () {
    const tid = '25131570-9733-4d42-8ff1-56bd8d2a8e9a';
    final tProductModelList = [
      ProductModel(
          id: tid,
          imageUrl: "",
          rating: 0.0,
          price: 0.0,
          name: "name",
          category: "category",
          description: "description")
    ];

    // final tProduct = tProductModelList;

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => tProductModelList);

        // act
        final result = await repositoryImpl.getProducts();

        // assert
        verify(mockRemoteDataSource.getProducts());
        expect(result, equals(Right(tProductModelList)));
      });
    });

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => tProductModelList);

        // act
        final result = await repositoryImpl.getProducts();

        // assert
        verify(mockRemoteDataSource.getProducts());
        verify(mockLocalDataSource.catchLocalProducts(tProductModelList));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOneProduct(tid))
            .thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getOneProduct(tid);

        // assert
        verify(mockRemoteDataSource.getOneProduct(tid));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });


//   group("getProducts ", () {
//     const tid = '25131570-9733-4d42-8ff1-56bd8d2a8e9a';
//     final tProductModelList = [
//       ProductModel(
//           id: tid,
//           imageUrl: "",
//           rating: 0.0,
//           price: 0.0,
//           name: "name",
//           category: "category",
//           description: "description")
//     ];

//     // runTestsOnline(() {

//     // });

//     test(
//       'should return server error when the call to remote data source is unsuccessful',
//       () async {
//         // Arrange
//         when(mockRemoteDataSource.getProducts()).thenThrow(ServerException());
//         when(mockLocalDataSource.catchLocalProducts(any))
//             .thenAnswer((_) async {});

//         // Act
//         final result = await repositoryImpl.getProducts();

//         // Assert
//         verify(mockRemoteDataSource.getProducts());
//         // verifyZeroInteractions(mockLocalDataSource);
//         expect(result, equals(Left(ServerFailure())));
//       },
//     );
//   });

//   group("device is offline ", () {
//     const tid = '25131570-9733-4d42-8ff1-56bd8d2a8e9a';
//     final tProductModelList = [
//       ProductModel(
//           id: tid,
//           imageUrl: "",
//           rating: 0.0,
//           price: 0.0,
//           name: "name",
//           category: "category",
//           description: "description")
//     ];
//     test('should return local data when catch data present ', () async {
//       //  arange
//       when(mockLocalDataSource.getLocalProducts())
//           .thenAnswer((_) async => tProductModelList);

//       // act
//       final result = await repositoryImpl.getProducts();

//       //  assert
//       verifyZeroInteractions(mockRemoteDataSource);
//       verify(mockLocalDataSource.getLocalProducts());
//       expect(result, equals(Right(tProductModelList)));
//     });

//     test('should return cache exception  when catch data not found ', () async {
//       //  arange
//       when(mockLocalDataSource.getLocalProducts())
//           .thenThrow(CacheException());

//       // act
//       final result = await repositoryImpl.getProducts();

//       //  assert
//       verifyZeroInteractions(mockRemoteDataSource);
//       verify(mockLocalDataSource.getLocalProducts());
//       expect(result, equals(Left(CacheFailure())));
//     });

// runTestsOnline(() {
//       test(
//         'should return remote data when the call to remote data source is successful',
//         () async {
//           // arrange
//           final List<ProductModel> remoteProducts = [
//             tProductModel
//           ]; // Sample remote products
//           when(mockRemoteDataSource.getProducts())
//               .thenAnswer((_) async => remoteProducts);
//           // act
//           final result = await repository.getProducts();
//           // assert
//           verify(mockRemoteDataSource.getProducts());
//           expect(result, equals(Right(remoteProducts)));
//         },
//       );

//       test(
//         'should cache the data locally when the call to remote data source is successful',
//         () async {
//           // arrange
//           final List<ProductModel> remoteProducts = [tProductModel]; // Sample remote products
//           when(mockRemoteDataSource.getProducts())
//               .thenAnswer((_) async => remoteProducts);
//           // act
//           await repository.getProducts();
//           // assert
//           verify(mockRemoteDataSource.getProducts());
//           verify(mockProductLocalDataSource.getAvalableProducts());
//         },
//       );

//         test(
//           'should return server failure when the call to remote data source is unsuccessful',
//           () async {
//             // arrange
//             when(mockRemoteDataSource.getProducts())
//                 .thenThrow(ServerException());
//             // act
//             final result = await repository.getProducts();
//             // assert
//             verify(mockRemoteDataSource.getProducts());
//             expect(result, equals(Left(ServerFailure())));
//           },
//         );
//       });

//       runTestsOffline(() {
//         test(
//           'should return last locally cached data when the cached data is present',
//           () async {
//             // arrange
//             final List<ProductModel> cachedProducts = [tProductModel]; // Sample cached products
//             when(mockProductLocalDataSource.getAvailableProducts())
//                 .thenAnswer((_) async => cachedProducts);
//             // act
//             final result = await repository.getProducts();
//             // assert
//             verify(mockProductLocalDataSource.getAvailableProducts());
//             expect(result, equals(Right(cachedProducts)));
//           },
//         );

//       test(
//         'should return CacheFailure when there is no cached data present',
//         () async {
//           // arrange
//           when(mockProductLocalDataSource.getAvailableProducts())
//               .thenThrow(CacheException());
//           // act
//           final result = await repository.getProducts();
//           // assert
//           verify(mockProductLocalDataSource.getAvailableProducts());
//           expect(result, equals(Left(CacheFailure())));
//         },
//       );
//     });
//   });
// }

//   });
}
