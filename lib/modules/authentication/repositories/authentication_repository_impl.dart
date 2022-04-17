import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/modules/authentication/features/login/utils/login_error.dart';
import 'package:wallet/shared/models/firebase_error.dart';

import '../../../firebase_options.dart';
import '../../../shared/models/models.dart';
import '../../../shared/services/services.dart';
import '../../../shared/utils/utils.dart';
import 'authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final HttpService httpService;
  AuthenticationRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Either<Failure, Success<bool>>> authenticate() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return Right(Success(true));
    } on DioError catch (e) {
      return Left(
        Failure(
          exception: e,
          message: e.message,
          status: 0,
          type: 'Error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success<AuthData>>> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpService.post(
        url: '/accounts:signUp',
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      );

      if (response.statusCode == 200) {
        return Right(Success(AuthData.fromMap(response.data)));
      } else {
        return Left(Failure(
          status: 0,
          message: 'Erro ao criar conta',
          type: 'Error',
          exception: 'Error',
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        status: FirebaseError.fromJson(e.response?.data).error?.code ?? 0,
        message: LoginError().errorMessage(
            code: FirebaseError.fromJson(e.response?.data).error?.message ??
                'erro'),
        type: runtimeType.toString(),
        exception: 'create_account_error',
      ));
    }
  }

  @override
  Future<Either<Failure, Success<AuthData>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await httpService.post(
        url: '/accounts:signInWithPassword',
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      );

      if (response.statusCode == 200) {
        return Right(Success(AuthData.fromMap(response.data)));
      } else {
        return Left(Failure(
          exception: 'error',
          message: 'erro ao logar',
          status: 0,
          type: 'Error',
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        status: FirebaseError.fromJson(e.response?.data).error?.code ?? 0,
        message: LoginError().errorMessage(
            code: FirebaseError.fromJson(e.response?.data).error?.message ??
                'erro'),
        type: 'runtimeType.toString()',
        exception: 'login_error',
      ));
    }
  }

  @override
  Future<Either<Failure, Success<TokenData>>> updateToken({
    required String refreshToken,
  }) async {
    try {
      final response = await httpService.post(
        url: '/token',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        return Right(Success(TokenData.fromMap(response.data)));
      } else {
        return Left(Failure(
          exception: 'error',
          message: 'erro ao atualizar token',
          status: 0,
          type: 'Error',
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        status: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'erro',
        type: runtimeType.toString(),
        exception: 'update_token_error',
      ));
    }
  }

  @override
  Future<Either<Failure, Success<UserData>>> getUserData({
    required String idToken,
  }) async {
    try {
      final response = await httpService.post(
        url: '/accounts:lookup',
        data: {'idToken': idToken},
      );
      if (response.statusCode == 200) {
        return Right(Success(UserData.fromMap(response.data)));
      } else {
        return Left(Failure(
          exception: 'error',
          message: 'erro ao atualizar token',
          status: 0,
          type: 'Error',
        ));
      }
    } on DioError catch (e) {
      return Left(Failure(
        status: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'erro',
        type: runtimeType.toString(),
        exception: 'get_user_info_error',
      ));
    }
  }
}
