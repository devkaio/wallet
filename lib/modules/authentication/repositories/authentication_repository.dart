import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/shared/utils/failure.dart';
import 'package:wallet/shared/utils/success.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Success<bool>>> authenticate();

  Future<Either<Failure, Success<bool>>> createAccount({
    required String userName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Success<UserCredential>>> login({
    required String email,
    required String password,
  });
}
