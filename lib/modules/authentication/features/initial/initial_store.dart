import 'package:mobx/mobx.dart';

import '../../repositories/authentication_repository.dart';
import 'initial_state.dart';

part 'initial_store.g.dart';

class InitialStore = _InitialStoreBase with _$InitialStore;

abstract class _InitialStoreBase with Store {
  final AuthenticationRepository repository;
  _InitialStoreBase({
    required this.repository,
  });
  @observable
  InitialState state = InitialStateEmpty();

  @action
  void update(InitialState newState) {
    state = newState;
  }

  @action
  Future<void> checkUserTokenId() async {
    update(InitialStateLoading());
    final result = await repository.authenticate();

    result.fold(
      (l) => update(InitialStateFailure(error: l)),
      (r) => update(InitialStateSuccess()),
    );
  }
}
