import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/modules/authentication/features/login/utils/login_error.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';
import 'package:wallet/shared/models/user.dart';
import 'package:wallet/shared/utils/failure.dart';
import 'package:wallet/shared/utils/success.dart';

import '../../../firebase_options.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<Failure, Success<bool>>> authenticate() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return Right(Success(true));
    } on FirebaseException catch (e) {
      return Left(
        Failure(
          exception: e,
          message: e.message ?? 'erro',
          status: 0,
          type: 'Error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success<bool>>> createAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('users');
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _users.doc().set(UserData(
            name: userName,
            email: email,
            userId: userCredential.user?.uid ?? '0',
          ).toMap());

      if (userCredential.user != null) {
        return Right(Success(true));
      } else {
        return Left(Failure(
          status: 0,
          message: 'Erro ao criar conta',
          type: 'Error',
          exception: 'Error',
        ));
      }
    } on FirebaseException catch (e) {
      return Left(Failure(
        status: 0,
        message: e.message ?? 'erro',
        type: e.code,
        exception: 'Error',
      ));
    }
  }

  @override
  Future<Either<Failure, Success<UserCredential>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user?.uid != null) {
        return Right(Success(userCredential));
      } else {
        return Left(Failure(
          exception: 'error',
          message: 'erro ao logar',
          status: 0,
          type: 'Error',
        ));
      }
    } on FirebaseAuthException catch (e) {
      return Left(Failure(
        exception: e.code,
        message: LoginError().errorMessage(code: e.code),
        status: 0,
        type: 'login_error',
      ));
    }
  }
}
