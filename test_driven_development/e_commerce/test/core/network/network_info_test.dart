// import 'package:flutter_test/flutter_test.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:mockito/annotations.dart';

// import 'package:e_commerce/core/network/network_info.dart';
// import 'package:mockito/mockito.dart';

// import 'network_info_test.mocks.dart';


// @GenerateMocks([InternetConnectionChecker])
// void main() {
//   NetworkInfoImpl networkInfoImpl;
//   MockInternetConnectionChecker mockInternetConnectionChecker;

//   mockInternetConnectionChecker = MockInternetConnectionChecker();
//   networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);

//   group('isConnected', () {
//     test("should forward call to InternetConnectionChecker.hasConnection",
//         () async {
//       // arrange
//       when(mockInternetConnectionChecker.hasConnection)
//           .thenAnswer((_) async => true);

//       // act
//       final result = await networkInfoImpl.isConnected;

//       verify(mockInternetConnectionChecker.hasConnection);
//       expect(result, true);
//     });
//   });
// }
