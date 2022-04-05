import 'package:wallet/shared/utils/failure.dart';

abstract class SplashState {}

class SplashStateSuccess implements SplashState {}

class SplashStateFailure implements SplashState {
  final Failure error;
  SplashStateFailure({
    required this.error,
  });
}

class SplashStateLoading implements SplashState {}

class SplashStateEmpty implements SplashState {}

extension SplashStateExt on SplashState {
  when({
    Function? success,
    Function? failure,
    Function? loading,
    Function? empty,
    required Function orElse,
  }) {
    switch (runtimeType) {
      case SplashStateSuccess:
        {
          if (success != null) return success();
          return orElse();
        }
      case SplashStateFailure:
        {
          if (failure != null) return failure();
          return orElse();
        }

      case SplashStateLoading:
        {
          if (loading != null) return loading();
          return orElse();
        }
      case SplashStateEmpty:
        {
          if (empty != null) return empty();
          return orElse();
        }
      default:
        {
          return orElse();
        }
    }
  }
}
