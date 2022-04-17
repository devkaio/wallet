import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';

import '../../utils/utils.dart';

export 'local_auth_impl.dart';
export 'utils/local_auth_messages.dart';

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
