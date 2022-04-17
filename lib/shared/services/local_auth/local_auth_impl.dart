import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../utils/utils.dart';
import 'local_auth.dart';

class LocalAuthImpl implements LocalAuth {
  @override
  Future<Either<Failure, Success<bool>>> authenticate({
    required LocalAuthentication auth,
  }) async {
    bool authenticate = await auth.authenticate(
      localizedReason: LocalAuthMessages().localizeReasonMessage(),
      useErrorDialogs: true,
      stickyAuth: true,
    );
    try {
      if (authenticate) {
        return Right(Success(true));
      } else {
        return Left(Failure(
          status: 0,
          message: 'nao authenticado',
          type: 'type',
          exception: 'exception',
        ));
      }
    } on PlatformException catch (e) {
      return Left(Failure(
        status: 0,
        message: LocalAuthMessages().authenticateErrorMessage(code: e.code),
        type: 'authenticate_error',
        exception: e,
      ));
    }
  }

  @override
  Future<Either<Failure, Success<List<BiometricType>>>> getAvaiableBiometrics({
    required LocalAuthentication auth,
  }) async {
    final _avaliableBiometrics = await auth.getAvailableBiometrics();
    try {
      if (_avaliableBiometrics.isNotEmpty) {
        return Right(Success(_avaliableBiometrics));
      } else {
        throw PlatformException;
      }
    } on PlatformException catch (e) {
      return Left(Failure(
        status: 0,
        message: e.message ?? 'erro',
        type: 'get_biometric_error',
        exception: e,
      ));
    }
  }

  @override
  Future<Either<Failure, Success<bool>>> isDeviceSupported({
    required LocalAuthentication auth,
  }) async {
    bool _isSupported = await auth.isDeviceSupported();

    try {
      if (_isSupported) {
        return Right(Success(true));
      } else {
        throw PlatformException;
      }
    } on PlatformException catch (e) {
      return Left(Failure(
        status: 0,
        message: e.message ?? 'erro',
        type: 'support_biometric_error',
        exception: e,
      ));
    }
  }
}
