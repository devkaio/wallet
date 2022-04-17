import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/app_controller.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_state.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';
import 'package:wallet/shared/utils/utils.dart';

import '../../../../shared/models/models.dart';
import '../../../../shared/services/local_secure_storage/auth_data_storage_impl.dart';

part 'create_account_store.g.dart';

class CreateAccountStore = _CreateAccountStoreBase with _$CreateAccountStore;

abstract class _CreateAccountStoreBase with Store {
  final AuthenticationRepository repository;
  _CreateAccountStoreBase({
    required this.repository,
  });

  UserData? userData;

  @observable
  CreateAccountState state = CreateAccountStateEmpty();

  @action
  void update(CreateAccountState newState) {
    state = newState;
  }

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    update(CreateAccountStateLoading());
    try {
      final result = await repository.createAccount(
        email: email,
        password: password,
      );
      result.fold(
        (l) => update(CreateAccountStateFailure(error: l)),
        (r) async {
          Modular.get<AppController>().authData = r.data;

          final String idToken = r.data.idToken!;
          final String refreshToken = r.data.refreshToken!;

          await AuthDataStorageImpl().setTokenId(
            tokenIdKey: 'tokenIdKey',
            tokenId: idToken,
          );
          await AuthDataStorageImpl().setRefreshToken(
            refreshTokenKey: 'refreshTokenKey',
            refreshToken: refreshToken,
          );
          await getUserData();

          update(CreateAccountStateSuccess());
        },
      );
    } on Failure catch (e) {
      update(CreateAccountStateFailure(error: e));
    }
  }

  Future<void> getUserData() async {
    final localTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');

    final result = await repository.getUserData(
      idToken: localTokenId!,
    );

    result.fold(
      (l) {
        return Future.error(l);
      },
      (r) {
        userData = r.data;
      },
    );
  }
}
