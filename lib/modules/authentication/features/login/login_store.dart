import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';

import 'login_state.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthenticationRepository repository;
  _LoginStoreBase({
    required this.repository,
  });

  UserCredential? userCredential;

  @observable
  LoginState state = LoginStateEmpty();

  @action
  void update(LoginState newState) {
    state = newState;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    update(LoginStateLoading());
    final result = await repository.login(
      email: email,
      password: password,
    );

    result.fold(
      (l) => update(LoginStateFailure(error: l)),
      (r) {
        userCredential = r.data;
        update(LoginStateSuccess());
      },
    );
  }
}
