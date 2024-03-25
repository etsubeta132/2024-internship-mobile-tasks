import 'dartz/dartz.dart';

void main(){
  InputConverter inputConverter = InputConverter();
  group(
    "stringToDouble",
    () {
      test(
        "should return a valid double when strig is given",
        ()async {
          
          // arrange
          final str = '10.5'
          
          // act
          final result = inputConverter.stringToDouble(str);
          
        // assert
          expect(result,Right(10.5));  
        },
      );
    },
  );

}