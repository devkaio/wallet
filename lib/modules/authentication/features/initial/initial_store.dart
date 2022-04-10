import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage_impl.dart';
import 'package:wallet/shared/utils/failure.dart';

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

    final localTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');
    final newUserTokenId =
        await FirebaseAuth.instance.currentUser?.getIdToken();
    try {
      if (localTokenId == newUserTokenId) {
        update(InitialStateSuccess());
      } else {
        update(InitialStateFailure(
            error: Failure(
          status: 0,
          message: 'error',
          type: 'token_expired_error',
          exception: 'token',
        )));
      }
    } on FirebaseAuthException catch (e) {
      update(InitialStateFailure(
          error: Failure(
        status: 0,
        message: e.message ?? 'error',
        type: 'token_error',
        exception: e,
      )));
    }
  }
}
