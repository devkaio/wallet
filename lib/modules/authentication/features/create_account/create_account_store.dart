import 'package:mobx/mobx.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_state.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';

part 'create_account_store.g.dart';

class CreateAccountStore = _CreateAccountStoreBase with _$CreateAccountStore;

abstract class _CreateAccountStoreBase with Store {
  final AuthenticationRepository repository;
  _CreateAccountStoreBase({
    required this.repository,
  });

  @observable
  CreateAccountState state = CreateAccountStateEmpty();

  @action
  void update(CreateAccountState newState) {
    state = newState;
  }

  Future<void> createAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    update(CreateAccountStateLoading());
    final result = await repository.createAccount(
      userName: userName,
      email: email,
      password: password,
    );
    result.fold(
      (l) => update(CreateAccountStateFailure(error: l)),
      (r) => update(CreateAccountStateSuccess()),
    );
  }
}
