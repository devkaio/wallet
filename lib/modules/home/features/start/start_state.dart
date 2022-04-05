import '../../../../shared/utils/failure.dart';

abstract class StartState {}

class StartStateSuccess implements StartState {}

class StartStateFailure implements StartState {
  final Failure error;
  StartStateFailure({
    required this.error,
  });
}

class StartStateLoading implements StartState {}

class StartStateEmpty implements StartState {}

extension StartStateExt on StartState {
  when({
    Function? success,
    Function? failure,
    Function? loading,
    Function? empty,
    required Function orElse,
  }) {
    switch (runtimeType) {
      case StartStateSuccess:
        {
          if (success != null) return success();
          return orElse();
        }
      case StartStateFailure:
        {
          if (failure != null) return failure();
          return orElse();
        }

      case StartStateLoading:
        {
          if (loading != null) return loading();
          return orElse();
        }
      case StartStateEmpty:
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
