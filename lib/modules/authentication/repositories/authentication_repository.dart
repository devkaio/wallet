import 'package:dartz/dartz.dart';

import '../../../shared/models/models.dart';
import '../../../shared/utils/utils.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Success<bool>>> authenticate();

  Future<Either<Failure, Success<AuthData>>> createAccount({
    required String email,
    required String password,
  });

  Future<Either<Failure, Success<AuthData>>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Success<TokenData>>> updateToken({
    required String refreshToken,
  });

  Future<Either<Failure, Success<UserData>>> getUserData({
    required String idToken,
  });
}
