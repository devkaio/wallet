import 'package:mobx/mobx.dart';
import 'package:wallet/modules/home/repositories/home_repository.dart';

import 'start_state.dart';

part 'start_store.g.dart';

class StartStore = _StartStoreBase with _$StartStore;

abstract class _StartStoreBase with Store {
  final HomeRepository repository;
  _StartStoreBase({
    required this.repository,
  });
  @observable
  StartState state = StartStateEmpty();

  @action
  void update(StartState newState) {
    state = newState;
  }

  Future<void> getToken() async {
    update(StartStateLoading());
    final result = await repository.getToken();

    result.fold(
      (l) => update(StartStateFailure(error: l)),
      (r) => update(StartStateSuccess()),
    );
  }

  Future<void> getUserData({
    required String userId,
  }) async {}
}
