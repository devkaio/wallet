import 'package:dartz/dartz.dart';
import 'package:wallet/shared/utils/failure.dart';
import 'package:wallet/shared/utils/success.dart';

abstract class HomeRepository {
  Future<Either<Failure, Success<bool>>> getUserData();

  Future<Either<Failure, Success<String>>> getToken();
}
