import '../../../../shared/utils/failure.dart';

abstract class CreateAccountState {}

class CreateAccountStateSuccess implements CreateAccountState {}

class CreateAccountStateFailure implements CreateAccountState {
  final Failure error;
  CreateAccountStateFailure({
    required this.error,
  });
}

class CreateAccountStateLoading implements CreateAccountState {}

class CreateAccountStateEmpty implements CreateAccountState {}

extension CreateAccountStateExt on CreateAccountState {
  when({
    Function? success,
    Function? failure,
    Function? loading,
    Function? empty,
    required Function orElse,
  }) {
    switch (runtimeType) {
      case CreateAccountStateSuccess:
        {
          if (success != null) return success();
          return orElse();
        }
      case CreateAccountStateFailure:
        {
          if (failure != null) return failure();
          return orElse();
        }

      case CreateAccountStateLoading:
        {
          if (loading != null) return loading();
          return orElse();
        }
      case CreateAccountStateEmpty:
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
