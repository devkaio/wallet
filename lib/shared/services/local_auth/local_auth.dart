import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wallet/shared/utils/failure.dart';
import 'package:wallet/shared/utils/success.dart';

abstract class LocalAuth {
  Future<Either<Failure, Success<bool>>> isDeviceSupported({
    required LocalAuthentication auth,
  });
  Future<Either<Failure, Success<List<BiometricType>>>> getAvaiableBiometrics({
    required LocalAuthentication auth,
  });
  Future<Either<Failure, Success<bool>>> authenticate({
    required LocalAuthentication auth,
  });
}
