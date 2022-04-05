import '../../../../shared/utils/failure.dart';

abstract class InitialState {}

class InitialStateSuccess implements InitialState {}

class InitialStateFailure implements InitialState {
  final Failure error;
  InitialStateFailure({
    required this.error,
  });
}

class InitialStateLoading implements InitialState {}

class InitialStateEmpty implements InitialState {}

extension InitialStateExt on InitialState {
  when({
    Function? success,
    Function? failure,
    Function? loading,
    Function? empty,
    required Function orElse,
  }) {
    switch (runtimeType) {
      case InitialStateSuccess:
        {
          if (success != null) return success();
          return orElse();
        }
      case InitialStateFailure:
        {
          if (failure != null) return failure();
          return orElse();
        }

      case InitialStateLoading:
        {
          if (loading != null) return loading();
          return orElse();
        }
      case InitialStateEmpty:
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
