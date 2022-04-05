import 'package:mobx/mobx.dart';

import '../../repositories/authentication_repository.dart';
import 'splash_state.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final AuthenticationRepository repository;

  _SplashStoreBase({required this.repository});

  @observable
  SplashState state = SplashStateEmpty();

  @action
  void update(SplashState newState) {
    state = newState;
  }

  Future<void> authenticate() async {
    update(SplashStateLoading());

    final response = await Future.delayed(
        const Duration(seconds: 2), () => repository.authenticate());

    response.fold(
      (l) => update(SplashStateFailure(error: l)),
      (r) => update(SplashStateSuccess()),
    );
  }
}
