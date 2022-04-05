import '../../../../shared/utils/failure.dart';

abstract class LoginState {}

class LoginStateSuccess implements LoginState {}

class LoginStateFailure implements LoginState {
  final Failure error;
  LoginStateFailure({
    required this.error,
  });
}

class LoginStateLoading implements LoginState {}

class LoginStateEmpty implements LoginState {}

extension LoginStateExt on LoginState {
  when({
    Function? success,
    Function? failure,
    Function? loading,
    Function? empty,
    required Function orElse,
  }) {
    switch (runtimeType) {
      case LoginStateSuccess:
        {
          if (success != null) return success();
          return orElse();
        }
      case LoginStateFailure:
        {
          if (failure != null) return failure();
          return orElse();
        }

      case LoginStateLoading:
        {
          if (loading != null) return loading();
          return orElse();
        }
      case LoginStateEmpty:
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
