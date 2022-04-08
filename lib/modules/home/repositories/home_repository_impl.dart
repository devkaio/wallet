import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/modules/home/repositories/home_repository.dart';
import 'package:wallet/shared/utils/failure.dart';
import 'package:wallet/shared/utils/success.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, Success<bool>>> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Success<String>>> getToken() async {
    try {
      final String idToken =
          await FirebaseAuth.instance.currentUser!.getIdToken();
      if (idToken.isNotEmpty) {
        return Right(Success(idToken));
      } else {
        return Left(Failure(
            exception: 'error',
            message: 'erro id token',
            status: 0,
            type: 'error'));
      }
    } catch (e) {
      return Left(Failure(
          exception: e, message: 'erro id token', status: 0, type: 'error'));
    }
  }
}